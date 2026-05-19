package com.blog.dao;

import com.blog.model.Comment;

import java.sql.SQLException;
import java.util.List;

public class CommentDao extends BaseDao {

    public List<Comment> findByArticleId(int articleId) throws SQLException {
        String sql = "SELECT * FROM t_comment WHERE article_id = ? ORDER BY created_at DESC";
        return executeQueryList(sql, rs -> {
            Comment c = new Comment();
            c.setId(rs.getInt("id"));
            c.setArticleId(rs.getInt("article_id"));
            c.setVisitorName(rs.getString("visitor_name"));
            c.setVisitorEmail(rs.getString("visitor_email"));
            c.setContent(rs.getString("content"));
            c.setIpAddress(rs.getString("ip_address"));
            c.setCreatedAt(rs.getTimestamp("created_at"));
            return c;
        }, articleId);
    }

    public List<Comment> findAll(int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT c.*, a.title AS article_title FROM t_comment c " +
                "LEFT JOIN t_article a ON c.article_id = a.id " +
                "ORDER BY c.created_at DESC LIMIT ?, ?";
        return executeQueryList(sql, rs -> {
            Comment c = new Comment();
            c.setId(rs.getInt("id"));
            c.setArticleId(rs.getInt("article_id"));
            c.setVisitorName(rs.getString("visitor_name"));
            c.setVisitorEmail(rs.getString("visitor_email"));
            c.setContent(rs.getString("content"));
            c.setIpAddress(rs.getString("ip_address"));
            c.setCreatedAt(rs.getTimestamp("created_at"));
            try { c.setArticleTitle(rs.getString("article_title")); } catch (SQLException ignored) {}
            return c;
        }, (pageNum - 1) * pageSize, pageSize);
    }

    public int insert(Comment c) throws SQLException {
        String sql = "INSERT INTO t_comment (article_id, visitor_name, visitor_email, content, ip_address) VALUES (?, ?, ?, ?, ?)";
        return executeInsertAndGetId(sql, c.getArticleId(), c.getVisitorName(),
                c.getVisitorEmail(), c.getContent(), c.getIpAddress());
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_comment WHERE id=?", id) > 0;
    }

    public int getTotalCount() throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_comment");
    }

    public int getCountByArticleId(int articleId) throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_comment WHERE article_id=?", articleId);
    }
}
