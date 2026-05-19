package com.blog.dao;

import com.blog.model.Photo;

import java.sql.SQLException;
import java.util.List;

public class PhotoDao extends BaseDao {

    public List<Photo> findAll() throws SQLException {
        String sql = "SELECT * FROM t_photo ORDER BY upload_time DESC";
        return executeQueryList(sql, this::mapPhoto);
    }

    public List<Photo> findByAlbum(String albumName) throws SQLException {
        String sql = "SELECT * FROM t_photo WHERE album_name = ? ORDER BY upload_time DESC";
        return executeQueryList(sql, this::mapPhoto, albumName);
    }

    public List<String> findAllAlbumNames() throws SQLException {
        String sql = "SELECT DISTINCT album_name FROM t_photo ORDER BY album_name";
        return executeQueryList(sql, rs -> rs.getString("album_name"));
    }

    public int insert(Photo p) throws SQLException {
        String sql = "INSERT INTO t_photo (album_name, photo_path, description) VALUES (?, ?, ?)";
        return executeInsertAndGetId(sql, p.getAlbumName(), p.getPhotoPath(), p.getDescription());
    }

    public boolean delete(int id) throws SQLException {
        // First get the photo path for file deletion
        Photo photo = findById(id);
        if (photo != null) {
            return executeUpdate("DELETE FROM t_photo WHERE id=?", id) > 0;
        }
        return false;
    }

    public Photo findById(int id) throws SQLException {
        String sql = "SELECT * FROM t_photo WHERE id = ?";
        return executeQueryOne(sql, this::mapPhoto, id);
    }

    public int getTotalCount() throws SQLException {
        return executeQueryInt("SELECT COUNT(*) FROM t_photo");
    }

    private Photo mapPhoto(java.sql.ResultSet rs) throws SQLException {
        Photo p = new Photo();
        p.setId(rs.getInt("id"));
        p.setAlbumName(rs.getString("album_name"));
        p.setPhotoPath(rs.getString("photo_path"));
        p.setDescription(rs.getString("description"));
        p.setUploadTime(rs.getTimestamp("upload_time"));
        return p;
    }
}
