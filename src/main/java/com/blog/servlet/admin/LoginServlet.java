package com.blog.servlet.admin;

import com.blog.dao.OidcSettingDao;
import com.blog.dao.UserDao;
import com.blog.model.OidcSetting;
import com.blog.model.User;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();
    private final OidcSettingDao oidcSettingDao = new OidcSettingDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            OidcSetting oidc = oidcSettingDao.findEnabled();
            req.setAttribute("oidcEnabled", oidc != null);
            if (oidc != null) {
                req.setAttribute("oidcProviderName", oidc.getProviderName());
            }
        } catch (Exception e) {
            req.setAttribute("oidcEnabled", false);
        }
        req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (StringUtil.isEmpty(username) || StringUtil.isEmpty(password)) {
            req.setAttribute("error", "用户名和密码不能为空");
            doGet(req, resp);
            return;
        }

        try {
            String hashed = StringUtil.sha256(password);
            User user = userDao.findByUsernameAndPassword(username, hashed);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("loginUser", user);
                resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
            } else {
                req.setAttribute("error", "用户名或密码错误");
                doGet(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "登录失败：" + e.getMessage());
            doGet(req, resp);
        }
    }
}
