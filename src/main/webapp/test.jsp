<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<body>
<h2>Hello World!</h2>
<%

    String jdbcURL = "jdbc:mysql://localhost:3306/internetDB";
    String username = "internetdb";
    String password = "internetdb";
    String test = null;
    String sql = "select now()";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcURL, username, password);
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet rs;

        rs = statement.executeQuery();

        while (rs.next()) {
            System.out.println(rs.getString(1));
            test = rs.getString(1);
        }

        rs.close();
        statement.close();
        connection.close();

    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
MODIFY 테스트
<%= test%>
</body>
</html>
