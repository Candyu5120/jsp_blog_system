package com.blog.model;

import java.util.Date;

public class Photo {
    private int id;
    private String albumName;
    private String photoPath;
    private String description;
    private Date uploadTime;

    public Photo() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getAlbumName() { return albumName; }
    public void setAlbumName(String albumName) { this.albumName = albumName; }
    public String getPhotoPath() { return photoPath; }
    public void setPhotoPath(String photoPath) { this.photoPath = photoPath; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getUploadTime() { return uploadTime; }
    public void setUploadTime(Date uploadTime) { this.uploadTime = uploadTime; }
}
