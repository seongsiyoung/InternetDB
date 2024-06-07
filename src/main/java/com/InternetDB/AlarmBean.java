package com.InternetDB;

public class AlarmBean {
    private Long alarmId;
    private String status;
    private String content;
    private String createdAt;
    private Long replyId;
    private String userId;

    public Long getAlarmId() {
        return alarmId;
    }
    public void setAlarmId(Long alarmId) {
        this.alarmId = alarmId;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    public Long getReplyId() {
        return replyId;
    }
    public void setReplyId(Long replyId) {
        this.replyId = replyId;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
}
