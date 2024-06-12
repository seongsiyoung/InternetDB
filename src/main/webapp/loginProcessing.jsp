<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="com.InternetDB.util.Encrytor" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>loginProcess</title>
</head>
<body>
<%@ include file="connection.jsp" %>

    <%
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        String sql = "SELECT salt FROM User where user_id = ?";
        PreparedStatement statement = null;
        PreparedStatement statement2 = null;
        ResultSet rs = null;

        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, id);

            rs = statement.executeQuery();

            if(rs.next())
                password = Encrytor.encryptPassword(password, rs.getString(1));

            String sql2 = "SELECT user_id, password, salt FROM User where user_id = ? and password = ?";
            statement2 = connection.prepareStatement(sql2);
            statement2.setString(1, id);
            statement2.setString(2, password);
            rs = statement2.executeQuery();

            if(!rs.next())
                Alert.alertAndMove(response, "회원 정보가 올바르지 않습니다.", "login.jsp");
            else {
                request.getSession().setAttribute("id", rs.getString(1));
                request.getSession().setAttribute("password", rs.getString(2));
                request.getSession().setAttribute("salt", rs.getString(3));


                response.sendRedirect("mypage.jsp");
            }

        } catch (SQLException e){
            e.printStackTrace();
            request.getRequestDispatcher("/temp/temperror.jsp").forward(request, response);
        } finally {

            if(statement != null)
                statement.close();
            if(rs != null)
                rs.close();
            if(connection != null)
                connection.close();
        }
    %>

</body>
</html>
