<%@ page import="java.util.ArrayList" %>
<%@ page import="com.InternetDB.VO.BriefReply" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connection.jsp"%>
<%
    // 결과값 반환용 result 함수 초기화 및 sql 실행시 사용할 객체들 초기화
    String result="";
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    ArrayList<BriefReply> list = new ArrayList<>();

    try{
        // 현재 로그인된 사용자가 작성한 게시물에 달린 알림을 조회
        String sql = "SELECT li.type, li.lost_id, a.content AS alarm_content, a.status FROM lostitem li JOIN reply r ON li.lost_id = r.lost_id JOIN alarm a ON r.reply_id = a.reply_id WHERE li.user_id = ? ORDER BY a.createdat DESC";

        pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, (String) session.getAttribute("id"));
        rs = pstmt.executeQuery();

        // 결과 처리
        while (rs.next()) {
            BriefReply briefReply = new BriefReply();
            briefReply.setAlarmContent(rs.getString("alarm_content"));
            briefReply.setLostId(rs.getLong("lost_id"));
            briefReply.setLostIdType(rs.getString("type"));
            briefReply.setAlarmStatus(rs.getString("status"));
            list.add(briefReply);
        }

        // 알림 HTML 생성
        for (BriefReply item : list) {
            if (item.getLostIdType().equals("found") && item.getAlarmStatus().equals("unread")) {
                result += "<div class='custom-div'><a href='DetailReport.jsp?lost_id=" + item.getLostId() + "' class='custom-link'>" + item.getAlarmContent() + "</a></div><hr class='custom-hr'>";
            } else if (item.getLostIdType().equals("lost") && item.getAlarmStatus().equals("unread")) {
                result += "<div class='custom-div'><a href='DetailLost.jsp?lost_id=" + item.getLostId() + "' class='custom-link'>" + item.getAlarmContent() + "</a></div><hr class='custom-hr'>";
            }
        }

    } catch (SQLException e){
        e.printStackTrace();
    } finally {
        if (rs != null) {rs.close();}
        if (pstmt != null) {pstmt.close();}
    }

    // 응답 설정 및 결과 전송 (알림 HTML을 전송)
    response.setContentType("text/html");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(result);
%>