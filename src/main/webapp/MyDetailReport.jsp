<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/mystyle.css">
<title>마이페이지-분실물신고상세</title>
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
      <form method="post" action="" enctype="multipart/form-data" class="lostForm">
        <table>
                   <tr>
                   <td><div class="imgSec"><img id="lostImage" src="./Icon/upload.png" width="350px" height="300px" /></div></td>

                   <td><div class="lostInfoSec">
                                              분실물명 : 애플워치<br>
                                              습득일 : 2024-06-07 <br>
                                              보관장소 : 학과사무실 <br>
                                              물품분류 : 전자제품 <br>
                                              분실상태 : 보관중 <br>
                                              연락처 : 010-1234-5858 </div></div>


                   </tr>
                   <tr>
                   <td></td>
                   </tr>
                   <tr>
                   <td></td></div>
                   </tr>
                   <tr>
                   <td colspan="2"> <br> &emsp;내용 </td>
                   </tr>
                   <tr>
                   <td colspan="2"> <br><div class ="contentSec"> 컴퓨터공학과 건물 2층 학과사무실에 맡겨뒀어요. </div> </td>
                   </tr>
                   <tr><td colspan="2">
                   <div class="ModifyAndDelete">
                                          <button id="mdBtn">수정</button><button id="mdBtn">삭제</button></td></div>
              </table>
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