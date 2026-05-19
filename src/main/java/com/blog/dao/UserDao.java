package com.blog.dao;

import com.blog.model.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDao extends BaseDao {

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setNickname(rs.getString("nickname"));
        u.setAvatar(rs.getString("avatar"));
        u.setEmail(rs.getString("email"));
        u.setBio(rs.getString("bio"));
        u.setRole(rs.getString("role"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }

    public User findByUsernameAndPassword(String username, String password) throws SQLException {
        String sql = "SELECT * FROM t_user WHERE username = ? AND password = ?";
        return executeQueryOne(sql, this::mapRow, username, password);
    }

    public User findById(int id) throws SQLException {
        String sql = "SELECT * FROM t_user WHERE id = ?";
        return executeQueryOne(sql, this::mapRow, id);
    }

    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM t_user WHERE username = ?";
        return executeQueryOne(sql, this::mapRow, username);
    }

    public List<User> findAll(int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT * FROM t_user ORDER BY created_at DESC LIMIT ? OFFSET ?";
        return executeQueryList(sql, this::mapRow, pageSize, (pageNum - 1) * pageSize);
    }

    public List<User> findAll() throws SQLException {
        String sql = "SELECT * FROM t_user ORDER BY created_at DESC";
        return executeQueryList(sql, this::mapRow);
    }

    public int getTotalCountAll() throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_user");
    }

    public int insert(User user) throws SQLException {
        String sql = "INSERT INTO t_user (username, password, nickname, email, bio, role) VALUES (?, ?, ?, ?, ?, ?)";
        return executeInsertAndGetId(sql, user.getUsername(), user.getPassword(),
                user.getNickname(), user.getEmail(), user.getBio(), user.getRole());
    }

    public boolean update(User user) throws SQLException {
        String sql = "UPDATE t_user SET nickname=?, avatar=?, email=?, bio=?, role=? WHERE id=?";
        return executeUpdate(sql, user.getNickname(), user.getAvatar(),
                user.getEmail(), user.getBio(), user.getRole(), user.getId()) > 0;
    }

    public boolean updatePassword(int id, String password) throws SQLException {
        String sql = "UPDATE t_user SET password=? WHERE id=?";
        return executeUpdate(sql, password, id) > 0;
    }

    public boolean updateRole(int id, String role) throws SQLException {
        String sql = "UPDATE t_user SET role=? WHERE id=?";
        return executeUpdate(sql, role, id) > 0;
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_user WHERE id=?", id) > 0;
    }

    public List<User> searchByUsername(String keyword) throws SQLException {
        String sql = "SELECT * FROM t_user WHERE username LIKE ? ORDER BY username";
        return executeQueryList(sql, this::mapRow, "%" + keyword + "%");
    }
}
