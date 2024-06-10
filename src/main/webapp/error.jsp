<%@ page contentType="text/html;charset=utf-8" %>
<html>
    <head>
    <title>에러 처리 페이지</title>
    <style>
    .errorProcessing {
        padding:50px;
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
            <img src="./Icon/error.png" width="850px" height="600px">
            <div class="errormsg" align="center">
            &emsp;&emsp;&emsp;에러가 발생했습니다.<br><br>
            &emsp;&emsp;&emsp;<a href="index.jsp">메인화면으로 돌아가기</a>
            </div>
        </div>

    </body>
</html>