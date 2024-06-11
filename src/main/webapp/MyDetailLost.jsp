<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/mystyle.css">
<title>마이페이지-분실물등록상세</title>
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
      <h2>&emsp;분실물 등록 상세</h2>
      <hr></hr>
      <br>
      <div class="postSection" align="center">
      <form method="post" action="" enctype="multipart/form-data" class="lostForm">
        <table>
                   <tr>
                   <td><div class="imgSec"><img id="lostImage" src="./Icon/upload.png" width="350px" height="300px" /></div></td>

                   <td>
                       <div class="lostInfoSec">분실물명 : 지갑<br>
                                              분실일 : 2024-06-08 <br>
                                              분실예상장소 : 강의실 <br>
                                              물품분류 : 지갑 <br>
                                              분실상태 : 분실 <br>
                                              연락처 : 010-1234-5678 </div>
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
                   <td colspan="2"> <br><div class ="contentSec"> 보신 분은 연락처로 문자 주세요. </div> </td>
                   </tr>
                    <tr>
                           <td colspan="2"><br><div class="ModifyAndDelete">
                           <button id="mdBtn">수정</button> <button id="mdBtn">삭제</button></div></td></tr>
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