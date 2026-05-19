package com.blog.model;

import java.util.Date;

public class UserFriend {
    private int id;
    private int userId;
    private int friendId;
    private String status;
    private Date createdAt;

    // 用于展示的关联字段
    private String friendNickname;
    private String friendUsername;
    private String friendAvatar;

    public UserFriend() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getFriendId() { return friendId; }
    public void setFriendId(int friendId) { this.friendId = friendId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public String getFriendNickname() { return friendNickname; }
    public void setFriendNickname(String friendNickname) { this.friendNickname = friendNickname; }
    public String getFriendUsername() { return friendUsername; }
    public void setFriendUsername(String friendUsername) { this.friendUsername = friendUsername; }
    public String getFriendAvatar() { return friendAvatar; }
    public void setFriendAvatar(String friendAvatar) { this.friendAvatar = friendAvatar; }
}
