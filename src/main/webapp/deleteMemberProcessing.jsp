<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="java.sql.PreparedStatement" %>
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
        Alert.alertAndBack(response, "비밀번호가 달라 탈퇴할 수 없습니다.");
    } else {
        String sql = "Delete From User WHERE user_id = ?";
        PreparedStatement statement = null;

        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUserId());

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

        session.invalidate();
        Alert.alertAndMove(response, "회원 탈퇴가 완료되었습니다.", "login.jsp");
    }
%>
</body>
</html>
