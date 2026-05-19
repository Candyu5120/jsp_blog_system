package com.blog.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();

        // Exclude login page and OIDC endpoints
        if (uri.equals(contextPath + "/admin/login")
                || uri.startsWith(contextPath + "/admin/oidc/login")
                || uri.startsWith(contextPath + "/admin/oidc/callback")) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loginUser") != null) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(contextPath + "/admin/login");
        }
    }

    @Override
    public void destroy() {}
}
