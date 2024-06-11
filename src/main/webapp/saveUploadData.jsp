<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>Save Upload Data</title>
</head>
<body>
    <%@ include file="connection.jsp" %>

    <%
        String saveFolder=application.getRealPath("lostPhoto");
        String encType="utf-8";
        int maxSize=5*1024*1024;

        ServletContext context = this.getServletContext();

        try {
        MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());

        String title = multi.getParameter("title");
        String status = multi.getParameter("status");
        String category = multi.getParameter("category");
        String time = multi.getParameter("time");
        String location = multi.getParameter("location");
        String content = multi.getParameter("content");

        // 파일 이름 추출 및 uuid 변환
        String originalFileName = multi.getFilesystemName("lostImg");
        if(originalFileName != null) {
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

            String uuid = UUID.randomUUID().toString();

            String newFileName = uuid + fileExtension;

            File oldFile = new File(saveFolder + "/" + originalFileName);
            File newFile = new File(saveFolder + "/" + newFileName);

            oldFile.renameTo(newFile);

            String filePath = "./lostPhoto/";

         String sql = "INSERT INTO LOSTITEM (type, category, time, location, content, title, status, image, path, user_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = connection.prepareStatement(sql);

        pstmt.setString(1, "lost");
        pstmt.setString(2, category);
        pstmt.setString(3, time);
        pstmt.setString(4, location);
        pstmt.setString(5, content);
        pstmt.setString(6, title);
        pstmt.setString(7, status);
        pstmt.setString(8, newFileName);
        pstmt.setString(9, filePath);
        pstmt.setString(10, session.getAttribute("id").toString());

        int rows = pstmt.executeUpdate();
        if(rows > 0) {
                    response.sendRedirect("DetailLost.jsp");
                    out.println("Data has been inserted successfully");
                } else {
                    out.println("No data was inserted.");
                }
                pstmt.close();
                connection.close();
        } else {
            out.println("File upload failed.");
        }

        } catch(Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
        }
    %>
</body>