<%@ page import="java.util.ArrayList" %>
<%@ page import="com.InternetDB.VO.BriefReply" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connection.jsp"%>
<%
    String lostId = request.getParameter("lostId");
    String result="";
    PreparedStatement pstmt = null;
    ArrayList<BriefReply> list = new ArrayList<>();

    try{
        String sql = "UPDATE alarm a JOIN reply r ON a.reply_id = r.reply_id SET a.status = 'read' WHERE r.lost_id = ?";

        pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, lostId);
        int rs = pstmt.executeUpdate();
        result += "updated" + rs;

    } catch (SQLException e){
        e.printStackTrace();
    } finally {
        if (pstmt != null) {pstmt.close();}
    }

    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(result);
%>