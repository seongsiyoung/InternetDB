<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
    <link type="text/css" rel="stylesheet" href="./css/itemGallery.css">

    <title>분실물 센터</title>
    <style>
        .menu-bar {
            width: 100%;
        }

        .menu {
            width: 100%;
            display: flex;
            justify-content: space-evenly; /* 각 항목 간 동일한 간격 유지 */
            list-style-type: none;
            margin: 0;
            overflow: hidden;
            padding: 0;
        }

        .menu li {
            flex: 1 1 0px; /* 각 항목이 유효한 공간을 균등하게 차지하도록 함 */
            text-align: center; /* 항목의 텍스트를 중앙 정렬 */
            padding: 10px 20px; /* 패딩을 조정하여 내용에 여유 공간 제공 */
            margin: 0 5px; /* 양 옆 마진을 조금 주어 간격을 미세 조정 */
            box-sizing: border-box; /* 패딩과 보더가 width와 height에 포함되도록 설정 */
        }

        .menu-bar .menu form {
            width: 100%; /* form을 메뉴 항목과 같은 너비로 설정 */
            margin: 0; /* form의 마진 제거 */
        }

        .menu-link {
            display: block;
            width: 100%;
            padding: 10px 0;
            text-decoration: none;
            color: inherit;
            font-weight: bold;
            text-align: center;
            background: none;
            border: none;
            cursor: pointer;
        }

        .menu-link:hover, .menu-link:focus {
            background-color: #f0f0f0;
        }

        h3 {
            text-align: center;
        }
    </style>
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
        <h3>최근 등록된 분실물</h3>
        <hr>
        <br><br>
        <!--여기에 분실물 이미지 표시를 위한 HTML-->
        <div class="lost-item-gallery">
            <%
                /*pstmt와 rs는 각각 SQL 쿼리 실행과 쿼리 결과를 다루는데 사용*/
                PreparedStatement pstmt = null; // pstmt 초기화
                ResultSet rs = null;
                try {
                    // 데이터베이스 접속을 위한 코드
                    // LostItem 테이블에서 path, image, title을 선택
                    // createdat 기준으로 내림차순 정렬하여 최신 항목을 보여줌, LIMIT 6은 6개로 제한하여 최근 등록된 분실물 6개만 표시

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
