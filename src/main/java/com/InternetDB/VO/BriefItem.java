package com.InternetDB.VO;

/**
 * 아이템 목록을 조회할 때 필요한 정보만 불러오도록 설정
 */
public class BriefItem {

    private Long lostId;
    private String title;
    private String type;
    private String image;
    private String path;

    public Long getLostId() {
        return lostId;
    }

    public void setLostId(Long lostId) {
        this.lostId = lostId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
