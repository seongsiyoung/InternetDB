package com.InternetDB;

public class ReplyBean {
    private String id;
    private String content;
    private String createdAt;

    public String getId(){
        return id;
    }
    public void setId(String id){
        this.id = id;
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
