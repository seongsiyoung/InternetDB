package com.InternetDB;

public class AlarmBean {
    private String id;
    private String status;
    private String content;
    private String createdAt;

    public String getId(){
        return id;
    }
    public void setId(String id){
        this.id = id;
    }
    public String getStatus(){
        return status;
    }
    public void setStatus(String status){
        this.status = status;
    }
    public String getContent(){
        return content;
    }
    public void setContent(String content){
        this.content = content;
    }
    public String getCreatedAt(){
        return createdAt;
    }
    public void setCreatedAt(String createdAt){
        this.createdAt = createdAt;
    }
}
