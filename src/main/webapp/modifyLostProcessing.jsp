<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Modify Lost Data</title>
</head>
<body>
<%@ include file="connection.jsp" %>

<%
    String saveFolder=application.getRealPath("lostPhoto");
    String encType="utf-8";
    int maxSize=5*1024*1024;


    PreparedStatement pstmt = null;

    ServletContext context = this.getServletContext();

    try {

            MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());

            String lost_id = multi.getParameter("lost_id");
            String title = multi.getParameter("title");
            String status = multi.getParameter("status");
            String category = multi.getParameter("category");
            String time = multi.getParameter("time");
            String location = multi.getParameter("location");
            String content = multi.getParameter("content");

            // 파일 이름 추출 및 uuid 변환
            String originalFileName = multi.getFilesystemName("lostImg");
            if (originalFileName != null) { //이미지 파일이 수정 되었을 경우
                String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

                String uuid = UUID.randomUUID().toString();

                String newFileName = uuid + fileExtension;

                File oldFile = new File(saveFolder + "/" + originalFileName);
                File newFile = new File(saveFolder + "/" + newFileName);

                oldFile.renameTo(newFile);

                String sql = "update lostitem set category = ?, time = ?, location =?, content = ?, title = ?, status = ?, image = ? where lost_id = ?";

                pstmt = connection.prepareStatement(sql);

                pstmt.setString(1, category);
                pstmt.setString(2, time);
                pstmt.setString(3, location);
                pstmt.setString(4, content);
                pstmt.setString(5, title);
                pstmt.setString(6, status);
                pstmt.setString(7, newFileName);
                pstmt.setLong(8, Long.parseLong(lost_id));

                int rows = pstmt.executeUpdate();

                if (rows > 0) {

                    response.sendRedirect("DetailLost.jsp?lost_id=" + lost_id);

                    out.println("Data has been inserted successfully");
                } else {
                    out.println("No data was inserted.");
                }
            } else { //이미지 파일은 수정하지 않았을 경우
                String sql = "update lostitem set category = ?, time = ?, location =?, content = ?, title = ?, status = ? where lost_id = ?";

                pstmt = connection.prepareStatement(sql);

                pstmt.setString(1, category);
                pstmt.setString(2, time);
                pstmt.setString(3, location);
                pstmt.setString(4, content);
                pstmt.setString(5, title);
                pstmt.setString(6, status);
                pstmt.setLong(7, Long.parseLong(lost_id));

                int rows = pstmt.executeUpdate();

                if (rows > 0) {

                    response.sendRedirect("DetailLost.jsp?lost_id=" + lost_id);

                    out.println("Data has been inserted successfully");
                } else {
                    out.println("No data was inserted.");
                }
            }



    }catch(Exception e) {
        e.printStackTrace();

        out.println("Error: " + e.getMessage());
    } finally {
        if (pstmt != null)
            pstmt.close();
        if (connection != null)
            connection.close();
    }
%>

</body>
</html>