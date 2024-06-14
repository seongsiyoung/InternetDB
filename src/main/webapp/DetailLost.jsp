<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp"%>
<html>
    <head>
    <link type="text/css" rel="stylesheet" href="css/lostitems.css">
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
                String userId =(String) session.getAttribute("id");
                if (lostIdStr != null && !lostIdStr.isEmpty()) {
                    Long lost_id = Long.parseLong(lostIdStr);
                    String sql = "SELECT l.*, u.phone FROM lostitem l JOIN user u ON l.user_id = u.user_id WHERE l.lost_id = ?";
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    Map<String, String> categoryMap = new HashMap<>();
                    categoryMap.put("none","===선택===");
                    categoryMap.put("accessory","악세사리");
                    categoryMap.put("electronics","전자제품");
                    categoryMap.put("card","신용/체크카드");
                    categoryMap.put("others","기타");

                    Map<String, String> statusMap = new HashMap<>();
                    statusMap.put("lost", "분실");
                    statusMap.put("end", "물품 주인 수령");

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
                            String phone = rs.getString("phone");

                            String categoryInKorean = categoryMap.getOrDefault(category, category);
                            String statusInKorean = statusMap.getOrDefault(status, status);
            %>
            <table>
                       <tr>
                       <td><div class="imgSec"><img id="lostImage" src="<%= imagePath%>" width="350px" height="300px" /></div></td>

                       <td><div class="lostInfoSec">
                           분실물명 : <%= title %><br>
                           분실일 : <%= time %> <br>
                           분실예상장소 : <%= location %> <br>
                           물품분류 : <%= categoryInKorean %> <br>
                           분실상태 : <%= statusInKorean %>  <br>
                           연락처 : <%=phone%>
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
                           if(session.getAttribute("id") != null) {
                                   if(session.getAttribute("id").equals(user_id)) {
                                       out.println("<td colspan='2'><br><div class='ModifyAndDelete'><button id='mdBtn' onclick=\"location.href='modifyLost.jsp?lost_id=" + lost_id + "'\">수정</button><button id='mdBtn' onclick=\"location.href='deleteLostItem.jsp?lost_id=" + lost_id + "'\">삭제</button></div></td></tr>");
                                   }
                           }
                       %>
                  </table>

          </div>
          <br>
          <hr>
          <div class="commentSec" align="center">

                    <div class="commentBtnSec" align="center">
                    <img id="commentIcon" src="./Icon/comment.png">
                    <button id ="commentBtn">댓글 </button>
                    </div>

            <br>
              <div class="savedCommentSec">
                  <%
                      /*pstmt와 rs는 각각 SQL 쿼리 실행과 쿼리 결과를 다루는데 사용*/
                      PreparedStatement pstmt2 = null; // pstmt 초기화
                      ResultSet rs2 = null;
                      try {

                          String sql2 = "SELECT user_id, content, createdat FROM reply where lost_id = ?";

                          pstmt2 = connection.prepareStatement(sql2); // 쿼리 준비
                          pstmt2.setLong(1, lost_id);
                          rs2 = pstmt2.executeQuery(); // 쿼리 실행

                          while (rs2.next()) {
                              String user_id2 = rs2.getString("user_id");
                              String content2 = rs2.getString("content");
                              String createdat = rs2.getString("createdat");
                              // 조회된 댓글출력
                              out.println("<table class=\"savedCommentTable\">\n");
                              out.println("<tr><td align=\"left\">" +  user_id2  + "</td></tr>");
                              out.println("<tr><td>" + content2 +" </td></tr>");
                              out.println("<tr><td align=\"left\"><div class='commentTime'>" +  createdat  + "</div></td></tr>");
                              out.println("</table>");
                              out.println("<br>");

                          }
                      } catch (SQLException e) {
                          e.printStackTrace();
                      } finally {
                          // 자원 해제
                          if (rs2 != null) try { rs2.close(); } catch (SQLException ignore) {}
                          if (pstmt2 != null) try { pstmt2.close(); } catch (SQLException ignore) {}
                      }
                  %>
              </div>
          <div class="commentWrite" align="center">
              <form method="post" action="saveComment.jsp" class="commentForm">
                  <%
                      if(session.getAttribute("id") != null) {
                          out.println("<table class=\"commentTable\" style=\"text-align: center;\" borer=\"1\">");
                          out.println("<tr><td align=\"left\">" + session.getAttribute("id") + "</td></tr>");
                          out.println("<tr><td><textarea id=\"commentWriteSec\" name=\"content\" style=\"border:none;\" placeholder=\"댓글 쓰기\"></textarea></td></tr>");
                          out.println("<tr><input type=\"hidden\" name=\"lostId\" value='" + lost_id + "'><input type=\"hidden\" name=\"userId\" value=" + userId +
                                  "><td><input type=\"submit\" id=\"commentWriteBtn\" value=\"등록\"></td></tr>");
                      }
                  %>
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
                            out.println("유효한 분실물 ID가 전달되지 않았습니다.");
                      }
                  %>
                    </table>
              </form>
          </div>
    </body>
</html>