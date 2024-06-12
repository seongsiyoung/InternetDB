<%@ page import="com.InternetDB.util.Alert" %>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="com.InternetDB.LostItemBean" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = (String) session.getAttribute("id");
    if(id == null){
        Alert.alertAndMove(response, "로그인이 필요한 서비스입니다.", "login.jsp");
    }

    LostItemBean lostItem = new LostItemBean();
%>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="./css/mystyle.css">
    <title>분실물 신고 수정</title>
</head>
<body>
<%@ include file="connection.jsp" %>
<%
    String lostIdStr = request.getParameter("lost_id");

    if (lostIdStr != null && !lostIdStr.isEmpty()) {
        Long lost_id = Long.parseLong(lostIdStr);
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT l.*, u.phone FROM lostitem l JOIN user u ON l.user_id = u.user_id WHERE l.lost_id = ?";

        try {
            pstmt = connection.prepareStatement(sql);
            pstmt.setLong(1, lost_id);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                lostItem.setLostId(rs.getLong("lost_id"));
                lostItem.setType(rs.getString("type"));
                lostItem.setCategory(rs.getString("category"));
                lostItem.setTime(rs.getString("time"));
                lostItem.setLocation(rs.getString("location"));
                lostItem.setCurrentLoc(rs.getString("currentloc"));
                lostItem.setContent(rs.getString("content"));
                lostItem.setTitle(rs.getString("title"));
                lostItem.setStatus(rs.getString("status"));
                lostItem.setImage(rs.getString("image"));
                lostItem.setPath(rs.getString("path"));
                lostItem.setUserId(rs.getString("user_id"));
                String phone = rs.getString("phone");

%>
<%@ include file="headLine.jsp" %>
<br>
<h2>&emsp;분실물 신고 수정</h2>
<hr></hr>
<br>
<div class="postSection" align="center">
    <form method="post" action="modifyReportProcessing.jsp" enctype="multipart/form-data" class="lostForm">
        <table>
            <tr>
                <td><div class="imgSec"><img id="lostImage" src= <%= lostItem.getPath() + lostItem.getImage() %> width="350px" height="300px" /></div></td>

                <td><div class="lostInfoSec">
                    분실물명 : <input type="text" value = <%=lostItem.getTitle()%> name="title"id="lostInfo"><br>
                    습득장소 : <input type="text" value = <%=lostItem.getLocation()%>  id="lostInfo" name="location"><br>
                    습득일 : <input type="date" value = <%=lostItem.getTime()%> id="lostInfo" name="time"><br>
                    보관장소 : <input type="text" name="currentloc" value = <%=lostItem.getCurrentLoc()%> id="lostInfo"><br>
                    물품분류 : <select name="category" id="lostInfo">
                    <option value="none" <%= "none".equals(lostItem.getCategory()) ? "selected" : "" %>>===선택===</option>
                    <option value="accessory" <%= "accessory".equals(lostItem.getCategory()) ? "selected" : "" %>>악세사리</option>
                    <option value="electronics" <%= "electronics".equals(lostItem.getCategory()) ? "selected" : "" %>>전자제품</option>
                    <option value="wallet" <%= "wallet".equals(lostItem.getCategory()) ? "selected" : "" %>>지갑</option>
                    <option value="card"  <%= "card".equals(lostItem.getCategory()) ? "selected" : "" %>>신용/체크카드</option>
                    <option value="others" <%= "others".equals(lostItem.getCategory()) ? "selected" : "" %>>기타</option></select><br>
                    분실상태 : <select name="status" id="lostInfo">
                    <option value="none" <%= "none".equals(lostItem.getStatus()) ? "selected" : "" %>>===선택===</option>
                    <option value="keep" <%= "keep".equals(lostItem.getStatus()) ? "selected" : "" %>>보관중</option>
                    <option value="end" <%= "end".equals(lostItem.getStatus()) ? "selected" : "" %>>소유자 수령</option></select><br>
                    연락처 : <input type="tel" id="lostInfo" value="<%=phone%>" name="phone"></div></td>

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
                <td colspan="2"> <br><textarea rows="10" cols="105" name="content" placeholder=" 추가로 작성하고싶은 말이 있으시면 여기에 적어주세요."><%=lostItem.getContent()%></textarea> </td>
            </tr>
            <tr>
                <td colspan="2"><br><input id="UploadWriting" type="submit" value="글쓰기"></td>
            </tr>
            <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (pstmt != null)
                            pstmt.close();
                        if (rs != null)
                            rs.close();
                        if (connection != null)
                            connection.close();
                    }
                }
            %>
        </table>
    </form>

</div>
<br>

</body>
</html>