<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            height: inherit;
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
<form action="modifyMemberProcessing.jsp" method="post" accept-charset="utf-8">
    <div class="signup">
        <div>
            <h2>회원 정보 수정</h2>
        </div>
        <div>
            <input type="password" placeholder="기존 비밀번호" name="oldPassword" class="oldPassword"  required>
        </div>
        <div>
            <div id= "checkPassword"> </div>
        </div>
        <div>
            <input type="password" placeholder="새로운 비밀번호" name="password" class="password">
        </div>
        <div>
            <div id= "newPassword"> </div>
        </div>
        <div>
            <input type="text" value= <%=user.getNickname()%> class="nickname" name="nickname"  required>
        </div>
        <div>
            <div id= "checknickname"> </div>
        </div>
        <div>
            <input type="text" value= <%= user.getName()%> class="name" name="name"  required>
        </div>
        <div>
            <div id= "checkname"> </div>
        </div>
        <div>
            <input type="tel" value= <%=user.getPhone()%> class="phone" name="phone"  required>
        </div>
        <div>
            <div id= "checkphone"> </div>
        </div>
        <div>
            <input type="hidden" value= <%=user.getUserId()%> name="userId">
        </div>

        <span class="buttons">
            <input type="submit" value="수정하기" formaction="/modifyMemberProcessing.jsp">
            <input type="submit" value="회원 탈퇴" formaction="/deleteMemberProcessing.jsp">
        </span>
    </div>


</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('.nickname').focusout(function(){
        let nickname = $('.nickname').val(); // input_id에 입력되는 값

        $.ajax({
            url : "/member/nicknameCheck",
            type : "post",
            data : {nickname: nickname},
            dataType : 'json',
            success : function(result){
                var $checknickname = $("#checknickname");
                if(result === 0){
                    $checknickname.html('사용할 수 없는 닉네임입니다.');
                    $checknickname.css('color','red');
                } else{
                    let regex = /^(?=.*[a-zA-Z가-힣])[a-zA-Z가-힣\d]{4,14}$/;

                    if(regex.test(nickname)){
                        $checknickname.html('사용 가능한 닉네임 입니다.')
                        $checknickname.css('color','green');
                    } else {
                        $checknickname.html('4~14자 사이의 한글, 영어, 숫자가 혼합된 닉네임으로 설정해주십시오.(숫자만 입력할 수 없습니다.)')
                        $checknickname.css('color','red');
                    }
                }
            },
            error : function(){
                alert("서버 요청 실패");
            }
        })

    })

    $('.oldPassword').focusout(function(){
        let oldPassword = $('.oldPassword').val();

        $.ajax({
            url : "/member/password",
            type : "post",
            data : {oldPassword : oldPassword},
            dataType : 'json',
            success : function(result){
                var $checkPassword = $("#checkPassword");

                if(result === 0){
                    $checkPassword.html('비밀번호가 일치하지 않습니다..');
                    $checkPassword.css('color','red');
                } else{
                    $checkPassword.html('비밀번호가 일치합니다.');
                    $checkPassword.css('color','green');
                }
            },
            error : function(){
                alert("서버 요청 실패");
            }
        })
    })

    $('.password').focusout(function() {
        let password = $('.password').val();

        var $newPassword = $("#newPassword");
        let regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,14}$/;

        if(regex.test(password)){
            $newPassword.html('사용 가능한 비밀번호입니다.')
            $newPassword.css('color','green');
        } else {
            $newPassword.html('4~14자 사이의 영어와 숫자 혼합된 비밀번호로 설정해주십시오.')
            $newPassword.css('color','red');
        }
    })

    $('.name').focusout(function() {
        let name = $('.name').val();

        var $checkname = $("#checkname");
        let regex = /^[가-힣]{2,5}$/;

        if(regex.test(name)){
            $checkname.html('올바른 이름입니다.')
            $checkname.css('color','green');
        } else {
            $checkname.html('2~5자 사이의 한글을 입력해주십시오.')
            $checkname.css('color','red');
        }
    })

    $('.phone').focusout(function() {
        let phone = $('.phone').val();

        var $checkphone = $("#checkphone");
        let regex = /^(01[016789]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

        if(regex.test(phone)){
            $checkphone.html('올바른 핸드폰 번호 형식입니다.')
            $checkphone.css('color','green');
        } else {
            $checkphone.html('올바른 핸드폰 형식이 아닙니다.')
            $checkphone.css('color','red');
        }
    })

</script>
</body>
</html>