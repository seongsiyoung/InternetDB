<%@ page import="com.InternetDB.page.PageResult" %>
<%@ page import="com.InternetDB.VO.BriefItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: ljm20
  Date: 2024-06-05
  Time: 오후 8:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connection.jsp" %>

<%
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
    <link type="text/css" rel="stylesheet" href="./css/itemGallery.css?after">
    <link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
    <link type="text/css" rel="stylesheet" href="./css/mypage.css?after">
    <title>등록된 분실물</title>
</head>
<body>
<%-- 등록된 분실물을 불러오고, 페이지네이션을 하기 위한 스크립틀릿 --%>
<%
    String sql = "SELECT path, title, lost_id, type, image FROM LostItem WHERE type = 'lost' ORDER BY createdat desc limit ?, ?";
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    PageResult pageResult = null;

    try {
        // 페이지네이션에 필요한 변수 정의
        pstmt = connection.prepareStatement(sql);
        int offset = (currentPage-1) * currentSize;
        pstmt.setInt(1, offset);
        pstmt.setInt(2, currentSize);

        rs = pstmt.executeQuery();

        // 결과 처리
        while (rs.next()){
            BriefItem briefItem = new BriefItem();
            briefItem.setTitle(rs.getString("title"));
            briefItem.setPath(rs.getString("path"));
            briefItem.setLostId(rs.getLong("lost_id"));
            briefItem.setImage(rs.getString("image"));
            briefItem.setPath(rs.getString("path")+briefItem.getImage());
            items.add(briefItem);
        }
        // 불러올 등록된 분실물의 총량
        sql = "select count(*) from LostItem where type = 'lost'";
        pstmt2 = connection.prepareStatement(sql);

        rs = pstmt2.executeQuery();
        rs.next();
        int total = rs.getInt(1);

        // 나중에 페이지네이션에 필요한 객체
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
    <br>
    <div class="gallery-title">
        <h3>등록된 분실물</h3>
        <button type="button" onclick="location.href='UploadLost.jsp'" style="border: none; background-color: #FFF;">
        <input type="image" id="UploadLost" src="./Icon/UploadLost.png" alt="분실물 등록" width="130" height="28">
        </button>
    </div>

    <hr>
    <br>
    <br>
    <div class="lost-item-gallery">
        <%
            for (BriefItem item : items) {
                out.println("<div class='item'><a href='DetailLost.jsp?lost_id="+ item.getLostId() +"'><img src='" + item.getPath() + "' alt='Lost Item' width='200' height='150'></a><p>" + item.getTitle() + "</p></div>");
            }
        %>
    </div>
    <%--  페이지네이션  --%>
    <div class="pageBox">
        <div class="page">
            <ul class="pagination modal">
                <%

                    if(pageResult.isPrev())
                        out.println("<li> <a href=\"registeredLostItem.jsp?page="+ (pageResult.getStart()-1)+"&size="+ currentSize+"\" class=\"arrow left\"><<</a></li>\n");
                    for(int i = pageResult.getStart(); i <= pageResult.getEnd(); i++){
                        if(i == currentPage){
                            out.println("<li> <a class=\"active num\">"+ i +"</a></li>");
                            continue;
                        }
                        out.println("<li> <a href=\"registeredLostItem.jsp?page="+ i +"&size="+currentSize+"\" class=\"num\">"+ i +"</a></li>");
                    }
                    if(pageResult.isNext())
                        out.println("<li> <a href=\"registeredLostItem.jsp?page=" + (pageResult.getEnd()+1) + "&size=" + currentSize+"\" class=\"arrow right\">>></a></li>\n");
                %>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
