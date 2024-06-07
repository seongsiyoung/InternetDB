<%@ page import="com.InternetDB.util.Alert" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String sessionPassword = (String) session.getAttribute("password");

    String password = request.getParameter("oldPassword");

%>
<jsp:useBean id="user" class="com.InternetDB.UserBean" scope="page"/>
<jsp:setProperty name="user" property="*"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="connection.jsp" %>

<%
    if(!password.equals(sessionPassword)) {
        Alert.alertAndBack(response, "비밀번호가 달라 수정할 수 없습니다.");
    } else {


        String sql = "UPDATE  User SET password = ?, name = ?, nickname = ?, phone = ? WHERE user_id = ?";
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getPassword());
            statement.setString(2, user.getName());
            statement.setString(3, user.getNickname());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getUserId());


            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/temp/temperror.jsp").forward(request, response);
        } finally {

            if (statement != null)
                statement.close();
            if (connection != null)
                connection.close();
        }
        session.setAttribute("password", user.getPassword());
        Alert.alertAndMove(response, "회원 정보 수정이 완료되었습니다.", "mypage.jsp");
    }

%>

</body>
</html>
