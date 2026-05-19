package com.blog.servlet.admin;

import com.blog.dao.OidcSettingDao;
import com.blog.model.OidcSetting;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class OidcSettingManageServlet extends HttpServlet {

    private final OidcSettingDao oidcSettingDao = new OidcSettingDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            OidcSetting setting = oidcSettingDao.findFirst();
            req.setAttribute("setting", setting);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/admin/oidcSetting.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String action = req.getParameter("action");

            if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                // There's no delete in the DAO, so we just disable it
                OidcSetting s = oidcSettingDao.findById(id);
                if (s != null) {
                    s.setEnabled(0);
                    oidcSettingDao.update(s);
                }
            } else {
                // Save or update
                String idStr = req.getParameter("id");
                OidcSetting setting = new OidcSetting();
                setting.setProviderName(req.getParameter("providerName"));
                setting.setIssuerUrl(req.getParameter("issuerUrl"));
                setting.setClientId(req.getParameter("clientId"));
                setting.setClientSecret(req.getParameter("clientSecret"));
                setting.setRedirectUri(req.getParameter("redirectUri"));
                setting.setScope(req.getParameter("scope"));
                setting.setEnabled("on".equals(req.getParameter("enabled")) ? 1 : 0);

                if (idStr != null && !idStr.isEmpty()) {
                    setting.setId(Integer.parseInt(idStr));
                    oidcSettingDao.update(setting);
                } else {
                    oidcSettingDao.insert(setting);
                }
            }

            resp.sendRedirect(req.getContextPath() + "/admin/oidc/setting?success=1");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }
}
