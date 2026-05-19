package com.blog.servlet.admin;

import com.auth0.jwt.JWT;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.blog.dao.OidcSettingDao;
import com.blog.dao.UserDao;
import com.blog.model.OidcSetting;
import com.blog.model.User;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

public class OidcCallbackServlet extends HttpServlet {

    private final OidcSettingDao oidcSettingDao = new OidcSettingDao();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String state = req.getParameter("state");
        String error = req.getParameter("error");

        // Determine error redirect based on binding mode
        Boolean isBinding = (Boolean) req.getSession().getAttribute("oidc_binding");
        String errorRedirect = Boolean.TRUE.equals(isBinding)
                ? req.getContextPath() + "/admin/settings?error="
                : req.getContextPath() + "/admin/login?error=";

        if (error != null) {
            resp.sendRedirect(errorRedirect + URLEncoder.encode(error, StandardCharsets.UTF_8));
            return;
        }

        // Verify state
        String savedState = (String) req.getSession().getAttribute("oidc_state");
        if (savedState == null || !savedState.equals(state)) {
            resp.sendRedirect(errorRedirect + URLEncoder.encode("Invalid state parameter", StandardCharsets.UTF_8));
            return;
        }
        req.getSession().removeAttribute("oidc_state");

        if (StringUtil.isEmpty(code)) {
            resp.sendRedirect(errorRedirect + URLEncoder.encode("No authorization code", StandardCharsets.UTF_8));
            return;
        }

        try {
            OidcSetting setting = oidcSettingDao.findEnabled();
            if (setting == null) {
                resp.sendRedirect(errorRedirect + URLEncoder.encode("OIDC 未配置", StandardCharsets.UTF_8));
                return;
            }

            // Exchange code for tokens
            String issuerUrl = setting.getIssuerUrl().replaceAll("/$", "");
            String tokenEndpoint = issuerUrl + "/protocol/openid-connect/token";
            if (!issuerUrl.contains("/protocol/")) {
                tokenEndpoint = issuerUrl + "/token";
            }

            String formBody = "grant_type=authorization_code" +
                    "&code=" + URLEncoder.encode(code, StandardCharsets.UTF_8) +
                    "&redirect_uri=" + URLEncoder.encode(setting.getRedirectUri(), StandardCharsets.UTF_8) +
                    "&client_id=" + URLEncoder.encode(setting.getClientId(), StandardCharsets.UTF_8) +
                    "&client_secret=" + URLEncoder.encode(setting.getClientSecret(), StandardCharsets.UTF_8);

            HttpClient httpClient = HttpClient.newHttpClient();
            HttpRequest tokenRequest = HttpRequest.newBuilder()
                    .uri(URI.create(tokenEndpoint))
                    .header("Content-Type", "application/x-www-form-urlencoded")
                    .POST(HttpRequest.BodyPublishers.ofString(formBody))
                    .build();

            HttpResponse<String> tokenResponse = httpClient.send(tokenRequest, HttpResponse.BodyHandlers.ofString());

            if (tokenResponse.statusCode() != 200) {
                resp.sendRedirect(errorRedirect + URLEncoder.encode("Token exchange failed: " + tokenResponse.statusCode(), StandardCharsets.UTF_8));
                return;
            }

            // Parse the JSON response to get id_token
            String responseBody = tokenResponse.body();
            String idToken = extractJsonValue(responseBody, "id_token");

            if (StringUtil.isEmpty(idToken)) {
                resp.sendRedirect(errorRedirect + URLEncoder.encode("No id_token in response", StandardCharsets.UTF_8));
                return;
            }

            // Decode the ID token (without verification for simplicity - in production, verify signature)
            DecodedJWT jwt = JWT.decode(idToken);
            String subject = jwt.getSubject();
            String email = jwt.getClaim("email").asString();
            String name = jwt.getClaim("name").asString();
            String preferredUsername = jwt.getClaim("preferred_username").asString();

            // Check if this is an OIDC binding request
            Boolean binding = (Boolean) req.getSession().getAttribute("oidc_binding");
            if (Boolean.TRUE.equals(binding)) {
                req.getSession().removeAttribute("oidc_binding");
                User loginUser = (User) req.getSession().getAttribute("loginUser");
                if (loginUser != null) {
                    // Bind OIDC subject to current user
                    userDao.updateOidcSubject(loginUser.getId(), subject);
                    loginUser.setOidcSubject(subject);
                    req.getSession().setAttribute("loginUser", loginUser);
                    resp.sendRedirect(req.getContextPath() + "/admin/settings?success=oidcBound");
                    return;
                }
                // If not logged in, fall through to normal login
            }

            // Normal login flow: find by OIDC subject first, then by username
            User user = userDao.findByOidcSubject(subject);

            if (user == null) {
                String username = preferredUsername != null ? preferredUsername : (email != null ? email : subject);
                user = userDao.findByUsername(username);

                if (user == null) {
                    // Auto-create user from OIDC identity
                    user = new User();
                    user.setUsername(username);
                    user.setPassword(StringUtil.sha256(UUID.randomUUID().toString())); // Random unusable password
                    user.setNickname(name != null ? name : username);
                    user.setEmail(email);
                    user.setBio("OIDC user");
                    user.setOidcSubject(subject);
                    user.setRole("editor");
                    int userId = userDao.insert(user);
                    user.setId(userId);
                } else {
                    // Existing user found by username, link OIDC subject
                    userDao.updateOidcSubject(user.getId(), subject);
                    user.setOidcSubject(subject);
                }
            }

            // Set session
            req.getSession().setAttribute("loginUser", user);
            resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");

        } catch (Exception e) {
            resp.sendRedirect(errorRedirect + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
        }
    }

    private String extractJsonValue(String json, String key) {
        String search = "\"" + key + "\"";
        int idx = json.indexOf(search);
        if (idx < 0) return null;
        idx = json.indexOf(":", idx);
        if (idx < 0) return null;
        idx++;
        while (idx < json.length() && json.charAt(idx) == ' ') idx++;
        if (idx >= json.length()) return null;
        if (json.charAt(idx) == '"') {
            int end = json.indexOf('"', idx + 1);
            if (end < 0) return null;
            return json.substring(idx + 1, end);
        }
        int end = json.indexOf(',', idx);
        if (end < 0) end = json.indexOf('}', idx);
        if (end < 0) return null;
        return json.substring(idx, end).trim();
    }

}
