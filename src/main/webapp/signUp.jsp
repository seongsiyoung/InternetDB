<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public String salt() {

        String salt="";
        try {
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            byte[] bytes = new byte[16];
            random.nextBytes(bytes);
            salt = new String(Base64.getEncoder().encode(bytes));

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return salt;
    }
%>
<html>
<head>
    <title>Sign Up</title>
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
        input[type="submit"] {
            width: 50%;
            height: 3rem;
            padding: 10px;
            margin-top: 10px;
            background-color: #4cbdea;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
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
    </style>
</head>
<body class = "parent">
<form action="signUpProcessiong.jsp" method="post">
    <div class="signup">
        <div>
            <h2>회원가입</h2>
        </div>
        <div>
            <input type="text" placeholder="이메일" class = "userId" name="userId">
        </div>
        <div>
            <div id= "checkId"> </div>
        </div>
        <div>
            <input type="password" placeholder="비밀번호" name="password">
        </div>
        <div>
            <input type="text" placeholder="닉네임" class="nickname" name="nickname">
        </div>
        <div>
            <span id= "checknickname"> </span>
        </div>
        <div>
            <input type="text" placeholder="이름" name="name">
        </div>
        <div>
           <input type="tel" placeholder="연락처" name="phone">
        </div>
        <input type="hidden" name="salt" value=<%=salt()%>>
        <%

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formattedDateTime = LocalDateTime.now().format(formatter);
        %>
        <input type="hidden" name="createdAt" value="<%=formattedDateTime%>">
    </div>
    <input class="submitBtn" type="submit" value="가입하기">

</form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('.userId').focusout(function(){
        let userId = $('.userId').val(); // input_id에 입력되는 값

        $.ajax({
            url : "/member/idCheck",
            type : "post",
            data : {userId: userId},
            dataType : 'json',
            success : function(result){
                var $checkId = $("#checkId");
                if(result === 0){
                    $checkId.html('사용할 수 없는 아이디입니다.');
                    $checkId.css('color','red');
                } else{
                    $checkId.html('사용할 수 있는 아이디입니다.');
                    $checkId.css('color','green');
                }
            },
            error : function(){
                alert("서버 요청 실패");
            }
        })

    })

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
                    $checknickname.html('사용할 수 있는 닉네임입니다.');
                    $checknickname.css('color','green');
                }
            },
            error : function(){
                alert("서버 요청 실패");
            }
        })

    })
</script>
</body>
</html>

