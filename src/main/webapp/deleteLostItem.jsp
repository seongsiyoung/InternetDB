<%@ page import="com.InternetDB.util.Alert" %>
<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="css/lostitems.css">
    <title>게시물 삭제</title>
</head>
<body>
<%@ include file="headLine.jsp" %>      // 검색창 헤드라인 include
<%@ include file="connection.jsp" %>    // 데이터베이스 연결 코드 include
<%
    // 작성된 게시글의 분실물 id를 받아와서 해당 분실물 데이터를 데이터베이스에서 삭제하는 코드
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
    // 게시글이 삭제되면 메인 페이지로 이동
    Alert.alertAndMove(response, "게시글이 삭제되었습니다.", "index.jsp");
    %>
</body>
</html>