<%@ page import="com.InternetDB.util.Alert" %>
<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="css/lostitems.css">
    <title>게시물 삭제</title>
</head>
<body>
<%@ include file="headLine.jsp" %>
<%@ include file="connection.jsp" %>
<%
    String lostIdStr = request.getParameter("lost_id");
    if (lostIdStr != null && !lostIdStr.isEmpty()) {
        Long lost_id = Long.parseLong(lostIdStr);
        String sql = "delete from lostitem WHERE lost_id = ?";

        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        ResultSet rs = null;

        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setLong(1, lost_id);
            pstmt.executeUpdate();


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null)
                pstmt.close();
            if (rs != null)
                rs.close();
            if (connection != null)
                connection.close();
        }
    }
    Alert.alertAndMove(response, "게시글이 삭제되었습니다.", "index.jsp");
    %>

</body>
</html>