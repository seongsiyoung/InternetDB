<%@ page import="java.util.ArrayList" %>
<%@ page import="com.InternetDB.VO.BriefReply" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connection.jsp"%>
<%
    String result="";
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ArrayList<BriefReply> list = new ArrayList<>();

    try{
        String sql = "SELECT li.type, li.lost_id, a.content AS alarm_content, a.status FROM lostitem li JOIN reply r ON li.lost_id = r.lost_id JOIN alarm a ON r.reply_id = a.reply_id WHERE li.user_id = ? ORDER BY a.createdat DESC";

        pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, (String) session.getAttribute("id"));
        rs = pstmt.executeQuery();
        while (rs.next()) {
            BriefReply briefReply = new BriefReply();
            briefReply.setAlarmContent(rs.getString("alarm_content"));
            briefReply.setLostId(rs.getLong("lost_id"));
            briefReply.setLostIdType(rs.getString("type"));
            briefReply.setAlaramStatus(rs.getString("status"));
            list.add(briefReply);
        }

        for(BriefReply item : list){
            if(item.getLostIdType().equals("found") && item.getAlarmStatus().equals("unread")){
                result += "<div><a href='DetailReport.jsp?lost_id="+ item.getLostId()+"'>" + item.getAlarmContent()+"</a></div><hr>";
            } else if(item.getLostIdType().equals("lost") && item.getAlarmStatus().equals("unread")){
                result += "<div><a href='DetailLost.jsp?lost_id="+ item.getLostId()+"'>" + item.getAlarmContent()+"</a></div><hr>";
            }
        }

    } catch (SQLException e){
        e.printStackTrace();
    } finally {
        if (rs != null) {rs.close();}
        if (pstmt != null) {pstmt.close();}
    }

    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(result);
%>