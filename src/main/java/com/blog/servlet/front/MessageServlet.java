package com.blog.servlet.front;

import com.blog.dao.MessageDao;
import com.blog.model.Message;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MessageServlet extends HttpServlet {

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

            req.getRequestDispatcher("/guestbook.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String visitorName = req.getParameter("visitorName");
            String visitorEmail = req.getParameter("visitorEmail");
            String content = req.getParameter("content");

            if (!StringUtil.isEmpty(visitorName) && !StringUtil.isEmpty(content)) {
                Message msg = new Message();
                msg.setVisitorName(visitorName);
                msg.setVisitorEmail(visitorEmail);
                msg.setContent(content);
                msg.setIpAddress(req.getRemoteAddr());
                messageDao.insert(msg);
            }
            resp.sendRedirect(req.getContextPath() + "/message");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
