<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="com.InternetDB.UserBean" %>
<%@ page import="com.InternetDB.VO.BriefItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.InternetDB.page.PageResult" %>
<%@ page import="com.InternetDB.page.PageResult" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = (String) session.getAttribute("id");
    if(id == null){
        Alert.alertAndMove(response, "로그인이 필요한 서비스입니다.", "login.jsp");
    }

    UserBean user = new UserBean();
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
<link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">

    <style>

        body {
            background-color: #ffffff;
            font-family: "Open Sans", sans-serif;
        }
        .memberBox{
            display:flex;
            justify-content:center;
            min-width: 80rem;
        }

        .memberInfo{
            padding-bottom: 0.5rem;
            border-bottom: 1px solid black;
        }

        fieldset{
            width:55rem;
            height: 20rem;
            margin-top: 3rem;
            margin-bottom: 3rem;
            padding: 2rem;
            min-width: 40rem;
            font-size: 1.5rem;
            line-height: normal;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .modifyBtn{
            font-size: 1.3rem;
            width: 6rem;
            height: 2.5rem;
            margin-left: auto;
            background-color: #3aa9e0;
            border: none;
            border-radius: 5px;
            color: white;
        }

        .pageBox{
            display:flex;
            justify-content:center;
        }

        .myPost{
            min-width: 80rem;
        }
        .postTitle{
            font-size: 2rem;
        }
        .postBox{
            display: flex;
            justify-content: center;
            min-height: 20rem;
            padding: 2rem;
        }
        .post{
            height: 20rem;
            width: 20rem;
        }
        .postImageButton{
            border: none;
            background-color: white;
            width: 100%;
            height: 80%;
            min-height: 16rem;
            min-width: 20rem;
        }

        .postImage{
            width: inherit;
            height: inherit;
            object-fit: contain;
            min-height: 16rem;
            min-width: 20rem;
        }

        .postName{
            width: 100%;
            height: 20%;
            font-size: 1.5rem;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .page{
            text-align: center;
            width: 50%;
        }

        .pagination {
            list-style: none;
            display: inline-block;
            padding: 0;
            margin-top: 20px;
        }

        .pagination li {
            display: inline;
            text-align: center;
        }

        .pagination a {
               float: left;
               display: block;
               font-size: 14px;
               text-decoration: none;
               padding: 5px 12px;
               color: #96a0ad;
               line-height: 1.5;
        }

        .pagination a.active {
            cursor: default;
            color: #ffffff;
        }

        .pagination a:active {
            outline: none;
        }

        .modal .num {
            margin-left: 3px;
            padding: 0;
            width: 30px;
            height: 30px;
            line-height: 30px;
            -moz-border-radius: 100%;
            -webkit-border-radius: 100%;
            border-radius: 100%;
        }

        .modal .num:hover {
            background-color: #2e9cdf;
            color: #ffffff;
        }

        .modal .num.active, .modal .num:active {
            background-color: #2e9cdf;
            cursor: pointer;
        }

    </style>
<title>분실물 신고</title>
</head>
<body>
<%@ include file="connection.jsp" %>
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
        sql = "select lost_id, title, path from LOSTITEM where user_id = ? order by createdAt desc limit ?, ?";
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
            briefItem.setPath(rs.getString(3));
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
                        <input type="image" id="alarm" src="./Icon/alarm.png" alt="마이페이지" width="45" height="40">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div class="memberBox">
        <fieldset>
            <legend style="width: fit-content; font-size: 1.5rem; font-family: Open Sans, sans-serif;">사용자 정보</legend>
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
                    out.println("<div class=\"post\">");
                    out.println("<button type=\"button\" class=\"postImageButton\">\n");
                    out.println("<img src=\""+ item.getPath() +"\" alt=\"사진을 찾을 수 없습니다.\" onclick=\"location.href='temp/temploginsuccess.jsp'\" class=\"postImage\" >");
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