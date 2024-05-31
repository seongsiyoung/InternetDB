package com.InternetDB;

import java.time.LocalDateTime;

public class ReplyBean {
    private Long replyId;
    private String content;
    private LocalDateTime createdAt;
    private Long lostId;
    private String userId;

    public Long getReplyId() {
        return replyId;
    }
    public void setReplyId(Long replyId) {
        this.replyId = replyId;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public Long getLostId() {
        return lostId;
    }
    public void setLostId(Long lostId) {
        this.lostId = lostId;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
}
