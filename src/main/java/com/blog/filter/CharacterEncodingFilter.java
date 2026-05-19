package com.blog.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        
        if (request instanceof jakarta.servlet.http.HttpServletRequest) {
            String path = ((jakarta.servlet.http.HttpServletRequest) request).getRequestURI();
            if (!path.matches(".*\\.(css|js|woff|woff2|ttf|png|jpg|jpeg|gif|ico|svg)$")) {
                response.setCharacterEncoding("UTF-8");
            }
        } else {
            response.setCharacterEncoding("UTF-8");
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
