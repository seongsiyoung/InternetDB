<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: ljm20
  Date: 2024-06-13
  Time: 오후 8:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connection.jsp"%>
<%
    String result="";
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    ArrayList<Long> list = new ArrayList<Long>();

    try{
        String sql = "SELECT r.reply_id, r.lost_id, r.content from reply r join lostitem li on r.lost_id = li.lost_id where li.user_id = ?";

        pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, (String) session.getAttribute("id"));
        rs = pstmt.executeQuery();
        while (rs.next()) {
            result += "<div><a href='DetailReport.jsp?lost_id="+ rs.getLong("lost_id")+"'>" + rs.getString("content")+"</a></div><hr>";
            list.add(rs.getLong("reply_id"));
        }
    } catch (SQLException e){
        e.printStackTrace();
    } finally {
        if (rs != null) {rs.close();}
        if (pstmt != null) {pstmt.close();}
    }

    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(result);
%>