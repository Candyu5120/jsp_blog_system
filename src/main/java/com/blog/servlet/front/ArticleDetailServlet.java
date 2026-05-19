package com.blog.servlet.front;

import com.blog.dao.ArticleDao;
import com.blog.dao.CategoryDao;
import com.blog.dao.CommentDao;
import com.blog.dao.FriendDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ArticleDetailServlet extends HttpServlet {

    private final ArticleDao articleDao = new ArticleDao();
    private final CommentDao commentDao = new CommentDao();
    private final CategoryDao categoryDao = new CategoryDao();
    private final FriendDao friendDao = new FriendDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("article", articleDao.findById(id));
            req.setAttribute("comments", commentDao.findByArticleId(id));
            req.setAttribute("commentCount", commentDao.getCountByArticleId(id));

            // Sidebar
            req.setAttribute("categories", categoryDao.findAll());
            req.setAttribute("recentArticles", articleDao.findRecent(5));
            req.setAttribute("friends", friendDao.findAll());

            req.getRequestDispatcher("/article.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
