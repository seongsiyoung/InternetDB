<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="com.InternetDB.UserBean" %>
<%@ page import="com.InternetDB.VO.BriefItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.InternetDB.page.PageResult" %>
<%@ page import="com.InternetDB.page.PageResult" %>

<jsp:useBean id="user" class="com.InternetDB.UserBean" scope="page"/>


<%
    request.setCharacterEncoding("UTF-8");

    String id = (String) session.getAttribute("id");
    if(id == null){
        Alert.alertAndMove(response, "로그인이 필요한 서비스입니다.", "login.jsp");
    }

    int currentPage = 1; //page번호로 데이터를 처리할 때는 -1 기본값 설정 1
    int currentSize = 4; //한번에 가져올 데이터 양 기본값 설정 4
    List<BriefItem> items = new ArrayList<>();

    //query String 파라미터 가져오기
    String askedPage = request.getParameter("page");
    String askedSize = request.getParameter("size");

    if ( !(askedPage == null) && !askedPage.isEmpty())
        currentPage = Integer.parseInt(askedPage);

    if ( !(askedSize == null) && !askedSize.isEmpty())
        currentSize = Integer.parseInt(askedSize);
%>

<html>
<head>
    <meta charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
    <link type="text/css" rel="stylesheet" href="./css/mypage.css?after">
    <title>분실물 신고</title>
</head>
<body>
<%@ include file="connection.jsp" %>
<%@ include file="headLine.jsp" %>

<%

    String sql = "SELECT * from User where user_id = ?";
    PreparedStatement statement = null;
    PreparedStatement statement2 = null;
    PreparedStatement statement3 = null;
    ResultSet rs = null;
    PageResult pageResult = null;

    try {
        statement = connection.prepareStatement(sql);
        statement.setString(1, id);

        rs = statement.executeQuery();
        rs.next();

        user.setUserId(rs.getString(1));
        user.setPassword(rs.getString(2));
        user.setSalt(rs.getString(3));
        user.setName(rs.getString(4));
        user.setNickname(rs.getString(5));
        user.setPhone(rs.getString(6));
        user.setCreatedAt(rs.getString(7));

        /**
         * 여기 수정 게시물 조회시 찾은 거랑 잃어버린 거 둘 다 조회????????????
         */
        sql = "select lost_id, title, type, image, path from LOSTITEM where user_id = ? order by createdAt desc limit ?, ?";
        statement2 = connection.prepareStatement(sql);
        statement2.setString(1, id);
        int offset = (currentPage-1) * currentSize;
        statement2.setInt(2, offset);
        statement2.setInt(3, currentSize);

        rs = statement2.executeQuery();

        while (rs.next()){
            BriefItem briefItem = new BriefItem();
            briefItem.setLostId(rs.getLong(1));
            briefItem.setTitle(rs.getString(2));
            briefItem.setType(rs.getString(3));
            briefItem.setImage(rs.getString(4));
            briefItem.setPath(rs.getString(5));
            items.add(briefItem);
        }

        sql = "select count(*) from LOSTITEM where user_id = ?";
        statement3 = connection.prepareStatement(sql);
        statement3.setString(1, id);

        rs = statement3.executeQuery();
        rs.next();
        int total = rs.getInt(1);

        pageResult = new PageResult(currentPage, currentSize, total);

    } catch (SQLException e){
        e.printStackTrace();
        request.getRequestDispatcher("/temp/temperror.jsp").forward(request, response);
    } finally {

        if(statement != null)
            statement.close();
        if(statement2 != null)
            statement2.close();
        if(statement3 != null)
            statement3.close();
        if(rs != null)
            rs.close();
        if(connection != null)
            connection.close();
    }
%>
    <div class="memberBox">
        <fieldset>
            <legend style="width: fit-content; font-size: 1.35rem; font-family: Open Sans, sans-serif;">사용자 정보</legend>
            <div class="memberInfo">아이디 : <%= user.getUserId()%> </div>
            <div class="memberInfo">이름 :  <%= user.getName()%></div>
            <div class="memberInfo">닉네임 :  <%= user.getNickname()%></div>
            <div class="memberInfo">연락처 :  <%= user.getPhone()%></div>
            <button class="modifyBtn" type = "button" onclick= "location.href='modifyMember.jsp'">수정하기</button>
            </fieldset>
    </div>

    <div class="myPost">
        <div style=" display:flex; justify-content:center;">
            <div class="postTitle">작성한 게시물</div>
        </div>
        <div class="postBox">

            <%
                for (BriefItem item : items) {
                    String type = item.getType();
                    out.println("<div class=\"post\" style = \" margin: 0.5rem\">");
                    out.println("<button type=\"button\" class=\"postImageButton\">\n");
                    if(item.getType().equals("found"))
                        out.println("<img src=\""+ item.getPath()+item.getImage() +"\" alt=\"사진을 찾을 수 없습니다.\" onclick=\"location.href='modifyReport.jsp?lost_id=" + item.getLostId() + "'\" class=\"postImage\" >");
                    else
                        out.println("<img src=\""+ item.getPath()+item.getImage() +"\" alt=\"사진을 찾을 수 없습니다.\" onclick=\"location.href='modifyLost.jsp?lost_id=" + item.getLostId() + "'\" class=\"postImage\" >");
                    out.println("</button>\n");
                    out.println("<div class=\"postName\">"+item.getTitle()+"</div>\n");
                    out.println("</div>\n");
                }
            %>


        </div>
        <div class="pageBox">
            <div class="page">
                <ul class="pagination modal">
                    <%

                        if(pageResult.isPrev())
                            out.println("<li> <a href=\"mypage.jsp?page="+ (pageResult.getStart()-1)+"&size="+ currentSize+"\" class=\"arrow left\"><<</a></li>\n");
                        for(int i = pageResult.getStart(); i <= pageResult.getEnd(); i++){
                            if(i == currentPage){
                                out.println("<li> <a class=\"active num\">"+ i +"</a></li>");
                                continue;
                            }
                            out.println("<li> <a href=\"mypage.jsp?page="+ i +"&size="+currentSize+"\" class=\"num\">"+ i +"</a></li>");
                        }
                        if(pageResult.isNext())
                            out.println("<li> <a href=\"mypage.jsp?page=" + (pageResult.getEnd()+1) + "&size=" + currentSize+"\" class=\"arrow right\">>></a></li>\n");
                    %>
                </ul>
            </div>
        </div>
    </div>

</body>
</html>