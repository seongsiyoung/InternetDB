<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <title>에러 처리 페이지</title>
    <style>
        .errorProcessing {
            padding:50px;
            margin-top:100px;
        }

        a {
            color: #94c5ff;
            outline: 0;
            text-decoration: none;
        }

        a:focus,
        a:hover {
            color: #4cbdea;
        }

        .errormsg {
        }
    </style>
</head>
<body>
<div class="errorProcessing" align="center">
    <img src="./Icon/ErrorRobot.png" width="700px" height="450px">
    <div class="errormsg" align="center">
        &emsp;&emsp;&emsp;서버에 문제가 발생했습니다. 관리자에게 문의하세요.<br><br>
        &emsp;&emsp;&emsp;<a href="index.jsp">메인화면으로 돌아가기</a>
    </div>
</div>

</body>
</html>