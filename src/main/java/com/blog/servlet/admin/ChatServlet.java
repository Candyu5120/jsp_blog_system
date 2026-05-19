package com.blog.servlet.admin;

import com.blog.dao.ChatMessageDao;
import com.blog.dao.UserDao;
import com.blog.model.ChatMessage;
import com.blog.model.User;
import com.blog.util.StringUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ChatServlet extends HttpServlet {

    private final ChatMessageDao chatMessageDao = new ChatMessageDao();
    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "conversation":
                    int otherUserId = Integer.parseInt(req.getParameter("userId"));
                    User otherUser = userDao.findById(otherUserId);
                    if (otherUser == null) {
                        resp.sendRedirect(req.getContextPath() + "/admin/chat");
                        return;
                    }

                    int pageNum = 1;
                    int pageSize = 50;
                    String pageStr = req.getParameter("pageNum");
                    if (pageStr != null) pageNum = Integer.parseInt(pageStr);

                    chatMessageDao.markAsRead(loginUser.getId(), otherUserId);
                    int messageCount = chatMessageDao.getMessageCount(loginUser.getId(), otherUserId);
                    int totalPages = (messageCount + pageSize - 1) / pageSize;
                    if (pageNum < 1) pageNum = 1;
                    if (pageNum > totalPages && totalPages > 0) pageNum = totalPages;

                    List<ChatMessage> messages = chatMessageDao.findByUsers(loginUser.getId(), otherUserId, pageNum, pageSize);
                    req.setAttribute("messages", messages);
                    req.setAttribute("otherUser", otherUser);
                    req.setAttribute("pageNum", pageNum);
                    req.setAttribute("totalPages", totalPages);
                    req.getRequestDispatcher("/admin/chatWindow.jsp").forward(req, resp);
                    break;
                default:
                    List<ChatMessage> conversations = chatMessageDao.getConversations(loginUser.getId());
                    for (ChatMessage conv : conversations) {
                        int senderId = conv.getSenderId();
                        int receiverId = conv.getReceiverId();
                        int otherId = (senderId == loginUser.getId()) ? receiverId : senderId;
                        int unread = chatMessageDao.getUnreadCount(loginUser.getId(), otherId);
                        conv.setIsRead(unread);
                    }
                    req.setAttribute("conversations", conversations);
                    req.setAttribute("totalUnread", chatMessageDao.getTotalUnreadCount(loginUser.getId()));
                    req.getRequestDispatcher("/admin/chatList.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        String action = req.getParameter("action");

        try {
            if ("send".equals(action)) {
                int receiverId = Integer.parseInt(req.getParameter("receiverId"));
                String content = req.getParameter("content");
                if (!StringUtil.isEmpty(content) && receiverId != loginUser.getId()) {
                    ChatMessage msg = new ChatMessage();
                    msg.setSenderId(loginUser.getId());
                    msg.setReceiverId(receiverId);
                    msg.setContent(content);
                    chatMessageDao.insert(msg);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/chat?action=conversation&userId=" + receiverId);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/chat");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
