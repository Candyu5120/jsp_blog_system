package com.blog.servlet.admin;

import com.blog.dao.UserDao;
import com.blog.dao.UserFriendDao;
import com.blog.model.User;
import com.blog.model.UserFriend;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class FriendshipManageServlet extends HttpServlet {

    private final UserFriendDao userFriendDao = new UserFriendDao();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "requests":
                    List<UserFriend> pendingRequests = userFriendDao.findPendingByUserId(loginUser.getId());
                    req.setAttribute("requests", pendingRequests);
                    req.setAttribute("activeTab", "requests");
                    break;
                case "search":
                    String keyword = req.getParameter("keyword");
                    if (!StringUtil.isEmpty(keyword)) {
                        List<User> searchResults = userDao.searchByUsername(keyword);
                        searchResults.removeIf(u -> u.getId() == loginUser.getId());
                        req.setAttribute("searchResults", searchResults);
                        req.setAttribute("keyword", keyword);
                    }
                    req.setAttribute("activeTab", "search");
                    break;
                default:
                    List<UserFriend> friends = userFriendDao.findAcceptedByUserId(loginUser.getId());
                    req.setAttribute("friends", friends);
                    req.setAttribute("activeTab", "friends");
            }
            req.getRequestDispatcher("/admin/friendList.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "sendRequest":
                    int friendId = Integer.parseInt(req.getParameter("friendId"));
                    if (friendId != loginUser.getId() && !userFriendDao.exists(loginUser.getId(), friendId)) {
                        UserFriend uf = new UserFriend();
                        uf.setUserId(loginUser.getId());
                        uf.setFriendId(friendId);
                        uf.setStatus("pending");
                        userFriendDao.insert(uf);
                    }
                    break;
                case "accept":
                    int requestId = Integer.parseInt(req.getParameter("id"));
                    userFriendDao.updateStatus(requestId, "accepted");
                    UserFriend request = userFriendDao.findByUserAndFriend(
                            Integer.parseInt(req.getParameter("userId")), loginUser.getId());
                    if (request != null) {
                        UserFriend reverse = new UserFriend();
                        reverse.setUserId(loginUser.getId());
                        reverse.setFriendId(Integer.parseInt(req.getParameter("userId")));
                        reverse.setStatus("accepted");
                        userFriendDao.insert(reverse);
                    }
                    resp.sendRedirect(req.getContextPath() + "/admin/friend?action=requests");
                    return;
                case "reject":
                    userFriendDao.delete(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/admin/friend?action=requests");
                    return;
                case "delete":
                    int delFriendId = Integer.parseInt(req.getParameter("friendId"));
                    userFriendDao.deleteByUserAndFriend(loginUser.getId(), delFriendId);
                    break;
            }
            resp.sendRedirect(req.getContextPath() + "/admin/friend");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
