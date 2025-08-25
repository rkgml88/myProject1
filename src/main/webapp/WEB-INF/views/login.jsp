<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    String clientId = "OF20uA908Z1LmP8wpvDs";
    String redirectURI = java.net.URLEncoder.encode("http://localhost:8080/naver/callback", "UTF-8");
    String state = session.getId(); // CSRF 방지용 임의값
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
            + "&client_id=" + clientId
            + "&redirect_uri=" + redirectURI
            + "&state=" + state;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IN COFFEE | 로그인</title>
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/login.css">
    <script src="resources/js/nav.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<c:if test="${not empty msg}">
    <script>
        alert("${msg}");
    </script>
</c:if>
<!-- 로그인 실패 시 alert 출력 -->
<c:if test="${param.error == 'true'}">
    <script>
        alert('로그인에 실패하셨습니다.');
    </script>
</c:if>

    <div class="wrap">
        <!-- 카테고리 -->
        <jsp:include page="/WEB-INF/views/nav.jsp" />

        <section>
            
            <div class="loginWrap">
            <div id="category">
                <h1>login</h1>
            </div>
            	<div id="loginMain">
	                <form action="<c:url value='/login' />" method="post" name="loginFrm"
	                    onsubmit="validateForm(this)">
	                    <sec:csrfInput />
	                    <div class="loginBox">
	                        <p>아이디</p>
	                        <input type="text" name="username" placeholder="ID"><br>
	                        <p>비밀번호</p>
	                        <div id="pwBox">
		                        <input type="password" name="password" id="password" placeholder="Password">
		                        <i class="bi bi-eye-slash eye-icon" onclick="togglePassword()"></i>
	                        </div>
	                    </div>
	                    <input type="checkbox" name="loginSave" id="loginSave">
	                    <label for="loginSave" style="cursor: pointer;">로그인 상태 유지</label>
	                    <input type="submit" value="로그인">
	                    <button type="button" id="joinBtn"><a href="joinU" >회원가입</a></button>
	                                      
	                </form>
	                <div id="findIdPw">
	                	<a href="findID">아이디 찾기</a>
	                	<span>|</span> 
	                	<a href="findPW">비밀번호 변경</a>
	                </div>
	                <div class="line">
	                    	sns 로그인
                   	</div>
                   	<div id="snsLogin">
		                <!-- 네이버 로그인 -->
		                <a href="<%=apiURL%>">
						    <img height="35" src="resources/img/btnG_아이콘원형.png"/>
						</a>
						<!-- 구글 로그인 -->
						<a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=849591001463-2hfoerqknmk47re1rvksn0clvdvq83s5.apps.googleusercontent.com&redirect_uri=http://localhost:8080/google/callback&response_type=code&scope=openid%20email%20profile&state=randomString123">
						    <img height="35" src="resources/img/google_login.png" alt="구글 로그인"/>
						</a>
					</div>  
                </div>                
            </div>
        </section>

        <!-- footer -->
        <jsp:include page="/WEB-INF/views/footer.jsp" />
    </div>

<script>
function togglePassword() {
    const input = document.getElementById("password");
    const icon = document.querySelector(".eye-icon");
    if (input.type === "password") {
        input.type = "text";
        icon.classList.remove("bi-eye-slash");
        icon.classList.add("bi-eye");
    } else {
        input.type = "password";
        icon.classList.remove("bi-eye");
        icon.classList.add("bi-eye-slash");
    }
}

// 아이디 & 비빌번호가 빈칸인지 확인
function validateForm(form) {
    if(!form.username.value) {
        alert("아이디를 입력하세요.")
        return false;
    }
    if(form.password.value == "") {
        alert("비밀번호를 입력하세요.")
        return false;
    }
}
</script>
</body>
</html>