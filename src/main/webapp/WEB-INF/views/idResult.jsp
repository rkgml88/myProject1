<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/idResult.css">
    <title>IN COFFEE | 아이디 찾기</title>
    <style>
        
    </style>
</head>
<body>
<div id="wrap">
<!-- 카테고리 -->
<jsp:include page="/WEB-INF/views/nav.jsp" />
    <section>
    	<div id="contain">             
            <div id="category">
                <h1>아이디 찾기</h1>
            </div>
            <div id="main">
                <div id="resultWrap">
                	<ul id="resultID">
					    <c:forEach var="member" items="${members}">
					        <li>
					            <c:if test="${not empty member.username}">
					                <span class="blue">일반 아이디: </span>${member.username}
					            </c:if>
					            <c:if test="${not empty member.naverId}">
					                <span class="blue">네이버 아이디: </span>${member.naverId}
					            </c:if>
					            <c:if test="${not empty member.googleId}">
					                <span class="blue">구글 아이디: </span>${member.googleId}
					            </c:if>
					        </li>
					    </c:forEach>
					</ul>
                </div>
                <div id="bottomRow">
                    <a href="login" id="login">로그인</a>
                    <a href="findPW" id="findPW">비밀번호 변경</a>
                </div>
            </div>
    	</div>    
    </section>
    <!-- footer -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</div>
</body>
</html>