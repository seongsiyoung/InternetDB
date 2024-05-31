package com.InternetDB;

public class UserBean {
    private String id;
    private String salt;
    private String password;
    private String name;
    private String nickName;
    private String phone;
    private String createAt;

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getSalt() {
        return salt;
    }
    public void setSalt(String salt) {
        this.salt = salt;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getNickName(){
        return nickName;
    }
    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getCreateAt() {
        return createAt;
    }
    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }
}
