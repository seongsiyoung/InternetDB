<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="com.InternetDB.util.Encrytor" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="com.InternetDB.UserBean" scope="page"/>
<jsp:setProperty name="user" property="*"/>

<%!

    //사용자 정보 형식 검증 메서드
    boolean validateUserId(String userId){
        return userId.matches("^[a-z0-9]+@[a-z]+\\.[a-z]{2,3}$");
    }

    boolean validatePassword(String password){
        return password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{4,14}$");
    }

    boolean validateNickname(String nickname){
        return nickname.matches("^(?=.*[a-zA-Z가-힣])[a-zA-Z가-힣\\d]{4,14}$");
    }

    boolean validateName(String name){
        return  name.matches("^[가-힣]{2,5}$");
    }

    boolean validatePhone(String phone){
        return phone.matches("^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$");
    }

%>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="connection.jsp" %>

<%
    if (!validateUserId(user.getUserId())) {
        Alert.alertAndBack(response, "아이디의 형식 올바르지 않습니다.");

    } else if (!validatePassword(user.getPassword())) {
        Alert.alertAndBack(response, "비밀번호 형식 올바르지 않습니다.");

    } else if (!validateNickname(user.getNickname())) {
        Alert.alertAndBack(response, "닉네임 형식 올바르지 않습니다.");

    } else if (!validateName(user.getName())) {
        Alert.alertAndBack(response, "이름의 형식 올바르지 않습니다.");

    } else if (!validatePhone(user.getPhone())) {
        Alert.alertAndBack(response, "핸드폰 형식 올바르지 않습니다.");

    } else {

        //비밀번호 암호화
        user.setPassword(Encrytor.encryptPassword(user.getPassword(),user.getSalt()));

        String sql = null;
        PreparedStatement statement = null;
        ResultSet rs = null;


        try {
            //아이디 중복체크
            sql = "SELECT user_id FROM User WHERE user_id = ?";

            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUserId());
            rs = statement.executeQuery();
            if(rs.next())
                Alert.alertAndMove(response,"중복된 아이디입니다.","signUp.jsp");

            //닉네임 중복체크
            sql = "SELECT nickname FROM User WHERE nickname = ?";

            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getNickname());
            rs = statement.executeQuery();
            if(rs.next())
                Alert.alertAndMove(response, "중복된 닉네임입니다.", "signUp.jsp");

            sql = "INSERT INTO User (user_id, password, salt, name, nickname, phone, createdAt) VALUES (?,?,?,?,?,?,?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUserId());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getSalt());
            statement.setString(4, user.getName());
            statement.setString(5, user.getNickname());
            statement.setString(6, user.getPhone());
            statement.setString(7, user.getCreatedAt());
            statement.executeUpdate();

        } catch (SQLException e) {

            e.printStackTrace();
            request.getRequestDispatcher("/servererror.jsp").forward(request, response);

        } finally {
            if (rs != null)
                rs.close();
            if (statement != null)
                statement.close();
            if (connection != null)
                connection.close();
        }

        response.sendRedirect("login.jsp");
    }
%>

</body>
</html>
