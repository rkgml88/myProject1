<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>회원가입 | 관리자</title>
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/join.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <script src="resources/js/nav.js"></script>
    <script src="resources/js/join.js"></script>
</head>
<body>
    <div class="wrap">
        <!-- 카테고리 -->
        <jsp:include page="/WEB-INF/views/nav.jsp" />

        <section>
            
            <div class="joinWrap">
            <div id="category">
                <h1>join</h1>
            </div>
                <form action="/joinA" method="post" id="joinFrm">
                	<sec:csrfInput />
                    <div id="joinBox">
                        <input type="text" class="inp" id="id" name="username" placeholder="아이디">
                        <input type="button" class="btn" id="idCheckBtn" value="중복확인">
                        <p class="blue" id="idCheck"></p>
                        <p class="red" id="idErrMsg"></p>
                        <input type="password" class="inp" id="pw" name="password" placeholder="비밀번호">
                        <p class="red" id="pwErrMsg"></p>
                        <input type="password" class="inp" id="pw2" placeholder="비밀번호 재확인">
                        <p class="red" id="pwErrMsg2"></p>
                        <input type="text" class="inp" id="name" name="name" placeholder="이름">
                        <p class="red" id="nameErrMsg"></p>
                        <input type="text" class="inp" id="tel" name="tel" placeholder="전화번호">
                        <p class="red" id="telErrMsg"></p>
                        <input type="email" class="inp" id="email" name="email"  placeholder="이메일">
                        <p class="red" id="emailErrMsg"></p>
                        <input type="text" class="inp" id="sample6_postcode" name="postcode" placeholder="우편번호" readonly>
                        <input type="button" class="btn" value="검색" id="postcodeBtn" onclick="sample6_execDaumPostcode()">
                        <input type="text" class="inp" id="sample6_address" name="address1" placeholder="주소" readonly>
                        <input type="hidden" id="sample6_extraAddress">
                        <input type="text" class="inp" id="sample6_detailAddress" name="address2" placeholder="상세주소">
                        <p class="red" id="addrErrMsg"></p>
                    </div>
                    <div id="chk">
                    	<input type="checkbox" id="marketingYn" name="marketingYn" value="Y">
                        <label for="marketingYn" style="cursor: pointer;">마케팅 알림 동의(선택)</label>                        
                        <!-- <p class="red" id="marketingYnErrMsg"></p> -->
                    </div>
                    <div class="button_final">
                        <input type="submit" value="가입하기">
                    </div>
                </form>
            </div>
        </section>

        <!-- footer -->
        <jsp:include page="/WEB-INF/views/footer.jsp" />
    </div>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            
         	// 값이 입력되었으므로 에러 메시지 제거
            $("#addrErrMsg").html("");
         
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
$(document).ready(function(){
	
	$("#joinFrm").on("submit", function (e) {
        e.preventDefault();

        let isValid = true;
        const tel = $("#tel").val().trim();
        const postcode = $("#sample6_postcode").val().trim();
        
        const telRaw = tel.replace(/-/g, "");
        if (!tel) { 
        	$("#telErrMsg").html("전화번호를 입력해 주십시오."); 
        	isValid = false; 
       	} else if (!/^\d{8,11}$/.test(telRaw)) {
       		$("#telErrMsg").html("전화번호는 숫자만 8~11자리 입력해 주십시오."); 
       		isValid = false; 
     	}
        
        if (!postcode) {
            $("#addrErrMsg").html("주소를 입력해 주십시오.");
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