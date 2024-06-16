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

    int currentPage = 1; //page번호로 기본값을 1로 설정
    int currentSize = 4; //한번에 가져올 데이터 양으로 기본값을 4로 설정
    List<BriefItem> items = new ArrayList<>();

    //query String 파라미터 가져오기
    String askedPage = request.getParameter("page");
    String askedSize = request.getParameter("size");

    //페이지 요청이 달라질 경우 해당 페이지로 설정
    if ( !(askedPage == null) && !askedPage.isEmpty())
        currentPage = Integer.parseInt(askedPage);

    //사이즈 요청이 달라질 경우 해당 페이지로 설정
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



        int offset = (currentPage-1) * currentSize;

        //분실물 목록 조회에 필요한 값을 최신 순으로 조회
        sql = "select lost_id, title, type, image, path from LOSTITEM where user_id = ? order by createdAt desc limit ?, ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, id);
        statement.setInt(2, offset);
        statement.setInt(3, currentSize);

        rs = statement.executeQuery();

        while (rs.next()){
            BriefItem briefItem = new BriefItem();
            briefItem.setLostId(rs.getLong(1));
            briefItem.setTitle(rs.getString(2));
            briefItem.setType(rs.getString(3));
            briefItem.setImage(rs.getString(4));
            briefItem.setPath(rs.getString(5));
            items.add(briefItem);
        }

        //페이지 객체를 생성하기 위해 필요한 total값(조건에 부합하는 게시물 전체의 개수)을 조회하기 위한 sql문
        sql = "select count(*) from LOSTITEM where user_id = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, id);
        rs = statement.executeQuery();
        rs.next();
        int total = rs.getInt(1);

        pageResult = new PageResult(currentPage, currentSize, total);

    } catch (SQLException e){
        e.printStackTrace();
        request.getRequestDispatcher("/servererror.jsp").forward(request, response);
    } finally {

        if(statement != null)
            statement.close();

        if(rs != null)
            rs.close();

        if(connection != null)
            connection.close();
    }
%>
    <div class="memberBox">
        <fieldset>
            <legend style="width: fit-content; font-size: 1.35rem; font-family: Open Sans, sans-serif;">사용자 정보</legend>
            <div class="memberInfo" style="margin-left: 2rem; margin-right: 2rem">아이디 : <%= user.getUserId()%> </div>
            <div class="memberInfo" style="margin-left: 2rem; margin-right: 2rem">이름 :  <%= user.getName()%></div>
            <div class="memberInfo" style="margin-left: 2rem; margin-right: 2rem">닉네임 :  <%= user.getNickname()%></div>
            <div class="memberInfo" style="margin-left: 2rem; margin-right: 2rem">연락처 :  <%= user.getPhone()%></div>
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
                    out.println("<div class=\"post\" style = \" margin: 0.5rem\"> ");
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
                            out.println("<li> <a href=\"mypage.jsp?page="+ i +"&size="+currentSize+"\" class=\"num\">"+ i +"</a></li>");}

                        if(pageResult.isNext())
                            out.println("<li> <a href=\"mypage.jsp?page=" + (pageResult.getEnd()+1) + "&size=" + currentSize+"\" class=\"arrow right\">>></a></li>\n");
                    %>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>