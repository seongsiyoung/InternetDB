<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.InternetDB.util.Encrytor" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String sessionPassword = (String) session.getAttribute("password");

    String password = Encrytor.encryptPassword(request.getParameter("oldPassword"), (String) session.getAttribute("salt"));
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
    //입력한 비밀번호가 현재 로그인한 비밀번호와 다르다면 탈퇴 불가
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
            request.getRequestDispatcher("/servererror.jsp").forward(request, response);
        } finally {

            if (statement != null)
                statement.close();
            if (connection != null)
                connection.close();
        }

        session.invalidate();  //회원정보 삭제 후 세션 초기화
        Alert.alertAndMove(response, "회원 탈퇴가 완료되었습니다.", "login.jsp");
    }
%>
</body>
</html>
