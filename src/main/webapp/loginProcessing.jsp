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

        String sql = "SELECT user_id, password FROM User where user_id = ? and password = ?";
        PreparedStatement statement = null;
        ResultSet rs = null;

        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, id);
            statement.setString(2, password);

            rs = statement.executeQuery();

            if(!rs.next())
                response.sendRedirect("/temp/temploginfail.jsp");
            else {
                request.getSession().setAttribute("id", rs.getString(1));
                request.getSession().setAttribute("password", rs.getString(2));

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
