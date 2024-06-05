<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                response.sendRedirect("temploginfail.jsp");
            else {
                request.getSession().setAttribute("id", id);

                response.sendRedirect("temploginsuccess.jsp");
            }

        } catch (SQLException e){
            e.printStackTrace();
            request.getRequestDispatcher("temperror.jsp").forward(request, response);
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
