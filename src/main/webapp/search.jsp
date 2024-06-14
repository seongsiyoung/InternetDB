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
  String requestedTime = request.getParameter("requestedTime");


  if(requestedCategory == null || requestedCategory.equals( "null") || requestedCategory.isEmpty())
    requestedCategory = null;

  if(requestedLocation == null || requestedLocation.equals("null"))
    requestedLocation = null;

  if(requestedTime == null || requestedTime.equals("null"))
    requestedTime = null;


  int currentPage = 1;
  int currentSize = 9;
  List<BriefItem> items = new ArrayList<>();

  //요청된 페이지가 있는 경우
  String askedPage = request.getParameter("page");
  String askedSize = request.getParameter("size");

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
  <link type="text/css" rel="stylesheet" href="./css/search.css">


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

        int index = 3;

        pstmt = connection.prepareStatement(sql);

        pstmt.setString(1, lostItem.getType());
        pstmt.setString(2, "%" + search + "%");
        if(!(requestedCategory == null) && !requestedCategory.isEmpty())
          pstmt.setString(index++, requestedCategory);
        if(!(requestedLocation == null) && !requestedLocation.isEmpty())
          pstmt.setString(index++, "%" + requestedLocation + "%");
        if(!(requestedTime == null) && !requestedTime.isEmpty())
          pstmt.setString(index++, requestedTime );

        int offset = (currentPage-1) * currentSize;

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

        pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, lostItem.getType());
        pstmt.setString(2, "%" + search + "%");
        index = 3;

        if(!(requestedCategory == null) && !requestedCategory.isEmpty())
          pstmt.setString(index++, requestedCategory);
        if(!(requestedLocation == null) && !requestedLocation.isEmpty())
          pstmt.setString(index++, "%" + requestedLocation + "%");
        if(!(requestedTime == null) && !requestedTime.isEmpty())
          pstmt.setString(index++, requestedTime );

        rs = pstmt.executeQuery();
        rs.next();

        int total = rs.getInt(1);

        pageResult = new PageResult(currentPage, currentSize, total);
      } catch (SQLException e){

        e.printStackTrace();
        request.getRequestDispatcher("/servererror.jsp").forward(request, response);
      } finally {

        if(rs != null)
          rs.close();

        if(pstmt != null)
          pstmt.close();

        if(connection != null)
          connection.close();
      }
    %>
  </div>

  <form method="post" action="DetailReport.jsp" id="myForm">
    <div class="lost-item-gallery">
      <input type="hidden" name="lost_id" id="lostIdInput">
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
      lostIdInput.value = lostId;
      form.submit();
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
