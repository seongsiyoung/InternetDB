<%@ page import="com.InternetDB.util.Alert" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    session.invalidate();
    Alert.alertAndMove(response, "로그아웃 되었습니다", "/index.jsp");
%>
</body>
</html>
