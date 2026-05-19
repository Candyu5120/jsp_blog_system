package com.blog.servlet.front;

import com.blog.dao.ArticleDao;
import com.blog.dao.CategoryDao;
import com.blog.dao.FriendDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class IndexServlet extends HttpServlet {

    private final ArticleDao articleDao = new ArticleDao();
    private final CategoryDao categoryDao = new CategoryDao();
    private final FriendDao friendDao = new FriendDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int pageNum = 1;
            int pageSize = 10;
            String pageStr = req.getParameter("pageNum");
            String categoryStr = req.getParameter("categoryId");

            if (pageStr != null) pageNum = Integer.parseInt(pageStr);

            int totalCount;
            if (categoryStr != null && !categoryStr.isEmpty()) {
                int categoryId = Integer.parseInt(categoryStr);
                totalCount = articleDao.getTotalCountByCategory(categoryId);
                int totalPages = (totalCount + pageSize - 1) / pageSize;
                if (pageNum < 1) pageNum = 1;
                if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
                req.setAttribute("articles", articleDao.findByCategoryId(categoryId, pageNum, pageSize));
                req.setAttribute("currentCategoryId", categoryId);
            } else {
                totalCount = articleDao.getTotalCount();
                int totalPages = (totalCount + pageSize - 1) / pageSize;
                if (pageNum < 1) pageNum = 1;
                if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
                req.setAttribute("articles", articleDao.findByPage(pageNum, pageSize));
            }

            int totalPages = (totalCount + pageSize - 1) / pageSize;
            req.setAttribute("pageNum", pageNum);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalCount", totalCount);

            // Sidebar data
            req.setAttribute("categories", categoryDao.findAll());
            req.setAttribute("recentArticles", articleDao.findRecent(5));
            req.setAttribute("friends", friendDao.findAll());

            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
