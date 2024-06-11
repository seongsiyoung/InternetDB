<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="com.InternetDB.util.Encrytor" %>
<%@ page language ="java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!


    public String encryptPassword(String password, String salt) {
        String saltedPassword = salt + password;
        String result = null;
        try {
            MessageDigest msg = MessageDigest.getInstance("SHA-512");
            msg.update(saltedPassword.getBytes());

            result = String.format("%128x", new BigInteger(1, msg.digest()));

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return result;
    }
%>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="./css/signUp.css">
    <title>Sign Up</title>
</head>
<body class = "parent">
<form action="signUpProcessiong.jsp" method="post">
    <div class="signup">
        <div>
            <h2>회원가입</h2>
        </div>
        <div>
            <input type="text" placeholder="이메일" class = "userId" name="userId" required>
        </div>
        <div>
            <div id= "checkId"> </div>
        </div>
        <div>
            <input type="password" placeholder="비밀번호" class="password" name="password" required>
        </div>
        <div>
            <span id= "newPassword"> </span>
        </div>
        <div>
            <input type="text" placeholder="닉네임" class="nickname" name="nickname" required>
        </div>
        <div>
            <span id= "checknickname"> </span>
        </div>
        <div>
            <input type="text" placeholder="이름" class="name" name="name" required>
        </div>
        <div>
            <span id= "checkname"> </span>
        </div>
        <div>
           <input type="tel" placeholder="연락처" class="phone" name="phone" required>
        </div>
        <div>
            <span id= "checkphone"> </span>
        </div>
        <input type="hidden" name="salt" value=<%=Encrytor.salt()%>>
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
        let userId = $('.userId').val();

        $.ajax({
            url : "/member/idCheck",
            type : "post",
            data : {userId: userId},
            dataType : 'json',
            success : function(result){
                var $checkId = $("#checkId");
                if(result === 0){
                    $checkId.html('사용 불가능한 이메일입니다.');
                    $checkId.css('color','red');
                } else{
                    let regex = /^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$/;

                    if(regex.test(userId)){
                        $checkId.html('사용 가능한 이메일 입니다.')
                        $checkId.css('color','green');
                    } else {
                        $checkId.html('사용 불가능한 이메일입니다.')
                        $checkId.css('color','red');
                    }
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
                    $checknickname.html('중복된 닉네임입니다.');
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

