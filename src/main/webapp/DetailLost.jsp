<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp"%>
<html>
    <head>
    <link type="text/css" rel="stylesheet" href="./css/mystyle.css">
    <title>분실물 등록 상세</title>
    </head>
    <body>
          <%@ include file="headLine.jsp" %>
          <br>
          <h2>&emsp;분실물 등록 상세</h2>
          <hr></hr>
          <br>
          <div class="postSection" align="center">
            <%
                String lostIdStr = request.getParameter("lost_id");
                if (lostIdStr != null && !lostIdStr.isEmpty()) {
                    Long lost_id = Long.parseLong(lostIdStr);
                    String sql = "select * from lostitem where lost_id = ?";
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        pstmt = connection.prepareStatement(sql);
                        pstmt.setLong(1, lost_id);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String imagePath = rs.getString("path") + rs.getString("image");
                            String title = rs.getString("title");
                            String location = rs.getString("location");
                            String time = rs.getString("time");
                            String category = rs.getString("category");
                            String status = rs.getString("status");
                            String content = rs.getString("content");
                            String user_id = rs.getString("user_id");
            %>
            <table>
                       <tr>
                       <td><div class="imgSec"><img id="lostImage" src="<%= imagePath%>" width="350px" height="300px" /></div></td>

                       <td><div class="lostInfoSec">
                           분실물명 : <%= title %><br>
                           분실일 : <%= time %> <br>
                           분실예상장소 : <%= location %> <br>
                           물품분류 : <%= category %> <br>
                           분실상태 : <%= status %>  <br>
                           연락처 :
                           </div></td>

                       </tr>
                       <tr>

                       </tr>
                       <tr>

                       </tr>
                       <tr>
                       <td colspan="2"> <br> &emsp;내용 </td>
                       </tr>
                       <tr>
                       <td colspan="2"> <br> <div class ="contentSec"> <%= content %> </div></td>
                       </tr>
                       <%
                                   if(session.getAttribute("id").equals(user_id)) {
                                       out.println("<td colspan='2'><br><div class='ModifyAndDelete'><button id='mdBtn'>수정</button> <button id='mdBtn'>삭제</button></div></td></tr>");
                                   }
                       %>
                  </table>
                  <%
                                } else {
                                out.println("해당 분실물 정보를 찾을 수 없습니다.");
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                            }
                      } else {
                            out.println("유효한 이미지 uuid가 전달되지 않았습니다.");
                      }
                  %>
            </form>
          </div>
          <br>
          <hr>
          <div class="commentSec" align="center">

                    <div class="commentBtnSec" align="center">
                    <img id="commentIcon" src="./Icon/comment.png">
                    <button id ="commentBtn">댓글 </button>
                    </div>

            <br>
          <div class="commentWrite" align="center">
              <form method="post" action="" class="commentForm">
                    <table class="commentTable" style="text-align: center;" borer="1">
                            <tr>
                                <td align="left">userID</td>
                            </tr>
                            <tr>
                                <td><textarea id="commentWriteSec" name="comment" style="border:none;"
                                    placeholder="댓글 쓰기"></textarea></td>
                            </tr>
                            <tr>
                                <td><input type="submit" id="commentWriteBtn" value="등록"></td>
                            </tr>
                    </table>
              </form>
          </div>
    </body>
</html>