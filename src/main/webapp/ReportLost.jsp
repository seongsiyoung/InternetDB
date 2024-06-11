<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">
<title>분실물 신고</title>
</head>
<body>
      <%@ include file="headLine.jsp" %>
      <br>
      <h2>&emsp;분실물 신고</h2>
      <hr></hr>
      <br>
      <div class="postSection" align="center">
      <form method="post" action="saveReportData.jsp" enctype="multipart/form-data" class="lostForm">
        <table>
                   <tr>
                   <td><div class="imgSec"><img id="lostImage" src="./Icon/upload.png" width="350px" height="300px" /></div></td>

                   <td><div class="lostInfoSec">
                       분실물명 : <input type="text" name="title"id="lostInfo"><br>
                       습득장소 : <input type="text" id="lostInfo" name="location"><br>
                       습득일 : <input type="date" id="lostInfo" name="time"><br>
                       보관장소 : <input type="text" name="currentloc" id="lostInfo"><br>
                       물품분류 : <select name="category" id="lostInfo">
                                <option value="none">===선택===</option>
                                <option value="accessory">악세사리</option>
                                <option value="electronics">전자제품</option>
                                <option value="wallet">지갑</option>
                                <option value="card">신용/체크카드</option>
                                <option value="others">기타</option></select><br>
                       분실상태 : <select name="status" id="lostInfo">
                                <option value="none">===선택===</option>
                                <option value="keep">보관중</option>
                                <option value="end">소유자 수령</option></select><br>
                       연락처 : <input type="tel" id="lostInfo" name="phone"></div></td>

                   </tr>
                   <tr>
                   <td><div align="center">&emsp;&emsp;<input type="file" name="lostImg"></div></td>
                   </tr>
                   <tr>
                   <td></td>
                   </tr>
                   <tr>
                   <td colspan="2"> <br> &emsp;내용 </td>
                   </tr>
                   <tr>
                   <td colspan="2"> <br><textarea rows="10" cols="105" name="content" placeholder=" 추가로 작성하고싶은 말이 있으시면 여기에 적어주세요."></textarea> </td>
                   </tr>
                   <tr>
                   <td colspan="2"><br><input id="UploadWriting" type="submit" value="글쓰기"></td>
                   </tr>
              </table>
        </form>
      </div>
      <br>

</body>
</html>