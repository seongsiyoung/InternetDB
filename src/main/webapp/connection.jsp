<%@ page import="java.sql.*" %>

<%
    /**
     * 데이터 베이스를 연결시 중복되는 부분을 include하기 위해 작성한 jsp
     */
    Connection connection = null;

    String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
    String username = "internetdb";
    String userpasswd = "internetdb";

    Class.forName("com.mysql.cj.jdbc.Driver");

    connection = DriverManager.getConnection(jdbcURL, username, userpasswd);
%>

