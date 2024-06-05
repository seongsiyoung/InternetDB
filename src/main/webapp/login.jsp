<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Login</title>
    <style>

        .align {
            display: grid;
            place-items: center;
        }

        .grid {
            inline-size: 90%;
            margin-inline: auto;
            max-inline-size: 20rem;
        }

        html {
            box-sizing: border-box;
            font-size:  100%;
        }

        body {
            background-color: #ffffff;
            color: #4b4b4b;
            font-family: "Open Sans", sans-serif;
            font-size: 0.875rem;
            font-weight: 400;
            line-height: 1.5;
            margin: 0;
            min-block-size: 100vh;
        }

        img {
            display: block;
            margin-left: auto;
            margin-right: auto;
            inline-size: 80%;
            margin-bottom: 1rem;
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

        input {
            background-image: none;
            border: 0;
            margin: 0;
            outline: 0;
            padding: 0;
            color: inherit;
            font: inherit;
        }

        input[type="submit"] {
            cursor: pointer;
        }

        .form {
            display: grid;
            gap: 0.875rem;
        }

        .form input[type="password"],
        .form input[type="text"],
        .form input[type="submit"] {
            inline-size: 100%;
        }

        .login {
            color: #3f3e3e;
        }

        .login input[type="text"],
        .login input[type="password"],
        .login input[type="submit"] {
            padding: 1rem;
        }


        .login input[type="password"],
        .login input[type="text"] {
            background-color: #f3f3f3;

        }

        .login input[type="password"]:focus,
        .login input[type="password"]:hover,
        .login input[type="text"]:focus,
        .login input[type="text"]:hover {
            background-color: #eee;
        }

        .login input[type="submit"] {
            background-color: #4cbdea;
            color: #eeeeee;
            font-weight: 700;
            text-transform: uppercase;
        }

        .login input[type="submit"]:focus,
        .login input[type="submit"]:hover {
            background-color: #71b1f1;
        }

        p {
            margin-block: 1.5rem;
        }

        .text--center {
            text-align: center;
        }

    </style>
</head>
<body class="align">

<div class="grid">

    <img src="Icon/pagelogo.png">

    <form action= loginProcessing.jsp method="POST" class="form login">

        <div class="form__field">
            <label for="login__username"></label><input autocomplete="username" id="login__username" type="text" name="id" class="form__input" placeholder="Username" required>
        </div>

        <div class="form__field">
            <label for="login__password"></label><input id="login__password" type="password" name="password" class="form__input" placeholder="Password" required>
        </div>

        <div class="form__field">
            <input type="submit" value="로그인">
        </div>

    </form>

    <p class="text--center">아직 회원이 아니신가요?<br>
        <a href="signUp.jsp">회원 가입 하기</a></p>
</div>
</body>
</html>
