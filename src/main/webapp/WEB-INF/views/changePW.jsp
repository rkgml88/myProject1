<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IN COFFEE | 비밀번호 변경</title>
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/changePW.css">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="resources/js/nav.js"></script>
</head>
<body>
<div id="wrap">
    <!-- 카테고리 -->
	<jsp:include page="/WEB-INF/views/nav.jsp" />
	
    <section>        
        <div id="contain">
            <div id="category">
                <h1>비밀번호 변경</h1>
            </div>
            <div id="main">
                <form id="changePWForm" method="post" action="${pageContext.request.contextPath}/changePW">
                <sec:csrfInput />
                <div id="idWrap">
                	<input type="hidden" name="verifyType" value="${verifyType}">
                	<input type="text" id="username" name="username" value="${username}" readonly>
                    <input type="hidden" name="name" value="${name}">
                    <input type="hidden" name="email" value="${email}">
   					<input type="hidden" name="tel" value="${tel}">
                </div>
                <div id="pwWrap">
    				<p>비밀번호를 변경해주세요.</p>
                    <input type="password" class="inp" id="password" name="password" placeholder="새 비밀번호">
                    <p class="red" id="pwErrMsg"></p>
                    <input type="password" class="inp" id="password2" name="password2" placeholder="새 비밀번호 확인">
                    <p class="red" id="pwErrMsg2"></p>
    			</div>
                <div id="bottomRow">
                    <input type="submit" id="submitBtn" value="확인">
                </div>
                </form>
            </div>
        </div>
    </section>
    <!-- footer -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</div>
<script>
//폼 제출 시 유효성 검사
$(document).ready(function(){
	// 적절한 값이 입력되면 에러메시지 제거
	$("#password").on("input", function () {
   	    if (/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{}\[\]:;"'<>,.?/~`|\\])[A-Za-z\d!@#$%^&*()\-_=+{}\[\]:;"'<>,.?/~`|\\]{8,25}$/.test(this.value)) {
   	        $("#pwErrMsg").html("");
   	    }
   	});
   	
   	$("#password2").on("input", function () {
   	    if ($(this).val().trim() == $("#password").val().trim()) {
   	        $("#pwErrMsg2").html("");
   	    }
   	});
   	
	$("#changePWForm").on("submit", function (e) {
	    e.preventDefault();
	
	    let isValid = true;
	
	    const pw = $("#password").val().trim();
	    const pw2 = $("#password2").val().trim();
	
	    // 에러 초기화
	    $("#pwErrMsg, #pwErrMsg2").html("");
	 
	    if (!pw) {
	        $("#pwErrMsg").html("비밀번호를 입력해 주십시오.");
	        isValid = false;
	    } else if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{}\[\]:;"'<>,.?/~`|\\])[A-Za-z\d!@#$%^&*()\-_=+{}\[\]:;"'<>,.?/~`|\\]{8,25}$/.test(pw)) {
	        $("#pwErrMsg").html("비밀번호는 영문자, 숫자, 특수기호 조합(8~25자리)이어야 합니다.");
	        isValid = false;
	    }
	    
	    if (!pw2) {
	        $("#pwErrMsg2").html("비밀번호를 재확인해 주십시오.");
	        isValid = false;
	    } else if (pw != pw2) {
	        $("#pwErrMsg2").html("비밀번호가 일치하지 않습니다.");
	        isValid = false;
	    }
	    if (isValid) {
	    	this.submit();
	    }
	});
});   
</script>
</body>
</html>