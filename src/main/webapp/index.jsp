<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">
    <title>분실물 센터</title>
    <style>
        .menu-bar {
            width:100%;
        }
        .menu{
            display:flex;
            justify-content: space-between;
            list-style-type:none;
            margin:0;
            overflow:hidden;
        }
        .menu li{
        }
    </style>
</head>
<body>
    <div align="center">
        <table>
            <tr>
                <td>로고</td>
                <td>&emsp;&emsp;&emsp;</td>
                <td>
                    <div class="search">
                        <input type="text" placeholder="분실물 검색">
                        <input type="image" alt="검색 버튼" width="30" height="30">
                    </div>
                </td>
                <td>&emsp;&emsp;&emsp;</td>
                <td>
                    <div class="my">
                        <input type="image">
                        <input type="image">
                    </div>
                </td>
            </tr>
        </table>
        <br>
        <div class="menu-bar">
            <ul class="menu">
                <li>종합 안내</li>
                <li>분실물 신고</li>
                <li>분실물 등록</li>
            </ul>
        </div>
        <h2>최근 등록된 분실물</h2>
        <hr>

    </div>
</body>
</html>
