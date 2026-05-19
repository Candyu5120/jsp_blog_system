package com.blog.dao;

import com.blog.model.Message;

import java.sql.SQLException;
import java.util.List;

public class MessageDao extends BaseDao {

    public List<Message> findAll(int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT * FROM t_message ORDER BY created_at DESC LIMIT ?, ?";
        return executeQueryList(sql, rs -> {
            Message m = new Message();
            m.setId(rs.getInt("id"));
            m.setVisitorName(rs.getString("visitor_name"));
            m.setVisitorEmail(rs.getString("visitor_email"));
            m.setContent(rs.getString("content"));
            m.setIpAddress(rs.getString("ip_address"));
            m.setCreatedAt(rs.getTimestamp("created_at"));
            return m;
        }, (pageNum - 1) * pageSize, pageSize);
    }

    public int insert(Message m) throws SQLException {
        String sql = "INSERT INTO t_message (visitor_name, visitor_email, content, ip_address) VALUES (?, ?, ?, ?)";
        return executeInsertAndGetId(sql, m.getVisitorName(), m.getVisitorEmail(),
                m.getContent(), m.getIpAddress());
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_message WHERE id=?", id) > 0;
    }

    public int getTotalCount() throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_message");
    }
}
