<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/findID.css">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="resources/js/nav.js"></script>
    <title>IN COFFEE | 비밀번호 변경</title>
    <style>
    #idWrap{
	    border: 1px solid #ddd;
	    padding: 20px;
	    box-sizing: border-box;
	    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
	    margin-bottom: 15px;
	}
	#idWrap p{
		text-align: center;
	}
	#username{
		margin-bottom: 7px;
		border: 1px solid #ddd;
		box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		padding: 10px;
		border-radius: 20px;
		width: 100%;
	    box-sizing: border-box;
	    font-size: 15px;
	    text-align: center;
	}
	
	@media screen and (max-width: 480px) {
		#idWrap{
		    padding: 15px;
		}
		#idWrap p{
			font-size: 14px;
		}
		#username{
			font-size: 12px;
			padding: 7px;
		}
	}
    </style>
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
            	<form id="verifyForm" method="post" action="${pageContext.request.contextPath}/verifyCodePW">
            	<sec:csrfInput />
            	<!-- 인증 방식 선택 탭 -->
				<div id="authTabs">
				    <button type="button" id="tabTel" class="active">전화번호 인증</button>
				    <button type="button" id="tabEmail">이메일 인증</button>
				</div>

    			<input type="hidden" id="verifyType" name="verifyType" value="tel">
    			
    			<div id="idWrap">
    				<p>비밀번호를 변경하고자하는 아이디를 입력해주세요.</p>
    				<input type="text" id="username" name="username">
    				<p class="red" id="idErrMsg"></p>
    			</div>
                <div id="telWrap">
                    <h3>회원정보에 등록한 휴대전화로 인증</h3>
                    <p class="explain">회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 비밀번호를 변경하실 수 있습니다.</p>
                    <div class="content">
	                    <label class="tag">이름</label>
	                    <input type="text" class="inp" id="telName" name="name">
                    </div>
                    <div class="content">
	                    <label class="tag">휴대전화</label>
	                    <input type="text" class="inp" id="tel" name="tel">	    	                        
                    </div>
                    <div class="content">
                    	<label class="tag"></label>
	                    <input type="text" class="inp" id="telCode" name="code" placeholder="인증번호 6자리">	                    
                    </div>
                    <button type="button" id="sendTelBtn">인증번호 받기</button>
                    <span id="timerDisplayTel" style="display:none;">05:00</span>
                    <div class="errMsg">
                    	<p class="red" id="telNameErrMsg"></p>
                    	<p class="red" id="telErrMsg"></p>
                    	<p class="red" id="telCodeErrMsg"></p>
                    </div>
                </div>
                <div id="emailWrap">
                    <h3>본인확인 이메일로 인증</h3>
                    <p class="explain">본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 비밀번호를 변경하실 수 있습니다.</p>
                    <div class="content">
	                    <label class="tag">이름</label>
	                    <input type="text" class="inp" id="emailName" name="name">
                    </div>
                    <div class="content">
	                    <label class="tag">이메일</label>
	                    <input type="email" class="inp" id="email" name="email"> 
                    </div>                   
                    <div class="content">
                    	<label class="tag"></label>
	                    <input type="text" class="inp" id="emailCode" name="code" placeholder="인증번호 6자리">
                    </div>
                    <button type="button" id="sendEmailBtn">인증번호 받기</button>
                    <span id="timerDisplayEmail" style="display:none;">05:00</span>
                    <div class="errMsg">
                    	<p class="red" id="emailNameErrMsg"></p>
                    	<p class="red" id="emailErrMsg"></p>
                    	<p class="red" id="emailCodeErrMsg"></p>
                    </div>
                </div>
                <div id="bottomRow">
				    <button type="submit" id="verifyBtn">인증 및 비밀번호 변경</button>
                </div>
                </form>
            </div>        
        </div>
    </section>
    <!-- footer -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
</div>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

// 탭 버튼 클릭 시 실행 함수
function switchVerifyType(type) {
    $("#verifyType").val(type);
    if(type === "tel") {
        $("#telWrap").show().find("input").prop("disabled", false);
        $("#emailWrap").hide().find("input").prop("disabled", true);
        $("#tabTel").addClass("active");
        $("#tabEmail").removeClass("active");
    } else {
        $("#telWrap").hide().find("input").prop("disabled", true);
        $("#emailWrap").show().find("input").prop("disabled", false);
        $("#tabTel").removeClass("active");
        $("#tabEmail").addClass("active");
    }
}

// 탭 버튼 이벤트 연결
$("#tabTel").click(function() {
    switchVerifyType("tel");
});
$("#tabEmail").click(function() {
    switchVerifyType("email");
});

// 페이지 로드 시 초기 상태 세팅 (전화번호 인증 보이게)
$(document).ready(function(){
    switchVerifyType("tel");
});

function startTimer(duration, display) {
    var timer = duration, minutes, seconds;
    var intervalId = setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.text(minutes + ":" + seconds);

        if (--timer < 0) {
            clearInterval(intervalId);
            alert("인증 코드가 만료되었습니다. 다시 요청해주세요.");
            // 인증번호 입력란 초기화 등 추가 처리 가능
            $("#emailCode").val('');
        }
    }, 1000);
}

$("#sendTelBtn").click(function(){
    $.ajax({
        url: "${pageContext.request.contextPath}/sendTelCode",
        type: "POST",
        data: { tel: $("#tel").val() }, // 입력한 휴대폰 번호
        beforeSend: function(xhr){
            xhr.setRequestHeader(header, token);
        },
        success: function(data){
            alert(data);
            var fiveMinutes = 60 * 5;
            var display = $("#timerDisplayTel");
            display.show();
            startTimer(fiveMinutes, display);
        },
        error: function(xhr){
            alert("문자 발송 실패: " + xhr.responseText);
        }
    });
});


$("#sendEmailBtn").click(function(){
    $.ajax({
        url: "${pageContext.request.contextPath}/sendEmailCode",
        type: "POST",
        data: { email: $("#email").val() },
        beforeSend: function(xhr){
            xhr.setRequestHeader(header, token);
        },
        success: function(data){
            alert(data);
            var fiveMinutes = 60 * 5;
            var display = $("#timerDisplayEmail");
            display.show();        // 여기서 보이게 설정
            startTimer(fiveMinutes, display);
        },
        error: function(xhr){
            alert("메일 발송 실패: " + xhr.responseText);
        }
    });
});

//폼 제출 시 유효성 검사
$(document).ready(function(){
	// 적절한 값이 입력되면 에러메시지 제거
	$("#username").on("input", function () {
		if ($(this).val().trim() !== "") {
	        $("#idErrMsg").html("");
	    }
	});
	
	$("#tel").on("input", function () {
	    this.value = this.value.replace(/[^0-9]/g, "");
	    if (/^\d{8,11}$/.test(this.value)) {
	        $("#telErrMsg").html("");
	    }
	});
	
	$("#telName").on("input", function () {
	    if ($(this).val().trim() !== "") {
	        $("#telNameErrMsg").html("");
	    }
	});
	
	$("#emailName").on("input", function () {
	    if ($(this).val().trim() !== "") {
	        $("#emailNameErrMsg").html("");
	    }
	});
	
	$("#email").on("input", function () {
	    if ($(this).val().trim() !== "") {
	        $("#emailErrMsg").html("");
	    }
	});
	
	$("#telCode").on("input", function () {
	    if ($(this).val().trim() !== "") {
	        $("#telCodeErrMsg").html("");
	    }
	});
	
	$("#emailCode").on("input", function () {
	    if ($(this).val().trim() !== "") {
	        $("#emailCodeErrMsg").html("");
	    }
	});
	
	$("#verifyForm").on("submit", function (e) {
	    e.preventDefault();
	
	    let isValid = true;
	    const verifyType = $("#verifyType").val() || "tel"; // 기본값
	    
	    const id = $("#username").val().trim();
	    const telName = $("#telName").val().trim();
	    const emailName = $("#emailName").val().trim();
        const tel = $("#tel").val().trim();
        const email = $("#email").val().trim();
        const telCode = $("#telCode").val().trim();
        const emailCode = $("#emailCode").val().trim();
	    
	 	// 에러 초기화
	    $("#idErrMsg, #telNameErrMsg, #emailNameErrMsg, #telErrMsg, #emailErrMsg, #telCodeErrMsg, #emailCodeErrMsg").html("");
	    
	 	// 아이디 검사
	    if (!id) {
	        $("#idErrMsg").html("아이디를 입력해 주십시오.");
	        isValid = false;
	    } else if (!/^[A-Za-z0-9]{5,20}$/.test(id)) {
	        $("#idErrMsg").html("아이디는 영문과 숫자 조합 5~20자리만 가능합니다.");
	        isValid = false;
	    }
	    
	 	// 전화번호 인증일 때만 검사
	    if (verifyType === "tel") {
	        if (!telName) {
	            $("#telNameErrMsg").html("* 이름을 입력해 주십시오.");
	            isValid = false;
	        }
	        if (!tel) {
	            $("#telErrMsg").html("* 전화번호를 입력해 주십시오.");
	            isValid = false;
	        } else if (!/^\d{8,11}$/.test(tel)) {
	            $("#telErrMsg").html("* 전화번호는 숫자만 8~11자리 입력해 주십시오.");
	            isValid = false;
	        }
	        if (!telCode) {
	            $("#telCodeErrMsg").html("* 인증코드를 입력해 주십시오.");
	            isValid = false;
	        }
	    }

	    // 이메일 인증일 때만 검사
	    if (verifyType === "email") {
	        if (!emailName) {
	            $("#emailNameErrMsg").html("* 이름을 입력해 주십시오.");
	            isValid = false;
	        }
	        if (!email) {
	            $("#emailErrMsg").html("* 이메일을 입력해 주십시오.");
	            isValid = false;
	        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
	            $("#emailErrMsg").html("* 올바른 이메일 형식을 입력해 주십시오.");
	            isValid = false;
	        }
	        if (!emailCode) {
	            $("#emailCodeErrMsg").html("* 인증코드를 입력해 주십시오.");
	            isValid = false;
	        }
	    }
	    
	    if (isValid) {
	    	this.submit();
	    }
	});
});
</script>
</body>
</html>