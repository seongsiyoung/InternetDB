<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
;

        }
        form{
            width: 40rem;
            align-content: center;
            text-align: center;
        }

        .signup{
            width: 100%;
            border-collapse: separate;
            border-spacing: 1rem;
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
            height: 100%;
        }


        button{
            width: 100%;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            padding: 10px;
            appearance: none;
            text-align: left;
            height: 100%;

        }


        /* 가입하기 버튼의 스타일 */
        input[type="submit"] {
            width: 50%;
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
            font-size: 24px;
            color: #333;
            text-align: center;
        }

    </style>
</head>
<body class = "parent">
<form action="login.jsp">
    <table class="signup">
        <tr>
            <td colspan="2"><h2>회원가입</h2></td>
        </tr>
        <tr>
            <td>
                <input type="text" placeholder="이메일">
            </td>
            <td>
                <button>temp</button>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="password" placeholder="비밀번호"></td>
        </tr>
        <tr>
            <td><input type="password" placeholder="닉네임"></td>
            <td>
                <button>temp</button>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="text" placeholder="이름"></td>
        </tr>
        <tr>
            <td colspan="2"><input type="tel" placeholder="연락처"></td>
        </tr>
    </table>
    <input type="submit" value="가입하기">

</form>
</body>
</html>

