package com.blog.model;

import java.util.Date;

public class Message {
    private int id;
    private String visitorName;
    private String visitorEmail;
    private String content;
    private String ipAddress;
    private Date createdAt;

    public Message() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
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
}
