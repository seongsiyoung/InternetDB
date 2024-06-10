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
                       분실물명 : <input type="text" id="lostInfo"><br>
                       습득일 : <input type="date" id="lostInfo" name="FoundDate"><br>
                       보관장소 : <input type="text" id="lostInfo"><br>
                       물품분류 : <select name="category" id="lostInfo">
                                <option value="none">===선택===</option>
                                <option value="accessory">악세사리</option>
                                <option value="wallet">지갑</option>
                                <option value="card">신용/체크카드</option>
                                <option value="others">기타</option></select><br>
                       분실상태 : <select name="status" id="lostInfo">
                                <option value="none">===선택===</option>
                                <option value="keep">보관중</option>
                                <option value="end">소유자 수령</option></select><br>
                       연락처 : <input type="tel" id="lostInfo" name="phoneNumber"></div>
                       <div class="ModifyAndDelete">
                       <button id="mdBtn">수정</button><button id="mdBtn">삭제</button></td></div>

                   </tr>
                   <tr>
                   <td><div align="center">&emsp;&emsp;<input type="file"></div></td>
                   </tr>
                   <tr>
                   <td><div align="center"><button id="uploadBtn">Upload Photo</button></td></div>
                   </tr>
                   <tr>
                   <td colspan="2"> <br> &emsp;내용 </td>
                   </tr>
                   <tr>
                   <td colspan="2"> <br><textarea rows="10" cols="105" name="content" placeholder=" 추가로 작성하고싶은 말이 있으시면 여기에 적어주세요."></textarea> </td>
                   </tr>
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