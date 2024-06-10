<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="connection.jsp" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/mystyle.css">
<title>분실물 신고 상세</title>
</head>
<body>
      <div align="center">
      <table>
           <tr>
           <td><img src="./Icon/pagelogo.png" width="260" height="70"></td>
           <td>&emsp;&emsp;&emsp;</td>
           <td>
           <div class="search">
                <input type="text" id="searchbar" name="selectLost" placeholder="분실물 검색">
                <input type="image" id="searchIcon" src="./Icon/search.png" alt="검색 버튼" width="30" height="30">
           </div>
           </td>
           <td>&emsp;&emsp;&emsp;&emsp;</td>
           <td>
              <div class="my">
                <input type="image" id="mypageIcon" src="./Icon/mypage.png" alt="마이페이지" width="40" height="40">&nbsp;
                <input type="image" id="alarm" src="./Icon/alarm.png" alt="알림" width="45" height="40">
                <input type="image" id="logout" src="./Icon/logout.png" alt="로그아웃" width="45" height="40">
              </div>
           </td>
           </tr>
      </table>
      </div>
      <br>
      <h2>&emsp;분실물 신고 상세</h2>
      <hr></hr>
      <br>
      <div class="postSection" align="center">
        <%
            String image = request.getParameter("image");
            if (image != null && !image.isEmpty()) {
                String sql = "select * from lostitem where image = ?";
                PreparedStatement pstmt = connection.prepareStatement(sql);
                pstmt.setString(1, image);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    String imagePath = rs.getString("path") + image;
                    String title = rs.getString("title");
                    String currentloc = rs.getString("currentloc");
                    String location = rs.getString("location");
                    String time = rs.getString("time");
                    String category = rs.getString("category");
                    String status = rs.getString("status");
                    String content = rs.getString("content");
            %>
        <table>
                   <tr>
                   <td><div class="imgSec"><img id="lostImage" src="<%= imagePath%>" width="350px" height="300px" /></div></td>

                   <td><div class="lostInfoSec">
                       분실물명 : <%= title %><br>
                       습득장소 :  <%= location %> <br>
                       습득일 : <%= time %> <br>
                       보관장소 : <%= currentloc %> <br>
                       물품분류 : <%= category %> <br>
                       분실상태 : <%= status %> <br>
                       연락처 :  </div></td>

                   </tr>
                   <tr>

                   </tr>
                   <tr>

                   </tr>
                   <tr>
                   <td colspan="2"> <br> &emsp;내용 </td>
                   </tr>
                   <tr>
                   <td colspan="2"> <br> <div class ="contentSec"> <%= content %> </div> </td>
                   </tr>
              </table>
              <%
                  } else {

                  out.println("해당 분실물 정보를 찾을 수 없습니다.");
                  }
                  rs.close();
                  pstmt.close();
                  connection.close();
                  } else {
                  out.println("유효한 이미지 uuid가 전달되지 않았습니다.");
                  }
              %>
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
                    <td><textarea id="commentWriteSec" style="border:none;"
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