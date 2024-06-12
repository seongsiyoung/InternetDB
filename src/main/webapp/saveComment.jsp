<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>
<%@ include file="connection.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="reply" class="com.InternetDB.ReplyBean" scope="page"/>
<jsp:setProperty name="reply" property="*"/>

<html>
<head>
    <title></title>
</head>
<body>
<%
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;

    ResultSet rs = null;

    String sql = "INSERT INTO reply(content, lost_id, user_id) VALUES(?,?,?)";
    String sql2 = "SELECT type FROM lostitem where lost_id = ?";

    try {

        pstmt = connection.prepareStatement(sql);

        pstmt.setString(1, reply.getContent());
        pstmt.setLong(2, reply.getLostId());
        pstmt.setString(3, reply.getUserId());

        int rows = pstmt.executeUpdate();
        if(rows > 0){
            pstmt2 = connection.prepareStatement(sql2);

            pstmt2.setLong(1, reply.getLostId());

            rs = pstmt2.executeQuery();

            if(rs.next()) {
                String type =rs.getString("type");
                if (type.equals("lost"))
                    response.sendRedirect("DetailLost.jsp?lost_id="+reply.getLostId() );
                else
                    response.sendRedirect("DetailReport.jsp?lost_id="+ reply.getLostId());
            }

        }



    } catch (SQLException e) {
        e.printStackTrace();
    } finally {

        if (pstmt != null)
            pstmt.close();
        if (connection != null)
            connection.close();
    }
%>

</body>
</html>
