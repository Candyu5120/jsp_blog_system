package com.blog.servlet.admin;

import com.blog.dao.CategoryDao;
import com.blog.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CategoryManageServlet extends HttpServlet {

    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    req.getRequestDispatcher("/admin/categoryEdit.jsp").forward(req, resp);
                    break;
                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("category", categoryDao.findById(editId));
                    req.getRequestDispatcher("/admin/categoryEdit.jsp").forward(req, resp);
                    break;
                default:
                    var categories = categoryDao.findAll();
                    // Add article counts
                    for (Category c : categories) {
                        c.setArticleCount(categoryDao.getArticleCount(c.getId()));
                    }
                    req.setAttribute("categories", categories);
                    req.getRequestDispatcher("/admin/categoryList.jsp").forward(req, resp);
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
                    Category c = new Category();
                    c.setName(req.getParameter("name"));
                    c.setDescription(req.getParameter("description"));
                    c.setSortOrder(Integer.parseInt(req.getParameter("sortOrder")));
                    categoryDao.insert(c);
                    break;
                case "update":
                    Category cu = new Category();
                    cu.setId(Integer.parseInt(req.getParameter("id")));
                    cu.setName(req.getParameter("name"));
                    cu.setDescription(req.getParameter("description"));
                    cu.setSortOrder(Integer.parseInt(req.getParameter("sortOrder")));
                    categoryDao.update(cu);
                    break;
                case "delete":
                    categoryDao.delete(Integer.parseInt(req.getParameter("id")));
                    break;
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
