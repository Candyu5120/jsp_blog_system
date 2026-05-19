package com.blog.dao;

import com.blog.model.User;

import java.sql.SQLException;

public class UserDao extends BaseDao {

    public User findByUsernameAndPassword(String username, String password) throws SQLException {
        String sql = "SELECT * FROM t_user WHERE username = ? AND password = ?";
        return executeQueryOne(sql, rs -> {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setNickname(rs.getString("nickname"));
            u.setAvatar(rs.getString("avatar"));
            u.setEmail(rs.getString("email"));
            u.setBio(rs.getString("bio"));
            u.setCreatedAt(rs.getTimestamp("created_at"));
            return u;
        }, username, password);
    }

    public User findById(int id) throws SQLException {
        String sql = "SELECT * FROM t_user WHERE id = ?";
        return executeQueryOne(sql, rs -> {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setNickname(rs.getString("nickname"));
            u.setAvatar(rs.getString("avatar"));
            u.setEmail(rs.getString("email"));
            u.setBio(rs.getString("bio"));
            u.setCreatedAt(rs.getTimestamp("created_at"));
            return u;
        }, id);
    }

    public User findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM t_user WHERE username = ?";
        return executeQueryOne(sql, rs -> {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setNickname(rs.getString("nickname"));
            u.setAvatar(rs.getString("avatar"));
            u.setEmail(rs.getString("email"));
            u.setBio(rs.getString("bio"));
            u.setCreatedAt(rs.getTimestamp("created_at"));
            return u;
        }, username);
    }

    public int insert(User user) throws SQLException {
        String sql = "INSERT INTO t_user (username, password, nickname, email, bio) VALUES (?, ?, ?, ?, ?)";
        return executeInsertAndGetId(sql, user.getUsername(), user.getPassword(),
                user.getNickname(), user.getEmail(), user.getBio());
    }

    public boolean update(User user) throws SQLException {
        String sql = "UPDATE t_user SET nickname=?, avatar=?, email=?, bio=? WHERE id=?";
        return executeUpdate(sql, user.getNickname(), user.getAvatar(),
                user.getEmail(), user.getBio(), user.getId()) > 0;
    }
}
