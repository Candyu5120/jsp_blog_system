package com.blog.dao;

import com.blog.model.Article;

import java.sql.SQLException;
import java.util.List;

public class ArticleDao extends BaseDao {

    private Article mapArticle(java.sql.ResultSet rs) throws SQLException {
        Article a = new Article();
        a.setId(rs.getInt("id"));
        a.setTitle(rs.getString("title"));
        a.setContent(rs.getString("content"));
        a.setSummary(rs.getString("summary"));
        a.setCategoryId(rs.getInt("category_id"));
        a.setAuthorId(rs.getInt("author_id"));
        a.setViewCount(rs.getInt("view_count"));
        a.setIsTop(rs.getInt("is_top"));
        a.setStatus(rs.getInt("status"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setUpdatedAt(rs.getTimestamp("updated_at"));
        try { a.setCategoryName(rs.getString("category_name")); } catch (SQLException ignored) {}
        try { a.setAuthorName(rs.getString("author_name")); } catch (SQLException ignored) {}
        return a;
    }

    public List<Article> findByPage(int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT a.*, c.name AS category_name, u.nickname AS author_name " +
                "FROM t_article a " +
                "LEFT JOIN t_category c ON a.category_id = c.id " +
                "LEFT JOIN t_user u ON a.author_id = u.id " +
                "WHERE a.status = 1 " +
                "ORDER BY a.is_top DESC, a.created_at DESC " +
                "LIMIT ?, ?";
        return executeQueryList(sql, this::mapArticle, (pageNum - 1) * pageSize, pageSize);
    }

    public List<Article> findByCategoryId(int categoryId, int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT a.*, c.name AS category_name, u.nickname AS author_name " +
                "FROM t_article a " +
                "LEFT JOIN t_category c ON a.category_id = c.id " +
                "LEFT JOIN t_user u ON a.author_id = u.id " +
                "WHERE a.status = 1 AND a.category_id = ? " +
                "ORDER BY a.is_top DESC, a.created_at DESC " +
                "LIMIT ?, ?";
        return executeQueryList(sql, this::mapArticle, categoryId, (pageNum - 1) * pageSize, pageSize);
    }

    public List<Article> search(String keyword, int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT a.*, c.name AS category_name, u.nickname AS author_name " +
                "FROM t_article a " +
                "LEFT JOIN t_category c ON a.category_id = c.id " +
                "LEFT JOIN t_user u ON a.author_id = u.id " +
                "WHERE a.status = 1 AND (a.title LIKE ? OR a.content LIKE ?) " +
                "ORDER BY a.created_at DESC " +
                "LIMIT ?, ?";
        String like = "%" + keyword + "%";
        return executeQueryList(sql, this::mapArticle, like, like, (pageNum - 1) * pageSize, pageSize);
    }

    public Article findById(int id) throws SQLException {
        String sql = "SELECT a.*, c.name AS category_name, u.nickname AS author_name " +
                "FROM t_article a " +
                "LEFT JOIN t_category c ON a.category_id = c.id " +
                "LEFT JOIN t_user u ON a.author_id = u.id " +
                "WHERE a.id = ?";
        Article article = executeQueryOne(sql, this::mapArticle, id);
        if (article != null) {
            // Increment view count
            executeUpdate("UPDATE t_article SET view_count = view_count + 1 WHERE id = ?", id);
            article.setViewCount(article.getViewCount() + 1);
        }
        return article;
    }

    public List<Article> findAll(int pageNum, int pageSize) throws SQLException {
        String sql = "SELECT a.*, c.name AS category_name, u.nickname AS author_name " +
                "FROM t_article a " +
                "LEFT JOIN t_category c ON a.category_id = c.id " +
                "LEFT JOIN t_user u ON a.author_id = u.id " +
                "ORDER BY a.created_at DESC " +
                "LIMIT ?, ?";
        return executeQueryList(sql, this::mapArticle, (pageNum - 1) * pageSize, pageSize);
    }

    public int insert(Article a) throws SQLException {
        String sql = "INSERT INTO t_article (title, content, summary, category_id, author_id, is_top, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return executeInsertAndGetId(sql, a.getTitle(), a.getContent(), a.getSummary(),
                a.getCategoryId(), a.getAuthorId(), a.getIsTop(), a.getStatus());
    }

    public boolean update(Article a) throws SQLException {
        String sql = "UPDATE t_article SET title=?, content=?, summary=?, category_id=?, is_top=?, status=? WHERE id=?";
        return executeUpdate(sql, a.getTitle(), a.getContent(), a.getSummary(),
                a.getCategoryId(), a.getIsTop(), a.getStatus(), a.getId()) > 0;
    }

    public boolean delete(int id) throws SQLException {
        return executeUpdate("DELETE FROM t_article WHERE id=?", id) > 0;
    }

    public int getTotalCount() throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_article WHERE status=1");
    }

    public int getTotalCountByCategory(int categoryId) throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_article WHERE status=1 AND category_id=?", categoryId);
    }

    public int getTotalCountBySearch(String keyword) throws SQLException {
        String like = "%" + keyword + "%";
        return executeQueryInt("SELECT COUNT(*) FROM t_article WHERE status=1 AND (title LIKE ? OR content LIKE ?)", like, like);
    }

    public int getTotalCountAll() throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_article");
    }

    public List<Article> findRecent(int limit) throws SQLException {
        String sql = "SELECT a.*, c.name AS category_name " +
                "FROM t_article a " +
                "LEFT JOIN t_category c ON a.category_id = c.id " +
                "WHERE a.status = 1 " +
                "ORDER BY a.created_at DESC " +
                "LIMIT ?";
        return executeQueryList(sql, this::mapArticle, limit);
    }
}
