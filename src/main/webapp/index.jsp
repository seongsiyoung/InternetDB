<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">
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
            flex-grow: 1; /* 각 항목이 유효한 공간을 균등하게 차지하도록 함 */
            text-align: center; /* 항목의 텍스트를 중앙 정렬 */
            padding: 10px 20px; /* 패딩을 조정하여 내용에 여유 공간 제공 */
            margin: 0 5px; /* 양 옆 마진을 조금 주어 간격을 미세 조정 */
            box-sizing: border-box; /* 패딩과 보더가 width와 height에 포함되도록 설정 */
        }

        .menu-bar .menu form {
            width: 100%; /* form을 메뉴 항목과 같은 너비로 설정 */
            margin: 0; /* form의 마진 제거 */
        }

        .menu-bar .menu input[type="submit"] {
            width: 100%; /* 버튼을 form의 전체 너비로 확장 */
            padding: 10px 0; /* 수직 패딩만 조정 */
            background: none; /* 배경 제거 */
            border: none; /* 테두리 제거 */
            color: inherit; /* 상속받은 색상 사용 */
            font: inherit; /* 상속받은 폰트 스타일 사용 */
            font-weight: bold; /* 폰트 굵기를 볼드로 설정 */
            cursor: pointer; /* 커서를 포인터로 표시 */
            margin: 0; /* 마진 제거 */
            box-shadow: none; /* 그림자 제거 */
            text-decoration: none; /* 텍스트 밑줄 제거 */
        }
        }

        .menu-bar .menu input[type="submit"]:hover,
        .menu-bar .menu input[type="submit"]:focus {
            background-color: #f0f0f0; /* 호버 및 포커스 시 배경색 변경 */
            outline: none; /* 포커스 아웃라인 제거 */
        }
    </style>
</head>
<body>
    <div align="center">
        <table>
            <tr>
                <td>로고</td>
                <td>&emsp;&emsp;&emsp;</td>
                <td>
                    <div class="search">
                        <input type="text" placeholder="분실물 검색">
                        <input type="image" alt="검색 버튼" width="30" height="30">
                    </div>
                </td>
                <td>&emsp;&emsp;&emsp;</td>
                <td>
                    <div class="my">
                        <%
                            session = request.getSession(false); // 세션 존재 확인
                            if (session.getAttribute("id") != null) {
                                // 로그인 상태: 마이페이지와 알림 버튼 표시
                                out.println("<input type='image' src='./images/mypage_icon.png' alt='마이페이지'>");
                                out.println("<input type='image' src='./images/alarm_icon.png' alt='알림'>");
                            } else {
                                // 비로그인 상태: 로그인 버튼 표시
                                out.println("<form action='login.jsp' method='post'>");
                                out.println("<input type='submit' value='로그인'>");
                                out.println("</form>");
                            }
                        %>
                    </div>
                </td>
            </tr>
        </table>
        <br>
        <form method="get">
            <div class="menu-bar">
                <ul class="menu">
                    <li>&emsp;&emsp;</li>
                    <li><form action="information.jsp" method="post"><input type="submit" value="종합 안내"></form></li>
                    <li><form action="reportedLostItem.jsp" method="post"><input type="submit" value="신고된 분실물"></form></li>
                    <li><form action="registeredLostItem.jsp" method="post"><input type="submit" value="등록된 분실물"></form></li>
                    <li>&emsp;&emsp;</li>
                </ul>
            </div>
        </form>

        <h3>최근에 이런 분실물들이 등록됐어요!</h3>
        <hr>
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
                    String sql = "SELECT image, path, title FROM LostItem ORDER BY createdat DESC LIMIT 6";
                    pstmt = connection.prepareStatement(sql); // 쿼리 준비
                    rs = pstmt.executeQuery(); // 쿼리 실행

                    while (rs.next()) {
                        String imagePath = rs.getString("path") + rs.getString("image"); // 이미지 경로 조합
                        String title = rs.getString("title"); // 제목 불러오기
                        // HTML 출력
                        out.println("<div class='item'><img src='" + imagePath + "' alt='Lost Item' width='200' height='150'><p>" + title + "</p></div>");
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
