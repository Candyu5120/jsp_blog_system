package com.blog.servlet.front;

import com.blog.dao.CommentDao;
import com.blog.model.Comment;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CommentServlet extends HttpServlet {

    private final CommentDao commentDao = new CommentDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int articleId = Integer.parseInt(req.getParameter("articleId"));
            String visitorName = req.getParameter("visitorName");
            String visitorEmail = req.getParameter("visitorEmail");
            String content = req.getParameter("content");

            if (StringUtil.isEmpty(visitorName) || StringUtil.isEmpty(content)) {
                resp.sendRedirect(req.getContextPath() + "/article?id=" + articleId);
                return;
            }

            Comment comment = new Comment();
            comment.setArticleId(articleId);
            comment.setVisitorName(visitorName);
            comment.setVisitorEmail(visitorEmail);
            comment.setContent(content);
            comment.setIpAddress(req.getRemoteAddr());

            commentDao.insert(comment);
            resp.sendRedirect(req.getContextPath() + "/article?id=" + articleId + "#comments");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
