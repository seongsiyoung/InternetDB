<%--
  Created by IntelliJ IDEA.
  User: ljm20
  Date: 2024-06-05
  Time: 오후 8:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connection.jsp" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">
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
</style>
    <title>종합 안내</title>
</head>
<body>
<div align="center">
    <!--로고 검색창 마이페이지 알림-->
    <table>
        <tr>
            <td><a href="index.jsp"><img src="./Icon/pagelogo.png" width="260" height="70"></a></td>
            <td>&emsp;&emsp;&emsp;</td>
            <td>
                <div class="search">
                    <input type="text" id="searchbar" name="selectLost" placeholder="분실물 검색">
                    <input type="image" id="searchIcon" alt="검색 버튼" src="./Icon/search.png" width="30" height="30">
                </div>
            </td>
            <td>&emsp;&emsp;&emsp;</td>
            <td>
                <div class="my">
                    <%
                        session = request.getSession(false); // 세션 존재 확인
                        if (session.getAttribute("id") != null) {
                            // 로그인 상태: 마이페이지와 알림 버튼 표시
                            out.println("<input type=\"image\" id=\"mypageIcon\" src=\"./Icon/mypage.png\" alt=\"마이페이지\" width=\"40\" height=\"40\">&nbsp;");
                            out.println("<input type=\"image\" id=\"alarm\" src=\"./Icon/alarm.png\" alt=\"마이페이지\" width=\"45\" height=\"40\">");
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
    <div class="menu-bar">
        <ul class="menu">
            <li><a href="information.jsp" class="menu-link">종합 안내</a></li>
            <li><a href="reportedLostItem.jsp" class="menu-link">신고된 분실물</a></li>
            <li><a href="registeredLostItem.jsp" class="menu-link">등록된 분실물</a></li>
        </ul>
    </div>
    <h3>종합 안내</h3>
    <hr>
</div>
</body>
</html>
