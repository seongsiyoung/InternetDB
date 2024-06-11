<%@ page contentType ="text/html; charset=utf-8" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="reply" class="com.InternetDB.ReplyBean" scope="page"/>
<jsp:setProperty name="reply" property="*"/>
