/**
 * 
 */
    

$(function(){
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});

// 폼 제출 시 유효성 검사
$(document).ready(function(){
		// 적절한 값이 입력되면 에러메시지 제거
		$("#id").on("input", function () {
		    if ($(this).val().trim() !== "") {
		        $("#idErrMsg").html("");
		    }
		
		    // 아이디 입력이 바뀌면 중복확인 상태를 무효화
		    idCheckDone = false;
		    canUseId = false;
		
		    // 메시지도 초기화
		    $("#idErrMsg").html("");
		    $("#idCheck").html("");
		
		});
    	
    	$("#pw").on("input", function () {
    	    if (/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{}\[\]:;"'<>,.?/~`|\\])[A-Za-z\d!@#$%^&*()\-_=+{}\[\]:;"'<>,.?/~`|\\]{8,25}$/.test(this.value)) {
    	        $("#pwErrMsg").html("");
    	    }
    	});
    	
    	$("#pw2").on("input", function () {
    	    if ($(this).val().trim() == $("#pw").val().trim()) {
    	        $("#pwErrMsg2").html("");
    	    }
    	});
    	
    	$("#tel").on("input", function () {
    	    this.value = this.value.replace(/[^0-9]/g, "");
    	    if (/^\d{8,11}$/.test(this.value)) {
    	        $("#telErrMsg").html("");
    	    }
    	});
    	
    	$("#name").on("input", function () {
    	    if ($(this).val().trim() !== "") {
    	        $("#nameErrMsg").html("");
    	    }
    	});
    	
    	$("#email").on("input", function () {
    	    if ($(this).val().trim() !== "") {
    	        $("#emailErrMsg").html("");
    	    }
    	});
    	
    	let idCheckDone = false;   // 중복확인 완료 여부
		let canUseId = false;      // 사용 가능한 아이디인지 여부
		
		// 중복확인 버튼 클릭 시
		$("#idCheckBtn").on("click", function () {
			console.log("중복확인 버튼 클릭됨");
		
		    let username = $("#id").val().trim();
		    $("#idErrMsg").html(""); // 이전 에러 제거
		
		    if (!username) {
		        $("#idErrMsg").html("아이디를 입력해 주십시오.");
		        return;
		    } else if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,20}$/.test(username)) {
	            $("#idErrMsg").html("아이디는 영문자, 숫자 조합(5~20자리)이어야 합니다.");
	            return;
	        }
		    
		    $.ajax({
		        url: "/checkUsername",   // Spring 컨트롤러에서 처리할 URL
		        method: "POST",
		        data: { username: username },
		        success: function (result) {
		            idCheckDone = true;
		            if (result === "OK") {
		                canUseId = true;
		                $("#idCheck").html("사용 가능한 아이디입니다.").css("color", "darkblue");
		            } else {
		                canUseId = false;
		                $("#idCheck").html("사용할 수 없는 아이디입니다.").css("color", "crimson");
		            }
		        },
		        error: function () {
		            alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
		        }
		    });
		});

	// 입력 중 자동 하이픈
    var $telInput = $("#tel");
    
    $telInput.on("input", function() {
        var raw = $(this).val().replace(/[^0-9]/g, "");

        if (raw.length <= 10) {
            if (raw.startsWith("02") && raw.length >= 9) {
                $(this).val(raw.replace(/^(\d{2})(\d{3,4})(\d{4})$/, "$1-$2-$3"));
            } else if (raw.length >= 10) {
                $(this).val(raw.replace(/^(\d{3})(\d{3,4})(\d{4})$/, "$1-$2-$3"));
            } else {
                $(this).val(raw);
            }
        } else if (raw.length === 11) {
            $(this).val(raw.replace(/^(\d{3})(\d{4})(\d{4})$/, "$1-$2-$3"));
        } else {
            $(this).val(raw);
        }
    });
    
    $("#joinFrm").on("submit", function (e) {
        e.preventDefault();

        let isValid = true;
        const id = $("#id").val().trim();
        const pw = $("#pw").val().trim();
        const pw2 = $("#pw2").val().trim();
        const name = $("#name").val().trim();
        const tel = $("#tel").val().trim();
        const email = $("#email").val().trim();
        // const postcode = $("#sample6_postcode").val().trim();
        const marketingYn = $("input[name='marketingYn']:checked").val();

        // 에러 초기화
        $("#idErrMsg, #pwErrMsg, #pwErrMsg2, #nameErrMsg, #telErrMsg, #emailErrMsg, #addrErrMsg").html("");

        if (!id) {
	        $("#idErrMsg").html("아이디를 입력해 주십시오.");
	        isValid = false;
	    } else if (!/^[A-Za-z0-9]{5,20}$/.test(id)) {
	        $("#idErrMsg").html("아이디는 영문과 숫자 조합 5~20자리만 가능합니다.");
	        isValid = false;
	    } else if (!idCheckDone) {
	        $("#idErrMsg").html("아이디 중복 검사를 해주십시오.");
	        isValid = false;
	    } else if (!canUseId) {
	        isValid = false;
	    }
        
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
        
        if (!name) {
            $("#nameErrMsg").html("이름을 입력해 주십시오.");
            isValid = false;
        }
        
		const telRaw = tel.replace(/-/g, "");
		if (tel) { // 입력이 있을 경우에만 검사
		    if (!/^\d{8,11}$/.test(telRaw)) {
		        $("#telErrMsg").html("전화번호는 숫자만 8~11자리 입력해 주십시오.");
		        isValid = false;
		    }
		}
        
        if (!email) {
            $("#emailErrMsg").html("이메일을 입력해 주십시오.");
            isValid = false;
        }
        
        /*if (!postcode) {
            $("#addrErrMsg").html("주소를 입력해 주십시오.");
            isValid = false;
        }
        
        if (!agree) {
            $("#agreeErrMsg").html("약관에 동의해 주십시오.");
            isValid = false;
        }*/

        if (isValid) {
        	if (!$("input[name='marketingYn']").is(":checked")) {
		        $("#joinFrm").append('<input type="hidden" name="marketingYn" value="N">');
		    }
		    
		    // 하이픈 제거
        	$("#tel").val($("#tel").val().replace(/-/g, ""));
		    
            this.submit();
        }
    });
});
