package com.blog.dao;

import com.blog.model.Friend;

import java.sql.SQLException;
import java.util.List;

public class FriendDao extends BaseDao {

    public List<Friend> findAll() throws SQLException {
        String sql = "SELECT * FROM t_friend ORDER BY sort_order ASC, id ASC";
        return executeQueryList(sql, rs -> {
            Friend f = new Friend();
            f.setId(rs.getInt("id"));
            f.setName(rs.getString("name"));
            f.setUrl(rs.getString("url"));
            f.setLogo(rs.getString("logo"));
            f.setDescription(rs.getString("description"));
            f.setSortOrder(rs.getInt("sort_order"));
            f.setCreatedAt(rs.getTimestamp("created_at"));
            return f;
        });
    }

    public Friend findById(int id) throws SQLException {
        String sql = "SELECT * FROM t_friend WHERE id = ?";
        return executeQueryOne(sql, rs -> {
            Friend f = new Friend();
            f.setId(rs.getInt("id"));
            f.setName(rs.getString("name"));
            f.setUrl(rs.getString("url"));
            f.setLogo(rs.getString("logo"));
            f.setDescription(rs.getString("description"));
            f.setSortOrder(rs.getInt("sort_order"));
            f.setCreatedAt(rs.getTimestamp("created_at"));
            return f;
        }, id);
    }

    public int insert(Friend f) throws SQLException {
        String sql = "INSERT INTO t_friend (name, url, logo, description, sort_order) VALUES (?, ?, ?, ?, ?)";
        return executeInsertAndGetId(sql, f.getName(), f.getUrl(), f.getLogo(),
                f.getDescription(), f.getSortOrder());
    }

    public boolean update(Friend f) throws SQLException {
        String sql = "UPDATE t_friend SET name=?, url=?, logo=?, description=?, sort_order=? WHERE id=?";
        return executeUpdate(sql, f.getName(), f.getUrl(), f.getLogo(),
                f.getDescription(), f.getSortOrder(), f.getId()) > 0;
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_friend WHERE id=?", id) > 0;
    }
}
