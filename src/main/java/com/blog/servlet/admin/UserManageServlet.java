package com.blog.servlet.admin;

import com.blog.dao.UserDao;
import com.blog.model.User;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserManageServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    req.getRequestDispatcher("/admin/userEdit.jsp").forward(req, resp);
                    break;
                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("editUser", userDao.findById(editId));
                    req.getRequestDispatcher("/admin/userEdit.jsp").forward(req, resp);
                    break;
                default:
                    int pageNum = 1;
                    int pageSize = 10;
                    String pageStr = req.getParameter("pageNum");
                    if (pageStr != null) pageNum = Integer.parseInt(pageStr);
                    int totalCount = userDao.getTotalCountAll();
                    int totalPages = (totalCount + pageSize - 1) / pageSize;
                    if (pageNum < 1) pageNum = 1;
                    if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;
                    List<User> users = userDao.findAll(pageNum, pageSize);
                    req.setAttribute("users", users);
                    req.setAttribute("pageNum", pageNum);
                    req.setAttribute("totalPages", totalPages);
                    req.setAttribute("totalCount", totalCount);
                    req.getRequestDispatcher("/admin/userList.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User loginUser = (User) req.getSession().getAttribute("loginUser");

        try {
            switch (action) {
                case "save":
                    User newUser = new User();
                    newUser.setUsername(req.getParameter("username"));
                    newUser.setPassword(StringUtil.sha256(req.getParameter("password")));
                    newUser.setNickname(req.getParameter("nickname"));
                    newUser.setEmail(req.getParameter("email"));
                    newUser.setBio(req.getParameter("bio"));
                    newUser.setRole(req.getParameter("role"));
                    userDao.insert(newUser);
                    break;
                case "update":
                    int updateId = Integer.parseInt(req.getParameter("id"));
                    User updateUser = userDao.findById(updateId);
                    if (updateUser != null) {
                        updateUser.setNickname(req.getParameter("nickname"));
                        updateUser.setEmail(req.getParameter("email"));
                        updateUser.setBio(req.getParameter("bio"));
                        String role = req.getParameter("role");
                        if (role != null) {
                            updateUser.setRole(role);
                        }
                        userDao.update(updateUser);
                    }
                    break;
                case "changePassword":
                    int pwdId = Integer.parseInt(req.getParameter("id"));
                    String newPassword = req.getParameter("newPassword");
                    if (!StringUtil.isEmpty(newPassword)) {
                        userDao.updatePassword(pwdId, StringUtil.sha256(newPassword));
                    }
                    break;
                case "delete":
                    int deleteId = Integer.parseInt(req.getParameter("id"));
                    if (deleteId == loginUser.getId()) {
                        resp.sendRedirect(req.getContextPath() + "/admin/user?error=cannotDeleteSelf");
                        return;
                    }
                    User target = userDao.findById(deleteId);
                    if (target != null && "admin".equals(target.getRole())) {
                        long adminCount = userDao.findAll().stream().filter(u -> "admin".equals(u.getRole())).count();
                        if (adminCount <= 1) {
                            resp.sendRedirect(req.getContextPath() + "/admin/user?error=cannotDeleteLastAdmin");
                            return;
                        }
                    }
                    userDao.delete(deleteId);
                    break;
            }
            resp.sendRedirect(req.getContextPath() + "/admin/user");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
