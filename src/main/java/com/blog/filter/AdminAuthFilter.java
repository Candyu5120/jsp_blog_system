package com.blog.filter;

import com.blog.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

public class AdminAuthFilter implements Filter {

    private static final Set<String> ADMIN_ONLY_PATHS = Set.of(
            "/admin/user",
            "/admin/oidc/setting",
            "/admin/friendLink"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();

        if (uri.equals(contextPath + "/admin/login")
                || uri.startsWith(contextPath + "/admin/oidc/login")
                || uri.startsWith(contextPath + "/admin/oidc/callback")) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(contextPath + "/admin/login");
            return;
        }

        User user = (User) session.getAttribute("loginUser");
        String role = user.getRole();

        if ("admin".equals(role)) {
            chain.doFilter(req, res);
            return;
        }

        for (String adminPath : ADMIN_ONLY_PATHS) {
            if (uri.equals(contextPath + adminPath) || uri.startsWith(contextPath + adminPath + "/")) {
                response.sendRedirect(contextPath + "/admin/index.jsp");
                return;
            }
        }

        chain.doFilter(req, res);
    }

    @Override
    public void destroy() {}
}
