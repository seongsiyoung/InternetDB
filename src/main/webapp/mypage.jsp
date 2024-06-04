<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/mystyle.css?after">

    <style>
        .memberBox{
            display:flex;
            justify-content:center;
            min-width: 80rem;
        }

        .memberInfo{
            border-bottom: 1px solid black;
            padding-bottom: 0.5rem;
        }

        fieldset{
            width:40rem;
            height: 20rem;
            margin-top: 3rem;
            margin-bottom: 3rem;
            padding: 2rem;
            min-width: 40rem;
            font-size: 1.5rem;
            line-height: normal;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .modifyBtn{
            font-size: 1.3rem;
            width: 6rem;
            height: 2.5rem;
            margin-left: auto;
            background-color: #3aa9e0;
            border: none;
            border-radius: 5px;
            color: white;
        }
        .pageBox{
            display:flex;
            justify-content:center;
        }
        .myPost{
            min-width: 80rem;
        }
        .postTitle{
            font-size: 2rem;
        }
        .postBox{
            display: flex;
            justify-content: center;
            min-height: 20rem;
            padding: 2rem;
        }
        .post{
            height: 20rem;
            width: 20rem;
        }

        .postImage{
            width: 100%;
            height: 80%;
            object-fit: contain;
            min-height: 16rem;
            min-width: 20rem;
        }

        .postName{
            width: 100%;
            height: 20%;
            font-size: 1.5rem;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }





        .page{
            text-align: center;
            width: 50%;
        }

        .pagination {
            list-style: none;
            display: inline-block;
            padding: 0;
            margin-top: 20px;
        }

        .pagination li {
            display: inline;
            text-align: center;
        }

        .pagination a {
               float: left;
               display: block;
               font-size: 14px;
               text-decoration: none;
               padding: 5px 12px;
               color: #96a0ad;
               line-height: 1.5;
        }

        .pagination a.active {
            cursor: default;
            color: #ffffff;
        }

        .pagination a:active {
            outline: none;
        }

        .modal .num {
            margin-left: 3px;
            padding: 0;
            width: 30px;
            height: 30px;
            line-height: 30px;
            -moz-border-radius: 100%;
            -webkit-border-radius: 100%;
            border-radius: 100%;
        }

        .modal .num:hover {
            background-color: #2e9cdf;
            color: #ffffff;
        }

        .modal .num.active, .modal .num:active {
            background-color: #2e9cdf;
            cursor: pointer;
        }





    </style>
<title>분실물 신고</title>
</head>
<body>
    <div align="center">
        <table>
            <tr>
            <td><img src="./Icon/pagelogo.png" width="260" height="70"></td>
            <td>&emsp;&emsp;&emsp;</td>
            <td>
                <div class="search">
                    <input type="text" id="searchbar" name="selectLost" placeholder="분실물 검색">
                    <input type="image" id="searchIcon" src="./Icon/search.png" alt="검색 버튼" width="30" height="30">
                </div>
             </td>
                <td>&emsp;&emsp;&emsp;&emsp;</td>
                <td>
                    <div class="my">
                        <input type="image" id="mypageIcon" src="./Icon/mypage.png" alt="마이페이지" width="40" height="40">&nbsp;
                        <input type="image" id="alarm" src="./Icon/alarm.png" alt="마이페이지" width="45" height="40">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div class="memberBox">
        <fieldset>
            <legend>사용자 정보</legend>
            <div class="memberInfo">아이디 :  </div>
            <div class="memberInfo">이름 :  </div>
            <div class="memberInfo">닉네임 :  </div>
            <div class="memberInfo">연락처 :  </div>
            <button class="modifyBtn">수정하기</button>
            </fieldset>
    </div>

    <div class="myPost">
        <div style=" display:flex; justify-content:center;">
            <div class="postTitle">작성한 게시물</div>
        </div>
        <div class="postBox">

            <div class="post">
                <img class="postImage" src="Icon/alarm.png">
                <div class="postName">Name</div>
            </div>
            <div class="post">
                <img class="postImage" src="Icon/alarm.png">
                <div class="postName">Name</div>
            </div>
            <div class="post">
                <img class="postImage" src="Icon/alarm.png">
                <div class="postName">Name</div>
            </div>
            <div class="post">
                <img class="postImage" src="Icon/alarm.png">
                <div class="postName">Name</div>
            </div>
        </div>
        <div class="pageBox">
            <div class="page">
                <ul class="pagination modal">
                    <li> <a href="#" class="arrow left"><<</a></li>
                    <li> <a href="#" class="active num">1</a></li>
                    <li> <a href="#" class="num">2</a></li>
                    <li> <a href="#" class="num">3</a></li>
                    <li> <a href="#" class="num">4</a></li>
                    <li> <a href="#" class="num">5</a></li>
                    <li> <a href="#" class="num">6</a></li>
                    <li> <a href="#" class="num">7</a></li>
                    <li> <a href="#" class="num">8</a></li>
                    <li> <a href="#" class="num">9</a></li>
                    <li> <a href="#" class="arrow right">>></a></li>
                </ul>
            </div>
        </div>
    </div>

</body>
</html>