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
    PreparedStatement pstmt3 = null;

    ResultSet rs = null;

    String sql = "INSERT INTO reply(content, lost_id, user_id) VALUES(?,?,?)";
    String sql2 = "SELECT type, title FROM lostitem where lost_id = ?";
    String sql3 = "INSERT INTO alarm(status, content, reply_id, user_id) values (?,?,?,?)";

    try {

        pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        pstmt.setString(1, reply.getContent());
        pstmt.setLong(2, reply.getLostId());
        pstmt.setString(3, reply.getUserId());

        int rows = pstmt.executeUpdate();
        if(rows > 0){

            ResultSet generatedKeys = pstmt.getGeneratedKeys();
            if(generatedKeys.next()) {
                Long replyId = generatedKeys.getLong(1);

                pstmt2 = connection.prepareStatement(sql2);

                pstmt2.setLong(1, reply.getLostId());

                rs = pstmt2.executeQuery();

                if(rs.next()) {
                    String type =rs.getString("type");
                    String title = rs.getString("title");

                    pstmt3 = connection.prepareStatement(sql3);
                    pstmt3.setString(1, "unread");
                    pstmt3.setString(2, "게시글 " + "\"" + title + "\"에 새 댓글이 달렸습니다.");
                    pstmt3.setLong(3, replyId);
                    pstmt3.setString(4, reply.getUserId());
                    pstmt3.executeUpdate();

                    if (type.equals("lost"))
                        response.sendRedirect("DetailLost.jsp?lost_id="+reply.getLostId() );
                    else
                        response.sendRedirect("DetailReport.jsp?lost_id="+ reply.getLostId());
                }
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null)
            rs.close();
        if (pstmt3 != null)
            pstmt3.close();
        if (pstmt2 != null)
            pstmt2.close();
        if (pstmt != null)
            pstmt.close();
        if (connection != null)
            connection.close();
    }
%>

</body>
</html>
