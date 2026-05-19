package com.blog.servlet.admin;

import com.blog.dao.OidcSettingDao;
import com.blog.model.OidcSetting;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

public class OidcLoginServlet extends HttpServlet {

    private final OidcSettingDao oidcSettingDao = new OidcSettingDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean isBinding = "true".equals(req.getParameter("binding"));
        boolean isLoggedIn = req.getSession(false) != null && req.getSession().getAttribute("loginUser") != null;
        String errorRedirect = (isBinding && isLoggedIn)
                ? req.getContextPath() + "/admin/settings?error="
                : req.getContextPath() + "/admin/login?error=";

        try {
            OidcSetting setting = oidcSettingDao.findEnabled();
            if (setting == null) {
                resp.sendRedirect(errorRedirect + URLEncoder.encode("OIDC 未配置", StandardCharsets.UTF_8));
                return;
            }

            // Generate state parameter for CSRF protection
            String state = UUID.randomUUID().toString();
            req.getSession().setAttribute("oidc_state", state);

            if (isBinding) {
                req.getSession().setAttribute("oidc_binding", true);
            }

            // Construct authorization URL
            String issuerUrl = setting.getIssuerUrl().replaceAll("/$", "");
            String authEndpoint = issuerUrl + "/protocol/openid-connect/auth";
            if (!issuerUrl.contains("/protocol/")) {
                authEndpoint = issuerUrl + "/authorize";
            }

            String redirectUri = URLEncoder.encode(setting.getRedirectUri(), StandardCharsets.UTF_8);
            String clientId = URLEncoder.encode(setting.getClientId(), StandardCharsets.UTF_8);
            String scope = URLEncoder.encode(setting.getScope(), StandardCharsets.UTF_8);

            String authUrl = authEndpoint +
                    "?client_id=" + clientId +
                    "&redirect_uri=" + redirectUri +
                    "&response_type=code" +
                    "&scope=" + scope +
                    "&state=" + state;

            resp.sendRedirect(authUrl);
        } catch (Exception e) {
            resp.sendRedirect(errorRedirect + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
        }
    }
}
