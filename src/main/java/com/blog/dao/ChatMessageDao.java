package com.blog.dao;

import com.blog.model.ChatMessage;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ChatMessageDao extends BaseDao {

    private ChatMessage mapRow(ResultSet rs) throws SQLException {
        ChatMessage m = new ChatMessage();
        m.setId(rs.getInt("id"));
        m.setSenderId(rs.getInt("sender_id"));
        m.setReceiverId(rs.getInt("receiver_id"));
        m.setContent(rs.getString("content"));
        m.setIsRead(rs.getInt("is_read"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        try { m.setSenderNickname(rs.getString("sender_nickname")); } catch (SQLException ignored) {}
        try { m.setReceiverNickname(rs.getString("receiver_nickname")); } catch (SQLException ignored) {}
        return m;
    }

    public List<ChatMessage> findByUsers(int userId1, int userId2, int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT m.*, u1.nickname AS sender_nickname, u2.nickname AS receiver_nickname " +
                "FROM t_chat_message m " +
                "JOIN t_user u1 ON m.sender_id = u1.id " +
                "JOIN t_user u2 ON m.receiver_id = u2.id " +
                "WHERE (m.sender_id = ? AND m.receiver_id = ?) OR (m.sender_id = ? AND m.receiver_id = ?) " +
                "ORDER BY m.created_at DESC LIMIT ? OFFSET ?";
        return executeQueryList(sql, this::mapRow, userId1, userId2, userId2, userId1, pageSize, (pageNum - 1) * pageSize);
    }

    public int getMessageCount(int userId1, int userId2) throws SQLException {
        String sql = "SELECT COUNT(*) FROM t_chat_message " +
                "WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)";
        return executeQueryInt(sql, userId1, userId2, userId2, userId1);
    }

    public List<ChatMessage> getConversations(int userId) throws SQLException {
        String sql = "SELECT m.*, " +
                "CASE WHEN m.sender_id = ? THEN u2.nickname ELSE u1.nickname END AS sender_nickname, " +
                "CASE WHEN m.sender_id = ? THEN u2.nickname ELSE u1.nickname END AS receiver_nickname " +
                "FROM t_chat_message m " +
                "JOIN t_user u1 ON m.sender_id = u1.id " +
                "JOIN t_user u2 ON m.receiver_id = u2.id " +
                "WHERE m.id IN (" +
                "  SELECT MAX(id) FROM t_chat_message WHERE sender_id = ? OR receiver_id = ? GROUP BY " +
                "  CASE WHEN sender_id = ? THEN receiver_id ELSE sender_id END" +
                ") ORDER BY m.created_at DESC";
        return executeQueryList(sql, this::mapRow, userId, userId, userId, userId, userId);
    }

    public int getUnreadCount(int receiverId, int senderId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM t_chat_message WHERE receiver_id = ? AND sender_id = ? AND is_read = 0";
        return executeQueryInt(sql, receiverId, senderId);
    }

    public int getTotalUnreadCount(int receiverId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM t_chat_message WHERE receiver_id = ? AND is_read = 0";
        return executeQueryInt(sql, receiverId);
    }

    public void markAsRead(int receiverId, int senderId) throws SQLException {
        String sql = "UPDATE t_chat_message SET is_read = 1 WHERE receiver_id = ? AND sender_id = ? AND is_read = 0";
        executeUpdate(sql, receiverId, senderId);
    }

    public int insert(ChatMessage message) throws SQLException {
        String sql = "INSERT INTO t_chat_message (sender_id, receiver_id, content) VALUES (?, ?, ?)";
        return executeInsertAndGetId(sql, message.getSenderId(), message.getReceiverId(), message.getContent());
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_chat_message WHERE id = ?", id) > 0;
    }
}
