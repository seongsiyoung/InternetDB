<%@ page import="com.InternetDB.util.Alert" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("id") != null){
        Alert.alertAndBack(response, "이미 로그인 중입니다. 로그아웃 후 다시 시도해주십시오.");
    }
%>

<html>
<head>

    <link type="text/css" rel="stylesheet" href="./css/login.css?after">

    <title>Login</title>
</head>
<body class="align">

<div class="grid">

    <button type="button" onclick="location.href = 'index.jsp' " style="border: 0; background-color: transparent;">
        <input type="image" id="mainIcon" src="./Icon/pagelogo.png" alt="검색 버튼">
    </button>
    <form action= loginProcessing.jsp method="POST" class="form login">

        <div class="form__field">
            <label for="login__username"></label><input autocomplete="username" id="login__username" type="text" name="id" class="form__input" placeholder="Username" required>
        </div>

        <div class="form__field">
            <label for="login__password"></label><input id="login__password" type="password" name="password" class="form__input" placeholder="Password" required>
        </div>

        <div class="form__field">
            <input type="submit" value="로그인">
        </div>

    </form>

    <p class="text--center">아직 회원이 아니신가요?<br>
        <a href="signUp.jsp">회원가입 하기</a></p>
</div>
</body>
</html>
