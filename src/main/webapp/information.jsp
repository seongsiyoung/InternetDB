<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connection.jsp" %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="css/lostitems.css?after">
    <title>종합 안내</title>
</head>
<body>
<div align="center">
    <!--로고 검색창 마이페이지 알림-->
    <%@ include file="headLine.jsp" %>
    <br>

    <%--  각 페이지 이동바 (종합안내, 신고된 분실물, 등록된 분실물)  --%>
    <div class="menu-bar">
        <ul class="menu">
            <li><a href="information.jsp" class="menu-link">종합 안내</a></li>
            <li><a href="reportedLostItem.jsp" class="menu-link">신고된 분실물</a></li>
            <li><a href="registeredLostItem.jsp" class="menu-link">등록된 분실물</a></li>
        </ul>
    </div>
    <br>
    <h3>종합 안내</h3>
    <hr>
    <br>
    <%--  종합 안내 사항 작성 부분  --%>
    <div align="left" style="padding-left: 15%; padding-right: 15%">
        <h3>1. 홈페이지 소개</h3>
        <ul>
            <li>저희 홈페이지는 학교에서 잃어버린 물품을 빠르게 찾을 수 있도록 돕기 위해
                만들어졌습니다. 이 사이트는 학생들이 분실물 신고 및 등록, 찾고 있는 물품
                등록, 분실물 검색 등 다양한 기능을 제공하여 분실물을 효율적으로 관리할 수
                있도록 합니다.</li>
        </ul>
        <br><br>
        <h3>2. 이용 방법</h3>
        <ol>
            <li>
                <b>회원가입 및 로그인</b>
                <p>분실물 목록 열람은 로그인하지 않아도 가능하지만, 분실물 신고 및 등록을 위해서는 먼저 회원가입을 해야합니다. 이미 가입된 회원은 로그인 후 이용할 수 있습니다.</p>
                <br>
            </li>
            <li>
                <b>분실물 신고 및 등록</b>
                <p>분실물 신고 및 등록 페이지에서 분실물 정보를 작성하여 등록할 수 있습니다. 분실물 사진, 습득 장소, 시간, 상세 설명 등을 기재해주세요.</p>
                <br>
            </li>
            <li>
                <b>분실물 검색</b>
                <p>메인 페이지 또는 검색 페이지에서 분실물의 제목 또는 키워드를 입력하여 분실물을 검색할 수 있습니다.</p>
                <br>
            </li>
            <li>
                <b>알림 기능</b>
                <p>알림 버튼을 통해 내 게시물에 달린 댓글을 확인할 수 있습니다. 알림을 클릭하면 해당 댓글이 작성된 분실물 상세 페이지로 이동합니다.</p>
                <br>
            </li>
            <li>
                <b>분실물 정보 수정 및 삭제</b>
                <p>내가 등록한 분실물은 수정 및 삭제할 수 있습니다. 개인 페이지에서 분실물 목록을 확인하고 수정하거나 삭제할 수 있습니다.</p>
                <br>
            </li>
        </ol>
        <br>
        <h3>3. 유의사항</h3>
        <ol>
            <li>
                <b>정확한 정보 기재</b>
                <p>분실물 등록 시, 정확한 정보를 기재해주세요. 잘못된 정보는 분실물 찾기에 어려움을 줄 수 있습니다.</p>
                <br>
            </li>
            <li>
                <b>개인 정보 보호</b>
                <p>사이트 이용 시, 다른 회원의 개인 정보를 무단으로 수집하거나 악용하지 마세요.</p>
                <br>
            </li>
        </ol>
        <br><br><br>
    </div>
</div>
</body>
</html>
