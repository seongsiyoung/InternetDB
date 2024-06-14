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
    <link type="text/css" rel="stylesheet" href="./css/itemGallery.css">
    <link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
    <link type="text/css" rel="stylesheet" href="./css/mypage.css">
    <style>
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

    </style>
    <title>등록된 분실물</title>
</head>
<body>
<%
    String sql = "SELECT path, title, lost_id, type, image FROM LostItem WHERE type = 'lost' ORDER BY createdat desc limit ?, ?";
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    PageResult pageResult = null;

    try {
        pstmt = connection.prepareStatement(sql);
        int offset = (currentPage-1) * currentSize;
        pstmt.setInt(1, offset);
        pstmt.setInt(2, currentSize);

        rs = pstmt.executeQuery();

        while (rs.next()){
            BriefItem briefItem = new BriefItem();
            briefItem.setTitle(rs.getString("title"));
            briefItem.setPath(rs.getString("path"));
            briefItem.setLostId(rs.getLong("lost_id"));
            briefItem.setImage(rs.getString("image"));
            briefItem.setPath(rs.getString("path")+briefItem.getImage());
            items.add(briefItem);
        }

        sql = "select count(*) from LostItem where type = 'lost'";
        pstmt2 = connection.prepareStatement(sql);

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
    <div class="gallery-title">
        <h3>등록된 분실물</h3>
        <button class="register-button" onclick="location.href='UploadLost.jsp'">분실물 등록하기</button>
    </div>

    <hr>
    <div class="lost-item-gallery">
        <%
            for (BriefItem item : items) {
                out.println("<div class='item'><a href='DetailLost.jsp?lost_id="+ item.getLostId() +"'><img src='" + item.getPath() + "' alt='Lost Item' width='200' height='150'></a><p>" + item.getTitle() + "</p></div>");
            }
        %>
    </div>
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
