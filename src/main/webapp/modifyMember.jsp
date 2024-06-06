<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="com.InternetDB.UserBean" %>



<%

    String id = (String) session.getAttribute("id");
    if(id == null){
        Alert.alertAndMove(response, "로그인이 필요한 서비스입니다.", "login.jsp");
    }

    UserBean user = new UserBean();

%>

<html>
<head>
    <style>
        html {
            box-sizing: border-box;
            font-size:  100%;
        }

        body {
            background-color: #ffffff;
            color: #4b4b4b;
            font-family: "Open Sans", sans-serif;
            font-size: 0.875rem;

        }
        .parent{
            display: flex;
            justify-content: center;
            align-items: center;
        }

        form{
            width: 50rem;
            align-content: center;
            text-align: center;
        }

        .signup{
            width: 100%;
            border-collapse: separate;
            border-spacing: 1rem;
        }
        div{
            margin: 1rem;
        }


        /* 각 input과 select 요소의 스타일 */
        input[type="text"],
        input[type="password"],
        input[type="tel"]
        {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
            height: 3.5rem;
        }


        button{
            width: 100%;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            padding: 10px;
            appearance: none;
            text-align: center;
            height: 3.5rem;
        }


        /* 가입하기 버튼의 스타일 */
        input[type="submit"], button {
            width: 30%;
            height: 3rem;
            padding: 10px;
            background-color: #4cbdea;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 3rem;
        }

        /* 가입하기 버튼 클릭 시의 스타일 */
        input[type="submit"]:hover {
            background-color: #3aa9e0;
        }

        /* 제목의 스타일 */
        h2 {
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 2.7rem;
            color: #333;
            text-align: center;
        }

        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
        }

    </style>
    <link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">

    <title>분실물 신고</title>
</head>
<body>
<%@ include file="connection.jsp" %>
<%

    String sql = "SELECT * from User where user_id = ?";
    PreparedStatement statement = null;
    ResultSet rs = null;

    try {
        statement = connection.prepareStatement(sql);
        statement.setString(1, id);

        rs = statement.executeQuery();
        rs.next();

        user.setUserId(rs.getString(1));
        user.setPassword(rs.getString(2));
        user.setSalt(rs.getString(3));
        user.setName(rs.getString(4));
        user.setNickname(rs.getString(5));
        user.setPhone(rs.getString(6));
        user.setCreatedAt(rs.getString(7));

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
<body class = "parent">
<form action="temp/temploginsuccess.jsp" method="post">
    <div class="signup">
        <div>
            <h2>회원 정보 수정</h2>
        </div>
        <div>
            <input type="password" placeholder="기존 비밀번호" name="password">
        </div>
        <div>
            <input type="password" placeholder="새로운 비밀번호" name="password">
        </div>
        <div>
            <input type="text" value= <%=user.getNickname()%> class="nickname" name="nickname">
        </div>
        <div>
            <span id= "checknickname"> </span>
        </div>
        <div>
            <input type="text" value= <%= user.getName()%> name="name">
        </div>
        <div>
            <input type="tel" value= <%=user.getPhone()%> name="phone">
        </div>
        <span class="buttons">
            <input type="submit" value="수정하기">
            <button>회원 탈퇴</button>
        </span>
    </div>


</form>
</body>
</html>