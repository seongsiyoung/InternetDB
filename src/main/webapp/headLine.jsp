<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
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
                <form method="post" action="" style="margin-bottom: -16px">
                <div class="search">
                    <select name="type" id="lang" style="float: left; display: inline-block; margin-top: 15px; margin-left: 5px; border: none; border-radius: 0px">
                        <option value="found">신고된</option>
                        <option value="lost">등록된</option>
                    </select>
                    <input type="text" id="searchbar" name="search" placeholder="분실물 검색">
                    <button type="submit" onclick="alert('클릭!')" style="border: 0; background-color: transparent;float: right;">
                        <input type="image" id="searchIcon" src="./Icon/search.png" alt="검색 버튼" width="30" height="30">
                    </button>
                </div>
                </form>
            </td>
            <td>&emsp;&emsp;&emsp;&emsp;</td>
            <div class="my">
            </div>
            <td>
                    <%
                            System.out.println("test for session");
                            session = request.getSession(false); // 세션 존재 확인

                            if (session.getAttribute("id") != null) {
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try {
                                    String sql = "SELECT r.lost_id, r.content from reply r join lostitem li on r.lost_id = li.lost_id where li.user_id = ?";

                                    pstmt = connection.prepareStatement(sql);
                                    pstmt.setString(1, session.getId());
                                    rs = pstmt.executeQuery();

                                    while (rs.next()) {
                                        Long lost_id = rs.getLong("lost_id");
                                        String content = rs.getString("content");
                                    }

                                } catch (SQLException e){
                                    e.printStackTrace();
                                } finally {
                                    if (rs != null) {rs.close();}
                                    if (pstmt != null) {pstmt.close();}
                                }
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

