<%@ page import="com.InternetDB.util.Alert" %>
<%@ page import="com.InternetDB.util.Encrytor" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String sessionPassword = (String) session.getAttribute("password");
    String password = request.getParameter("oldPassword");

%>

<jsp:useBean id="user" class="com.InternetDB.UserBean" scope="page"/>
<jsp:setProperty name="user" property="*"/>

<%!
    //사용자가 입력한 값을 검증하는 메소드
    boolean validatePassword(String password){
        return password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{4,14}$");
    }

    boolean validateNickname(String nickname){
        return nickname.matches("^(?=.*[a-zA-Z가-힣])[a-zA-Z가-힣\\d]{4,14}$");
    }

    boolean validateName(String name){
        return  name.matches("^[가-힣]{2,5}$");
    }

    boolean validatePhone(String phone){
        return phone.matches("^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$");
    }

%>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%@ include file="connection.jsp" %>

<%
    //사용자 입력값의 형식을 검사하는 메소드를 활용해 올바른 값을 입력했는지 검사하고 문제가 없다면 회원 정보 수정
    //새로운 비밀번호는 필수 입력사항이 아니므로 null인지 추가로 체크한 다음 형식 검사
    if (user.getPassword() != null && !user.getPassword().isEmpty() && !validatePassword(user.getPassword())) {
        Alert.alertAndBack(response, "비밀번호 형식 올바르지 않습니다.");

    } else if (!validateNickname(user.getNickname())) {
        Alert.alertAndBack(response, "닉네임 형식 올바르지 않습니다.");

    } else if (!validateName(user.getName())) {
        Alert.alertAndBack(response, "이름의 형식 올바르지 않습니다.");

    } else if (!validatePhone(user.getPhone())) {
        Alert.alertAndBack(response, "핸드폰 형식 올바르지 않습니다.");

    } else {

        PreparedStatement statement = null;
        ResultSet rs = null;
        String salt = null;




        try {

            //올바른 비밀번호를 입력했는지 검사
            String sql = "SELECT salt FROM User WHERE user_id = ?";

            statement = connection.prepareStatement(sql);

            statement.setString(1, user.getUserId());

            rs = statement.executeQuery();

            if(rs.next()){
                salt = rs.getString(1);
                password = Encrytor.encryptPassword(password, salt);

                if ( !password.equals(sessionPassword)) {
                    Alert.alertAndBack(response, "비밀번호가 달라 수정할 수 없습니다.");
                    return;
                }
            }

            //닉네임의 중복 검사
            sql = "SELECT user_id FROM User WHERE nickname = ?";

            statement = connection.prepareStatement(sql);

            statement.setString(1, user.getNickname());

            rs = statement.executeQuery();

            if(rs.next()){
                String test = rs.getString(1);
                if ( !test.equals((String) session.getAttribute("id")))
                    Alert.alertAndBack(response, "닉네임이 중복되어 수정할 수 없습니다.");
            }

            sql = "UPDATE  User SET password = ?, name = ?, nickname = ?, phone = ? WHERE user_id = ?";


            statement = connection.prepareStatement(sql);
            statement.setString(1, Encrytor.encryptPassword(user.getPassword(),salt));
            statement.setString(2, user.getName());
            statement.setString(3, user.getNickname());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getUserId());


            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/temp/temperror.jsp").forward(request, response);
        } finally {

            if (rs != null)
                rs.close();
            if (statement != null)
                statement.close();
            if (connection != null)
                connection.close();
        }

        //세션의 비밀번호 갱신
        session.setAttribute("password", Encrytor.encryptPassword( user.getPassword(),salt));
        Alert.alertAndMove(response, "회원 정보 수정이 완료되었습니다.", "mypage.jsp");
    }

%>

</body>
</html>
