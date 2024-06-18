<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page pageEncoding="UTF-8"%>

<link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
<link type="text/css" rel="stylesheet" href="./css/itemGallery.css?after">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<div align="center">
    <table>
        <tr>
            <td>
                <button type="button" onclick="location.href = 'index.jsp' " style="border: 0; background-color: transparent;">
                    <input type="image" id="mainIcon" src="./Icon/pagelogo.png" alt="검색 버튼" width="260" height="70">
                </button>
            <td>&emsp;&emsp;&emsp;</td>

            <td>
                <form method="post" action="search.jsp" style="margin-bottom: -16px">
                <div class="search">
                    <select name="type" id="lang" style="float: left; display: inline-block; margin-top: 15px; margin-left: 5px; border: none; border-radius: 0px">
                        <option value="found" selected>신고된</option>
                        <option value="lost">등록된</option>
                    </select>
                    <input type="text" id="searchbar" name="search" placeholder="분실물 검색" required>
                    <button type="submit" style="border: 0; background-color: transparent;float: right;">
                        <input type="image" id="searchIcon" src="./Icon/search.png" alt="검색 버튼" width="30" height="30">
                    </button>
                </div>
                </form>
            </td>
            <td>&emsp;&emsp;&emsp;&emsp;</td>
            <div class="my">
            </div>
            <td>
                <div id="myModal" class="alarm-modal">
                    <div class="alarm-modal-content">
                        <span class="close">&times;</span>
                        <h2>내 게시물에 달린 댓글</h2>
                        <p id="notificationContent">Notifications will appear here...</p>
                    </div>
                </div>
                    <%
                            session = request.getSession(false); // 세션 존재 확인

                            if (session.getAttribute("id") != null) {
                                // 로그인 상태: 마이페이지와 알림 버튼 표시
                                out.println("<button type=\"button\" onclick=\"location.href = 'mypage.jsp'\" style=\"border: 0; background-color: transparent;\">\n" );
                                out.println("<input type=\"image\" id=\"mypageIcon\" src=\"./Icon/mypageIcon.png\" alt=\"마이페이지\" width=\"55\" height=\"40\"></button>");
                                out.println("<button type=\"button\" style=\"border: 0; background-color: transparent;\">");
                                out.println("<input type=\"image\" id=\"alarm\" src=\"./Icon/alarm.png\" alt=\"알림\" width=\"45\" height=\"40\"></button>");
                                out.println("<button type=\"button\" onclick=\"location.href = '/processing/LoginoutProcessing.jsp'\" style=\"border: 0; background-color: transparent;\">");
                                out.println("<input type=\"image\" id=\"logout\" src=\"./Icon/logout.png\" alt=\"로그아웃\" width=\"45\" height=\"40\"></button>");

                            } else {
                                // 비로그인 상태: 로그인 버튼 표시
                                out.println("<button type=\"button\" onclick=\"location.href = 'login.jsp'\" style=\"border: 0; background-color: transparent;\">\n" );
                                out.println("<input type=\"image\" id=\"login\" src=\"./Icon/login.png\" alt=\"로그인\" width=\"95\" height=\"40\"></button>");
                            }
                        %>
                <script src="./js/script.js"></script>

            </td>
        </tr>
    </table>
</div>

