<%@ page pageEncoding="UTF-8"%>
<link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">
<link type="text/css" rel="stylesheet" href="./css/itemGallery.css">

<div align="center">
    <table>
        <tr>
            <td>
                <button type="button" onclick="location.href = 'index.jsp' " style="border: 0; background-color: transparent;">
                    <input type="image" id="mainIcon" src="./Icon/pagelogo.png" alt="검색 버튼" width="260" height="70">
                </button>
            <td>&emsp;&emsp;&emsp;</td>

            <td>
                <div class="search">
                    <input type="text" id="searchbar" name="selectLost" placeholder="분실물 검색">
                    <button type="button" onclick="alert('클릭!')" style="border: 0; background-color: transparent;float: right;">
                        <input type="image" id="searchIcon" src="./Icon/search.png" alt="검색 버튼" width="30" height="30">
                    </button>
                </div>
            </td>
            <td>&emsp;&emsp;&emsp;&emsp;</td>
            <div class="my">
            </div>
            <td>
                    <%
                            System.out.println("test for session");
                            session = request.getSession(false); // 세션 존재 확인

                            if (session.getAttribute("id") != null) {
                                // 로그인 상태: 마이페이지와 알림 버튼 표시
                                out.println("<button type=\"button\" onclick=\"location.href = 'mypage.jsp'\" style=\"border: 0; background-color: transparent;\">\n" );
                                out.println("<input type=\"image\" id=\"mypageIcon\" src=\"./Icon/mypage.png\" alt=\"마이페이지\" width=\"40\" height=\"40\"></button>");
                                out.println("<button type=\"button\" onclick=\"alert('클릭!')\" style=\"border: 0; background-color: transparent;\">");
                                out.println("<input type=\"image\" id=\"alarm\" src=\"./Icon/alarm.png\" alt=\"알림\" width=\"45\" height=\"40\"></button>");
                                out.println("<button type=\"button\" onclick=\"location.href = '/processing/LoginoutProcessing.jsp'\" style=\"border: 0; background-color: transparent;\">");
                                out.println("<input type=\"image\" id=\"logout\" src=\"./Icon/logout.png\" alt=\"로그아웃\" width=\"45\" height=\"40\"></button>");

                            } else {
                                // 비로그인 상태: 로그인 버튼 표시
                                out.println("<form action='login.jsp' method='post'>");
                                out.println("<input class='register-button' type='submit' value='로그인' style=\"margin-bottom: -16px\">");
                                out.println("</form>");
                            }
                        %>
</div>
            </td>
        </tr>
    </table>
</div>

