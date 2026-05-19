package com.blog.servlet.admin;

import com.blog.dao.MessageDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MessageManageServlet extends HttpServlet {

    private final MessageDao messageDao = new MessageDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int pageNum = 1;
            int pageSize = 10;
            String pageStr = req.getParameter("pageNum");
            if (pageStr != null) pageNum = Integer.parseInt(pageStr);
            int totalCount = messageDao.getTotalCount();
            int totalPages = (totalCount + pageSize - 1) / pageSize;
            if (pageNum < 1) pageNum = 1;
            if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
            req.setAttribute("messages", messageDao.findAll(pageNum, pageSize));
            req.setAttribute("pageNum", pageNum);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalCount", totalCount);
            req.getRequestDispatcher("/admin/messageList.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("delete".equals(action)) {
                messageDao.delete(Integer.parseInt(req.getParameter("id")));
            }
            resp.sendRedirect(req.getContextPath() + "/admin/message");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
