package com.blog.servlet.admin;

import com.blog.dao.FriendDao;
import com.blog.model.Friend;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class FriendManageServlet extends HttpServlet {

    private final FriendDao friendDao = new FriendDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    req.getRequestDispatcher("/admin/friendEdit.jsp").forward(req, resp);
                    break;
                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("friend", friendDao.findById(editId));
                    req.getRequestDispatcher("/admin/friendEdit.jsp").forward(req, resp);
                    break;
                default:
                    req.setAttribute("friends", friendDao.findAll());
                    req.getRequestDispatcher("/admin/friendList.jsp").forward(req, resp);
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
                    Friend f = new Friend();
                    f.setName(req.getParameter("name"));
                    f.setUrl(req.getParameter("url"));
                    f.setLogo(req.getParameter("logo"));
                    f.setDescription(req.getParameter("description"));
                    f.setSortOrder(Integer.parseInt(req.getParameter("sortOrder")));
                    friendDao.insert(f);
                    break;
                case "update":
                    Friend fu = new Friend();
                    fu.setId(Integer.parseInt(req.getParameter("id")));
                    fu.setName(req.getParameter("name"));
                    fu.setUrl(req.getParameter("url"));
                    fu.setLogo(req.getParameter("logo"));
                    fu.setDescription(req.getParameter("description"));
                    fu.setSortOrder(Integer.parseInt(req.getParameter("sortOrder")));
                    friendDao.update(fu);
                    break;
                case "delete":
                    friendDao.delete(Integer.parseInt(req.getParameter("id")));
                    break;
            }
            resp.sendRedirect(req.getContextPath() + "/admin/friend");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
