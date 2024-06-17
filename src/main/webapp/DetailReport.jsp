<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
<title>분실물 신고 상세</title>
</head>
<body>
      <%@ include file="headLine.jsp" %>
      <br>
      <h2>&emsp;분실물 신고 상세</h2>
      <hr></hr>
      <br>
      <div class="postSection" align="center">
                <%
                    // 분실물 id를 받아와 해당 id를 가진 분실물의 상세정보를 데이터베이스에서 조회해 출력하는 코드
                    String lostIdStr = request.getParameter("lost_id");
                    // 현재 로그인된 계정의 사용자 id
                    String userId =(String) session.getAttribute("id");

                    if (lostIdStr != null && !lostIdStr.isEmpty()) {
                        Long lost_id = Long.parseLong(lostIdStr);
                        // user 테이블과 lostitem 테이블을 조인해서 분실물 정보와 사용자의 연락처를 조회하는 sql문
                        String sql = "SELECT l.*, u.phone FROM lostitem l JOIN user u ON l.user_id = u.user_id WHERE l.lost_id = ?";
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        // 데이터베이스에 영문으로 저장된 데이터를 한글로 변환해 출력하는 용도
                        Map<String, String> categoryMap = new HashMap<>();
                        categoryMap.put("none","===선택===");
                        categoryMap.put("accessory","악세사리");
                        categoryMap.put("electronics","전자제품");
                        categoryMap.put("card","신용/체크카드");
                        categoryMap.put("others","기타");

                        Map<String, String> statusMap = new HashMap<>();
                        statusMap.put("keep", "보관중");
                        statusMap.put("end", "물품 주인 수령");

                        try {
                            pstmt = connection.prepareStatement(sql);
                            pstmt.setLong(1, lost_id);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
                                String imagePath = rs.getString("path") + rs.getString("image");
                                String title = rs.getString("title");
                                String currentloc = rs.getString("currentloc");
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
                        <td><div class="imgSec"><img id="lostImage" src="<%= imagePath %>" width="350px" height="300px" /></div></td>
                        // 조회한 데이터들을 화면에 출력
                        <td><div class="lostInfoSec">
                            분실물명 : <%= title %><br>
                            습득장소 : <%= location %><br>
                            습득일 : <%= time %><br>
                            보관장소 : <%= currentloc %><br>
                            물품분류 : <%= categoryInKorean %><br>
                            분실상태 : <%= statusInKorean %><br>
                            연락처 : <%= phone %></div></td>
                    </tr>
                    <tr>
                        <td colspan="2"><br> <p style="font-weight: bold; font-size:17px;"> &nbsp;내용 </p></td>
                    </tr>
                    <tr>
                        <td colspan="2"><br> <div class="contentSec"> <%= content %> </div></td>
                    </tr>
                    <%
                        // 게시글을 작성한 사용자의 id와 현재 로그인한 사용자의 id가 동일하면
                        // 수정 및 삭제 버튼이 보이도록 하는 코드
                        if(session.getAttribute("id") != null) {
                            if(session.getAttribute("id").equals(user_id)) {
                                out.println("<td colspan='2'><br><div class='ModifyAndDelete'><button id='mdBtn' onclick=\"location.href='modifyReport.jsp?lost_id=" + lost_id + "'\">수정</button><button id='mdBtn' onclick=\"location.href='deleteLostItem.jsp?lost_id=" + lost_id + "'\">삭제</button></div></td></tr>");
                            }
                        }
                    %>
                </table>

      </div>
      <br>
      <hr>
      // 댓글 처리란
      <div class="commentSec" align="center">
                <div class="commentBtnSec" align="center">
                <img id="commentIcon" src="./Icon/comment.png">
                <button id ="commentBtn">댓글 </button>
      </div>
        <br>
          <div class="savedCommentSec">
              <%
                  /*해당 게시글에 작성된 댓글이 있다면 조회해서 화면에 출력하기위한 코드*/
                  PreparedStatement pstmt2 = null; // pstmt 초기화
                  PreparedStatement pstmt3 = null;

                  ResultSet rs2 = null;
                  ResultSet rs3 = null;

                  try {
                      // reply 테이블에서 해당 게시글의 분실물 id를 사용해 저장된 댓글을 조회
                      String sql2 = "SELECT user_id, content, createdat FROM reply where lost_id = ?";
                      // 댓글을 작성한 사용자의 닉네임을 조회
                      String sql3 = "SELECT nickname from user where user_id = ?";

                      pstmt2 = connection.prepareStatement(sql2); // 쿼리 준비
                      pstmt2.setLong(1, lost_id);
                      rs2 = pstmt2.executeQuery(); // 쿼리 실행

                      while (rs2.next()) {
                          String user_id2 = rs2.getString("user_id");
                          String content2 = rs2.getString("content");
                          String createdat = rs2.getString("createdat");

                          pstmt3 = connection.prepareStatement(sql3);
                          pstmt3.setString(1, user_id2);
                          rs3 = pstmt3.executeQuery();

                          while (rs3.next()) {
                              // 조회된 댓글출력
                              out.println("<table class=\"savedCommentTable\">\n");
                              out.println("<tr><td align=\"left\">" + rs3.getString("nickname") + "</td></tr>");
                              out.println("<tr><td>" + content2 + " </td></tr>");
                              out.println("<tr><td align=\"left\"><div class='commentTime'>" + createdat + "</div></td></tr>");
                              out.println("</table>");
                              out.println("<br>");
                          }

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
                // 현재 로그인한 사용자의 id로 댓글을 작성할 수 있도록 댓글 작성란을 출력
                // 로그인 되지 않은 상태이면 댓글 작성란이 보이지 않도록 코딩
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