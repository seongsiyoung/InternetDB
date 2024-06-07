<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
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
    String sql = "INSERT INTO User (user_id, password, salt, name, nickname, phone, createdAt) VALUES (?,?,?,?,?,?,?)";
    PreparedStatement statement = null;

    try {
        statement = connection.prepareStatement(sql);
        statement.setString(1, user.getUserId());
        statement.setString(2, user.getPassword());
        statement.setString(3, user.getSalt());
        statement.setString(4, user.getName());
        statement.setString(5, user.getNickname());
        statement.setString(6, user.getPhone());
        statement.setString(7, user.getCreatedAt());

        int result = statement.executeUpdate();

    } catch (SQLException e){
        e.printStackTrace();
        request.getRequestDispatcher("/temp/temperror.jsp").forward(request, response);
    } finally {

        if(statement != null)
            statement.close();
        if(connection != null)
            connection.close();
    }
    response.sendRedirect("login.jsp");

%>

</body>
</html>
