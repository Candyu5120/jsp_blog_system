package com.blog.servlet.admin;

import com.blog.dao.ArticleDao;
import com.blog.dao.CategoryDao;
import com.blog.model.Article;
import com.blog.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ArticleManageServlet extends HttpServlet {

    private final ArticleDao articleDao = new ArticleDao();
    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    req.setAttribute("categories", categoryDao.findAll());
                    req.getRequestDispatcher("/admin/articleEdit.jsp").forward(req, resp);
                    break;
                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("article", articleDao.findById(editId));
                    req.setAttribute("categories", categoryDao.findAll());
                    req.getRequestDispatcher("/admin/articleEdit.jsp").forward(req, resp);
                    break;
                default: // list
                    int pageNum = 1;
                    int pageSize = 10;
                    String pageStr = req.getParameter("pageNum");
                    if (pageStr != null) pageNum = Integer.parseInt(pageStr);
                    int totalCount = articleDao.getTotalCountAll();
                    int totalPages = (totalCount + pageSize - 1) / pageSize;
                    if (pageNum < 1) pageNum = 1;
                    if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
                    req.setAttribute("articles", articleDao.findAll(pageNum, pageSize));
                    req.setAttribute("pageNum", pageNum);
                    req.setAttribute("totalPages", totalPages);
                    req.setAttribute("totalCount", totalCount);
                    req.getRequestDispatcher("/admin/articleList.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "save":
                    User user = (User) req.getSession().getAttribute("loginUser");
                    Article a = new Article();
                    a.setTitle(req.getParameter("title"));
                    a.setContent(req.getParameter("content"));
                    a.setSummary(req.getParameter("summary"));
                    a.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
                    a.setAuthorId(user.getId());
                    a.setIsTop("on".equals(req.getParameter("isTop")) ? 1 : 0);
                    a.setStatus("on".equals(req.getParameter("status")) ? 1 : 0);
                    articleDao.insert(a);
                    break;
                case "update":
                    Article au = new Article();
                    au.setId(Integer.parseInt(req.getParameter("id")));
                    au.setTitle(req.getParameter("title"));
                    au.setContent(req.getParameter("content"));
                    au.setSummary(req.getParameter("summary"));
                    au.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
                    au.setIsTop("on".equals(req.getParameter("isTop")) ? 1 : 0);
                    au.setStatus("on".equals(req.getParameter("status")) ? 1 : 0);
                    articleDao.update(au);
                    break;
                case "delete":
                    articleDao.delete(Integer.parseInt(req.getParameter("id")));
                    break;
            }
            resp.sendRedirect(req.getContextPath() + "/admin/article");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
