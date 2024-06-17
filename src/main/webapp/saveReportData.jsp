<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title>Save Report Data</title>
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
        String currentloc = multi.getParameter("currentloc");

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
            // 작성된 분실물 신고 게시글의 데이터들을 데이터베이스에 저장하기 위한 코드
            String sql = "INSERT INTO LOSTITEM (type, category, time, location, content, title, status, currentloc, image, path, user_id) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            String sql2 = "select lost_id from lostitem where image = ?";

            PreparedStatement pstmt = connection.prepareStatement(sql);
            PreparedStatement pstmt2 = null;
            ResultSet rs = null;

            pstmt.setString(1, "found");
            pstmt.setString(2, category);
            pstmt.setString(3, time);
            pstmt.setString(4, location);
            pstmt.setString(5, content);
            pstmt.setString(6, title);
            pstmt.setString(7, status);
            pstmt.setString(8, currentloc);
            pstmt.setString(9, newFileName);
            pstmt.setString(10, filePath);
            pstmt.setString(11, session.getAttribute("id").toString());

            int rows = pstmt.executeUpdate();

                    if(rows > 0) {
                        pstmt2 = connection.prepareStatement(sql2);
                        pstmt2.setString(1, newFileName);
                        rs = pstmt2.executeQuery();
                        // 데이터베이스에 저장이 완료되면
                        // 조회한 분실물 id를 파라미터로 하여 상세 페이지를 출력하기 위한 리다이렉션 코드
                        if (rs.next()) {
                            response.sendRedirect("DetailReport.jsp?lost_id=" + rs.getString("lost_id"));
                        }

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
</html>