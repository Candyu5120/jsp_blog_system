package com.blog.servlet.admin;

import com.blog.dao.CommentDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CommentManageServlet extends HttpServlet {

    private final CommentDao commentDao = new CommentDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int pageNum = 1;
            int pageSize = 10;
            String pageStr = req.getParameter("pageNum");
            if (pageStr != null) pageNum = Integer.parseInt(pageStr);
            int totalCount = commentDao.getTotalCount();
            int totalPages = (totalCount + pageSize - 1) / pageSize;
            if (pageNum < 1) pageNum = 1;
            if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
            req.setAttribute("comments", commentDao.findAll(pageNum, pageSize));
            req.setAttribute("pageNum", pageNum);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalCount", totalCount);
            req.getRequestDispatcher("/admin/commentList.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("delete".equals(action)) {
                commentDao.delete(Integer.parseInt(req.getParameter("id")));
            }
            resp.sendRedirect(req.getContextPath() + "/admin/comment");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
