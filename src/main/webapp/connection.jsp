<%@ page import="java.sql.*" %>
<%
    Connection connection = null;

    String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
    String username = "internetdb";
    String userpassword = "internetdb";

    Class.forName("com.mysql.cj.jdbc.Driver");

    connection = DriverManager.getConnection(jdbcURL, username, userpassword);
%>

