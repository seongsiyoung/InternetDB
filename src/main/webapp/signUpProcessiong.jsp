<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="com.InternetDB.util.Encrytor" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="com.InternetDB.UserBean" scope="page"/>
<jsp:setProperty name="user" property="*"/>

<%!
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

        user.setPassword(Encrytor.encryptPassword(user.getPassword(),user.getSalt()));

        String sql2 = "SELECT user_id FROM User WHERE user_id = ?";

        String sql3 = "SELECT nickname FROM User WHERE nickname = ?";

        String sql = "INSERT INTO User (user_id, password, salt, name, nickname, phone, createdAt) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement statement = null;
        PreparedStatement statement2 = null;
        PreparedStatement statement3 = null;
        ResultSet rs = null;


        try {
            statement2 = connection.prepareStatement(sql2);

            statement2.setString(1, user.getUserId());

            rs = statement2.executeQuery();

            if(rs.next())
                Alert.alertAndMove(response,"중복된 아이디입니다.","signUp.jsp");

            statement3 = connection.prepareStatement(sql3);

            statement3.setString(1, user.getNickname());

            rs = statement3.executeQuery();

            if(rs.next())
                Alert.alertAndMove(response, "중복된 닉네임입니다.", "signUp.jsp");

            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUserId());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getSalt());
            statement.setString(4, user.getName());
            statement.setString(5, user.getNickname());
            statement.setString(6, user.getPhone());
            statement.setString(7, user.getCreatedAt());

            int result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/temp/temperror.jsp").forward(request, response);
        } finally {

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
