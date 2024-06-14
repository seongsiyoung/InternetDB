<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.InternetDB.VO.BriefItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.InternetDB.page.PageResult" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="connection.jsp" %>
<jsp:useBean id="lostItem" class="com.InternetDB.LostItemBean" scope="page"/>

<%
  request.setCharacterEncoding("UTF-8");

  String search = request.getParameter("search");
  lostItem.setType(request.getParameter("type"));
  String requestedLocation = request.getParameter("requestedLocation");
  String requestedCategory = request.getParameter("requestedCategory");

  if(requestedCategory == null || requestedCategory.equals( "null") || requestedCategory.isEmpty())
    requestedCategory = null;

  String requestedTime = request.getParameter("requestedTime");

  if(requestedLocation == null || requestedLocation.equals("null"))
    requestedLocation = null;

  if(requestedTime == null || requestedTime.equals("null"))
    requestedTime = null;


  int currentPage = 1; //page번호로 데이터를 처리할 때는 -1 기본값 설정 1
  int currentSize = 9; //한번에 가져올 데이터 양 기본값 설정 15
  List<BriefItem> items = new ArrayList<>();

  String askedPage = request.getParameter("page");
  String askedSize = request.getParameter("size");

  //query String 파라미터 가져오기
  if ( !(askedPage == null) && !askedPage.isEmpty())
    currentPage = Integer.parseInt(askedPage);

  if ( !(askedSize == null) && !askedSize.isEmpty())
    currentSize = Integer.parseInt(askedSize);
%>

<html>
<head>
    <title>Title</title>
  <link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">
  <link type="text/css" rel="stylesheet" href="./css/mypage.css">

  <style>

    .detailSearchForm{
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .menu-bar {
      width: 100%;
    }

    .menu {
      width: 100%;
      display: flex;
      justify-content: space-evenly; /* 각 항목 간 동일한 간격 유지 */
      list-style-type: none;
      margin: 0;
      overflow: hidden;
      padding: 0;
    }

    .menu li {
      flex: 1 1 0px; /* 각 항목이 유효한 공간을 균등하게 차지하도록 함 */
      text-align: center; /* 항목의 텍스트를 중앙 정렬 */
      padding: 10px 20px; /* 패딩을 조정하여 내용에 여유 공간 제공 */
      margin: 0 5px; /* 양 옆 마진을 조금 주어 간격을 미세 조정 */
      box-sizing: border-box; /* 패딩과 보더가 width와 height에 포함되도록 설정 */
    }

    .menu-bar .menu form {
      width: 100%; /* form을 메뉴 항목과 같은 너비로 설정 */
      margin: 0; /* form의 마진 제거 */
    }

    .menu-link {
      display: block;
      width: 100%;
      padding: 10px 0;
      text-decoration: none;
      color: inherit;
      font-weight: bold;
      text-align: center;
      background: none;
      border: none;
      cursor: pointer;
    }

    .menu-link:hover, .menu-link:focus {
      background-color: #f0f0f0;
    }

    h3 {
      text-align: center;
    }
  </style>
</head>
<body>
<div align="center">
  <!--로고 검색창 마이페이지 알림-->
  <%@ include file="headLine.jsp" %>
  <br>
  <div class="menu-bar">
    <ul class="menu">
      <li><a href="information.jsp" class="menu-link">종합 안내</a></li>
      <li><a href="reportedLostItem.jsp" class="menu-link">신고된 분실물</a></li>
      <li><a href="registeredLostItem.jsp" class="menu-link">등록된 분실물</a></li>
    </ul>
  </div>

  <h3>검색된 분실물</h3>
  <hr>
  <div class = detailSearchBar>
    <form action="search.jsp" method="post" class="detailSearchForm">
      <select name="type" id="lang" style="display: inline-block; height: 30px; border: none; border-radius: 0px">
        <option value="found" selected>신고된</option>
        <option value="lost">등록된</option>
      </select>
      <input type="hidden" name="search" value= <%=search%> >
      <input type="text" name="requestedLocation" placeholder="장소 검색" style="height: 30px; margin-left: 10px">
      <select name="requestedCategory" style="display: inline-block; height: 30px; margin-left: 10px; border: none; border-radius: 0px">
        <option value=""> 카테고리 선택 </option>
        <option value="accessory"> 악세사리 </option>
        <option value="clothing"> 옷 </option>
        <option value="electronics"> 전자기기 </option>
        <option value="wallet"> 지갑 </option>
        <option value="card"> 카드 </option>
        <option value="others"> 기타 </option>
      </select>
      <input type="date" id="requestedTime" name="requestedTime" placeholder="시간 검색" style="height: 30px; margin-left: 10px;">
      <button type="submit" style="border: 0; background-color: transparent;">
        <input type="image" id="searchIcon" src="./Icon/search.png" alt="검색 버튼" width="30" height="30">
      </button>
    </form>
  </div>

  <!--분실물 표시-->
  <div class="lost-item-gallery">
    <%

      PreparedStatement pstmt = null;
      PreparedStatement pstmt2 = null;
      ResultSet rs = null;
      PageResult pageResult = null;

      try {

        StringBuilder stringBuilder = new StringBuilder();

        stringBuilder.append("SELECT lost_id, image, path, title, type FROM LostItem WHERE type = ? and title like ? ");

        if(!(requestedCategory == null) && !requestedCategory.isEmpty())
          stringBuilder.append("and category = ? ");

        if(!(requestedLocation == null) && !requestedLocation.isEmpty())
          stringBuilder.append("and location like ? ");

        if(!(requestedTime == null) && !requestedTime.isEmpty())
          stringBuilder.append("and date(time) < date(?) ");

        stringBuilder.append("ORDER BY createdat desc limit ?, ?");

        String sql = stringBuilder.toString();

        pstmt = connection.prepareStatement(sql);
        int offset = (currentPage-1) * currentSize;

        pstmt.setString(1, lostItem.getType());
        pstmt.setString(2, "%" + search + "%");

        int index = 3;

        if(!(requestedCategory == null) && !requestedCategory.isEmpty())
          pstmt.setString(index++, requestedCategory);

        if(!(requestedLocation == null) && !requestedLocation.isEmpty())
          pstmt.setString(index++, "%" + requestedLocation + "%");

        if(!(requestedTime == null) && !requestedTime.isEmpty())
          pstmt.setString(index++, requestedTime );

        pstmt.setInt(index++, offset);
        pstmt.setInt(index, currentSize);

        rs = pstmt.executeQuery();

        while (rs.next()){
          BriefItem briefItem = new BriefItem();
          briefItem.setLostId(rs.getLong(1));
          briefItem.setImage(rs.getString(2));
          briefItem.setPath(rs.getString(3));
          briefItem.setTitle(rs.getString(4));
          briefItem.setType(rs.getString(5));
          items.add(briefItem);
        }

        //page 처리

        stringBuilder.setLength(0);

        stringBuilder.append("SELECT count(*) FROM LostItem WHERE type = ? and title like ? ");

        if(!(requestedCategory == null) && !requestedCategory.isEmpty())
          stringBuilder.append("and category = ? ");

        if(!(requestedLocation == null) && !requestedLocation.isEmpty())
          stringBuilder.append("and location like ? ");

        if(!(requestedTime == null) && !requestedTime.isEmpty())
          stringBuilder.append("and date(time) < date(?) ");

        sql = stringBuilder.toString();

        pstmt2 = connection.prepareStatement(sql);

        pstmt2.setString(1, lostItem.getType());
        pstmt2.setString(2, "%" + search + "%");

        index = 3;

        if(!(requestedCategory == null) && !requestedCategory.isEmpty())
          pstmt2.setString(index++, requestedCategory);

        if(!(requestedLocation == null) && !requestedLocation.isEmpty())
          pstmt2.setString(index++, "%" + requestedLocation + "%");

        if(!(requestedTime == null) && !requestedTime.isEmpty())
          pstmt2.setString(index++, requestedTime );


        rs = pstmt2.executeQuery();
        rs.next();
        int total = rs.getInt(1);

        pageResult = new PageResult(currentPage, currentSize, total);
      } catch (SQLException e){
        e.printStackTrace();
        request.getRequestDispatcher("/temp/temperror.jsp").forward(request, response);
      } finally {

        if(pstmt != null)
          pstmt.close();
        if(pstmt2 != null)
          pstmt2.close();
        if(rs != null)
          rs.close();
        if(connection != null)
          connection.close();
      }
    %>
  </div>
  <form method="post" action="DetailReport.jsp" id="myForm">
    <div class="lost-item-gallery">

      <input type="hidden" name="lost_id" id="lostIdInput"> <!-- 숨겨진 필드로 lost_id 값을 전송 -->
      <%
        for (BriefItem item : items) {
          out.println("<div class='item' onclick='submitForm(" + item.getLostId() + ")'><img src='" + item.getPath() + item.getImage() + "' alt='Lost Item' width='200' height='150'><p>" + item.getTitle() + "</p></div>");
        }
      %>
    </div>
  </form>
  <script>
    function submitForm(lostId) {
      var form = document.getElementById('myForm');
      var lostIdInput = document.getElementById('lostIdInput');
      lostIdInput.value = lostId; // 클릭된 아이템의 lost_id 값을 hidden input에 설정
      form.submit(); // 폼 제출
    }
  </script>

  <div class="pageBox">
    <div class="page">
      <ul class="pagination modal">
        <%

          if(pageResult.isPrev())
            out.println("<li> <a href=\"search.jsp?page="+ (pageResult.getStart()-1)+"&size="+ currentSize+"\" class=\"arrow left\"><<</a></li>\n");
          for(int i = pageResult.getStart(); i <= pageResult.getEnd(); i++){
            if(i == currentPage){
              out.println("<li> <a class=\"active num\">"+ i +"</a></li>");
              continue;
            }
            out.println("<li> <a href=\"search.jsp?page="+ i +"&size="+currentSize+ "&type="+lostItem.getType() +"&search="+search +"&requestedCategory="+requestedCategory +"&requestedLocation="+requestedLocation +"&requestedTime="+requestedTime +"\" class=\"num\">"+ i +"</a></li>");
          }
          if(pageResult.isNext())
            out.println("<li> <a href=\"search.jsp?page=" + (pageResult.getEnd()+1) + "&size=" + currentSize+ "&type="+lostItem.getType() + "&search="+search +"&requestedCategory="+requestedCategory +"&requestedLocation="+requestedLocation +"&requestedTime="+requestedTime + "\" class=\"arrow right\">>></a></li>\n");
        %>
      </ul>
    </div>
  </div>
</div>
</body>
</html>
