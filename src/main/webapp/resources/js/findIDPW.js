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