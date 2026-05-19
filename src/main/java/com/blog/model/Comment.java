package com.blog.model;

import java.util.Date;

public class Comment {
    private int id;
    private int articleId;
    private String visitorName;
    private String visitorEmail;
    private String content;
    private String ipAddress;
    private Date createdAt;

    // Transient
    private String articleTitle;

    public Comment() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getArticleId() { return articleId; }
    public void setArticleId(int articleId) { this.articleId = articleId; }
    public String getVisitorName() { return visitorName; }
    public void setVisitorName(String visitorName) { this.visitorName = visitorName; }
    public String getVisitorEmail() { return visitorEmail; }
    public void setVisitorEmail(String visitorEmail) { this.visitorEmail = visitorEmail; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public String getArticleTitle() { return articleTitle; }
    public void setArticleTitle(String articleTitle) { this.articleTitle = articleTitle; }
}
