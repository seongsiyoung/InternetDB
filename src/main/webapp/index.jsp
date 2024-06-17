<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
    <link type="text/css" rel="stylesheet" href="./css/itemGallery.css">
    <title>분실물 센터</title>
</head>
<body>
    <div align="center">
        <!--로고 검색창 마이페이지 알림-->
        <%@ include file="headLine.jsp" %>
        <br>
        <div class="menu-bar">
            <ul class="menu">
                <li><a href="information.jsp" class="menu-link">종합 안내</a></li>
                <li><a href="reportedLostItem.jsp" class="menu-link">신고된 분실물</a></li>
                <li><a href="registeredLostItem.jsp" class="menu-link">등록된 분실물</a></li>
            </ul>
        </div>
        <br>
        <h3 style="text-align: center">최근 등록된 분실물</h3>
        <hr>
        <br><br>
        <!--여기에 분실물 이미지 표시를 위한 HTML-->
        <div class="lost-item-gallery">
            <%-- 최근 등록된 분실물 목록 보여주는 스크립틀릿 --%>
            <%
                /*pstmt와 rs는 각각 SQL 쿼리 실행과 쿼리 결과를 다루는데 사용*/
                PreparedStatement pstmt = null; // pstmt 초기화
                ResultSet rs = null;
                try {
                    // 데이터베이스 접속을 위한 코드
                    // LostItem 테이블에서 path, image, title을 선택
                    // createdat 기준으로 내림차순 정렬하여 최신 항목을 보여줌, 최근 등록된 분실물 9개만 표시

                    String sql = "SELECT lost_id, image, path, title, type FROM LostItem ORDER BY createdat DESC LIMIT 9";

                    pstmt = connection.prepareStatement(sql); // 쿼리 준비
                    rs = pstmt.executeQuery(); // 쿼리 실행

                    while (rs.next()) {
                        Long lost_id = rs.getLong("lost_id");
                        String image = rs.getString("image");
                        String imagePath = rs.getString("path") + image; // 이미지 경로 조합
                        String title = rs.getString("title"); // 제목 불러오기

                        // HTML 출력
                        if (rs.getString("type").equals("lost")) {
                        out.println("<div class='item'><a href='DetailLost.jsp?lost_id="+ lost_id +"'><img src='" + imagePath + "' alt='Lost Item' width='200' height='150'></a><p>" + title + "</p></div>");
                        } else {
                        out.println("<div class='item'><a href='DetailReport.jsp?lost_id="+ lost_id +"'><img src='" + imagePath + "' alt='Lost Item' width='200' height='150'></a><p>" + title + "</p></div>");
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    // 자원 해제
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                }
            %>
        </div>
    </div>
</body>
</html>
