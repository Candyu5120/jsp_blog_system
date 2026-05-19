package com.blog.dao;

import com.blog.model.Category;

import java.sql.SQLException;
import java.util.List;

public class CategoryDao extends BaseDao {

    public List<Category> findAll() throws SQLException {
        String sql = "SELECT c.*, " +
                "(SELECT COUNT(*) FROM t_article a WHERE a.category_id = c.id AND a.status = 1) AS article_count " +
                "FROM t_category c ORDER BY c.sort_order ASC, c.id ASC";
        return executeQueryList(sql, rs -> {
            Category cat = new Category();
            cat.setId(rs.getInt("id"));
            cat.setName(rs.getString("name"));
            cat.setDescription(rs.getString("description"));
            cat.setSortOrder(rs.getInt("sort_order"));
            cat.setCreatedAt(rs.getTimestamp("created_at"));
            cat.setArticleCount(rs.getInt("article_count"));
            return cat;
        });
    }

    public Category findById(int id) throws SQLException {
        String sql = "SELECT * FROM t_category WHERE id = ?";
        return executeQueryOne(sql, rs -> {
            Category c = new Category();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            c.setDescription(rs.getString("description"));
            c.setSortOrder(rs.getInt("sort_order"));
            c.setCreatedAt(rs.getTimestamp("created_at"));
            return c;
        }, id);
    }

    public int insert(Category c) throws SQLException {
        String sql = "INSERT INTO t_category (name, description, sort_order) VALUES (?, ?, ?)";
        return executeInsertAndGetId(sql, c.getName(), c.getDescription(), c.getSortOrder());
    }

    public boolean update(Category c) throws SQLException {
        String sql = "UPDATE t_category SET name=?, description=?, sort_order=? WHERE id=?";
        return executeUpdate(sql, c.getName(), c.getDescription(), c.getSortOrder(), c.getId()) > 0;
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_category WHERE id=?", id) > 0;
    }

    public int getArticleCount(int categoryId) throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_article WHERE category_id=?", categoryId);
    }
}
