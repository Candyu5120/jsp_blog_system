package com.blog.dao;

import com.blog.model.UserFriend;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserFriendDao extends BaseDao {

    private UserFriend mapRow(ResultSet rs) throws SQLException {
        UserFriend f = new UserFriend();
        f.setId(rs.getInt("id"));
        f.setUserId(rs.getInt("user_id"));
        f.setFriendId(rs.getInt("friend_id"));
        f.setStatus(rs.getString("status"));
        f.setCreatedAt(rs.getTimestamp("created_at"));
        // 关联字段（JOIN 查询时存在）
        try { f.setFriendNickname(rs.getString("friend_nickname")); } catch (SQLException ignored) {}
        try { f.setFriendUsername(rs.getString("friend_username")); } catch (SQLException ignored) {}
        try { f.setFriendAvatar(rs.getString("friend_avatar")); } catch (SQLException ignored) {}
        return f;
    }

    public UserFriend findByUserAndFriend(int userId, int friendId) throws SQLException {
        String sql = "SELECT * FROM t_user_friend WHERE user_id = ? AND friend_id = ?";
        return executeQueryOne(sql, this::mapRow, userId, friendId);
    }

    public List<UserFriend> findAcceptedByUserId(int userId) throws SQLException {
        String sql = "SELECT f.*, u.nickname AS friend_nickname, u.username AS friend_username, u.avatar AS friend_avatar " +
                "FROM t_user_friend f JOIN t_user u ON f.friend_id = u.id " +
                "WHERE f.user_id = ? AND f.status = 'accepted' ORDER BY f.created_at DESC";
        return executeQueryList(sql, this::mapRow, userId);
    }

    public List<UserFriend> findPendingByUserId(int userId) throws SQLException {
        String sql = "SELECT f.*, u.nickname AS friend_nickname, u.username AS friend_username, u.avatar AS friend_avatar " +
                "FROM t_user_friend f JOIN t_user u ON f.user_id = u.id " +
                "WHERE f.friend_id = ? AND f.status = 'pending' ORDER BY f.created_at DESC";
        return executeQueryList(sql, this::mapRow, userId);
    }

    public int insert(UserFriend userFriend) throws SQLException {
        String sql = "INSERT INTO t_user_friend (user_id, friend_id, status) VALUES (?, ?, ?)";
        return executeInsertAndGetId(sql, userFriend.getUserId(), userFriend.getFriendId(), userFriend.getStatus());
    }

    public boolean updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE t_user_friend SET status = ? WHERE id = ?";
        return executeUpdate(sql, status, id) > 0;
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_user_friend WHERE id = ?", id) > 0;
    }

    public boolean deleteByUserAndFriend(int userId, int friendId) throws SQLException {
        return executeUpdate("DELETE FROM t_user_friend WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)",
                userId, friendId, friendId, userId) > 0;
    }

    public boolean exists(int userId, int friendId) throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_user_friend WHERE user_id = ? AND friend_id = ?",
                userId, friendId) > 0;
    }
}
