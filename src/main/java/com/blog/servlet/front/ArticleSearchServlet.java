package com.blog.servlet.front;

import com.blog.dao.ArticleDao;
import com.blog.dao.CategoryDao;
import com.blog.dao.FriendDao;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ArticleSearchServlet extends HttpServlet {

    private final ArticleDao articleDao = new ArticleDao();
    private final CategoryDao categoryDao = new CategoryDao();
    private final FriendDao friendDao = new FriendDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String keyword = req.getParameter("keyword");
            int pageNum = 1;
            int pageSize = 10;
            String pageStr = req.getParameter("pageNum");
            if (pageStr != null) pageNum = Integer.parseInt(pageStr);

            if (!StringUtil.isEmpty(keyword)) {
                int totalCount = articleDao.getTotalCountBySearch(keyword);
                int totalPages = (totalCount + pageSize - 1) / pageSize;
                if (pageNum < 1) pageNum = 1;
                if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
                req.setAttribute("articles", articleDao.search(keyword, pageNum, pageSize));
                req.setAttribute("totalCount", totalCount);
                req.setAttribute("totalPages", totalPages);
            }

            req.setAttribute("keyword", keyword);
            req.setAttribute("pageNum", pageNum);

            // Sidebar
            req.setAttribute("categories", categoryDao.findAll());
            req.setAttribute("recentArticles", articleDao.findRecent(5));
            req.setAttribute("friends", friendDao.findAll());

            req.getRequestDispatcher("/search.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
