package com.InternetDB.VO;


/**
 *  안읽은 댓글에 대한 알람 목록을 조회할때 필요한 정보를 불러오고, 설정(수정)하기 위한 빈
 */
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

    public void setAlarmStatus(String alarmStatus) {
        this.alarmStatus = alarmStatus;
    }
}
