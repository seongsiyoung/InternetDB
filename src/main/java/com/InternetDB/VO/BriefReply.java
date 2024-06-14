package com.InternetDB.VO;

public class BriefReply {
    private Long lostId;
    private Long replyId;
    private String alarmContent;
    private String lostIdType;
    private String alarmStatus;

    public Long getLostId() {
        return lostId;
    }

    public void setLostId(Long lostId) {
        this.lostId = lostId;
    }

    public Long getReplyId() {
        return replyId;
    }

    public void setReplyId(Long replyId) {
        this.replyId = replyId;
    }

    public String getAlarmContent() {
        return alarmContent;
    }

    public void setAlarmContent(String alarmContent) {
        this.alarmContent = alarmContent;
    }

    public String getLostIdType() {
        return lostIdType;
    }

    public void setLostIdType(String lostIdType) {
        this.lostIdType = lostIdType;
    }

    public String getAlarmStatus() {
        return alarmStatus;
    }

    public void setAlaramStatus(String alaramStatus) {
        this.alarmStatus = alaramStatus;
    }
}
