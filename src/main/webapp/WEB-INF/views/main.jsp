<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
    <title>IN COFFEE | INDUSTRIAL MOOD</title>
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/main.css">
    
    <script src="resources/js/nav.js"></script>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    
    
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
	<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script>
        $(document).ready(function(){
            
            // 자동 슬라이드 전환
            $('.mainImg').slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                autoplay: true,
                autoplaySpeed: 5000,       
            });

            // 네온 효과
            setInterval(function() {
                $("#exp1 h2").toggleClass("neon1");
            }, 1000);
            setInterval(function() {
                $("#exp1 span").toggleClass("neon2");
            }, 1000);
            setInterval(function() {
                $("#exp2 h2").toggleClass("neon3");
            }, 1000);
            setInterval(function() {
                $("#exp2 span").toggleClass("neon4");
            }, 1000);

        })
    </script>
</head>
<body>
    <div class="wrap">
        <!-- 카테고리 -->
        <jsp:include page="/WEB-INF/views/nav.jsp" />

        <section class="main">
        	<!-- 메인 이미지 -->
            <article class="row1">
            	<!-- 수정 버튼 -->
            	<sec:authorize access="hasRole('ROLE_ADMIN')">
            		<button class="edit" type="button" id="editMainBtn">수정</button>
            	</sec:authorize>
            	<!-- 모달 -->
				<div class="editModal" id="editMainModal">
				    <div class="editModalContent">
				        <h2>메인 이미지 & 문구 수정</h2>
				        
				        <label>메인 이미지1:</label>
						<img id="preview1" src="${mainContent.img1}" alt="이미지1" style="width:150px;height:auto;">
						<input type="file" id="fileInput1" accept="image/*"><br>
						<!-- 기존 경로 hidden -->
						<input type="hidden" id="existingImg1" value="${mainContent.img1}">
						<input type="text" id="title1" value="${mainContent.title1}" placeholder="캐치프라이즈1 상단">
						<input type="text" id="desc1" value="${mainContent.desc1}" placeholder="캐치프라이즈1 히단">
						<hr>
						
						<label>메인 이미지2:</label>
						<img id="preview2" src="${mainContent.img2}" alt="이미지2" style="width:150px;height:auto;">
						<input type="file" id="fileInput2" accept="image/*"><br>
						<!-- 기존 경로 hidden -->
						<input type="hidden" id="existingImg2" value="${mainContent.img2}">
						<input type="text" id="title2" value="${mainContent.title2}" placeholder="캐치프라이즈2 상단">
						<input type="text" id="desc2" value="${mainContent.desc2}" placeholder="캐치프라이즈2 히단">
				        <hr>
				        
				        <button class="save" id="saveMainBtn">저장</button>
				        <button class="close" id="closeMainBtn">취소</button>
				    </div>
				</div>
            	<div class="mainImg">
	                <div id="mainImg1">
	                    <!-- 슬라이드1 -->
	                    <img src="${mainContent.img1}" alt="메인 이미지1">
	                    <div class="overlay"><!-- 캐치프라이즈 -->
	                        <h1>${mainContent.title1}</h1>
	                        <p>${mainContent.desc1}</p>
	                    </div>
	                </div>
	                <div id="mainImg2">
	                    <!-- 슬라이드2 -->
	                    <img src="${mainContent.img2}" alt="메인 이미지2">
	                    <div class="overlay"><!-- 캐치프라이즈 -->
	                        <h1>${mainContent.title2}</h1>
	                        <p>${mainContent.desc2}</p>
	                    </div>
	                </div>
                </div>
            </article>
            <div class="banner">
                <img class="IM" src="resources/img/banner.png" alt="배너">
                <img class="IM" id="afterB" src="resources/img/banner.png" alt="배너">
            </div>
            
            <div class="section2">
        		<!-- 주력 메뉴 -->
                <article class="row2">
                	<!-- 수정 버튼 -->
                	<sec:authorize access="hasRole('ROLE_ADMIN')">
	            		<button class="edit" type="button" id="editSigBtn">수정</button>
	            	</sec:authorize>
	            	<!-- 모달 -->
					<div class="editModal" id="editSigModal">
					    <div class="editModalContent">
					        <h2>시그니처 이미지 & 문구 수정</h2>
					        
					        <label>시그니처 이미지:</label>
							<img id="sigpreview" src="${sigContent.img}" alt="시그니처 이미지" style="width:150px;height:auto;">
							<input type="file" id="sigfileInput" accept="image/*"><br>
							<!-- 기존 경로 hidden -->
							<input type="hidden" id="sigexistingImg" value="${sigContent.img}">
							<input type="text" id="sigtitle" value="${sigContent.title}" placeholder="시그니처 메뉴 이름">
							<input type="text" id="sigdesc" value="${sigContent.des}" placeholder="시그니처 메뉴 설명">
							<hr>
					        
					        <button class="save" id="saveSigBtn">저장</button>
					        <button class="close" id="closeSigBtn">취소</button>
					    </div>
					</div>
					<div id="sigImg">
	                    <div class="explain" id="exp1">
	            		<!-- 주력 메뉴 설명 -->
	                        <h2><span>signature |</span> ${sigContent.title}</h2>
	                        <p data-aos="fade-right" data-aos-duration="3000">
	                            ${sigContent.des}
	                        </p>
	                    </div>
	            		<!-- 주력 메뉴 이미지_우 -->
	                    <img data-aos="fade-left" data-aos-duration="3000" src="${sigContent.img}">
                    </div>
                </article>
        		<!-- 신메뉴 -->
                <article class="row3">
                	<!-- 수정 버튼 -->
                	<sec:authorize access="hasRole('ROLE_ADMIN')">
	            		<button class="edit" type="button" id="editNewBtn">수정</button>
	            	</sec:authorize>
	            	<!-- 모달 -->
					<div class="editModal" id="editNewModal">
					    <div class="editModalContent">
					        <h2>시그니처 이미지 & 문구 수정</h2>
					        
					        <label>시그니처 이미지:</label>
							<img id="newpreview" src="${newContent.img}" alt="신메뉴 이미지" style="width:150px;height:auto;">
							<input type="file" id="newfileInput" accept="image/*"><br>
							<!-- 기존 경로 hidden -->
							<input type="hidden" id="newexistingImg" value="${newContent.img}">
							<input type="text" id="newtitle" value="${newContent.title}" placeholder="신메뉴 이름">
							<input type="text" id="newdesc" value="${newContent.des}" placeholder="신메뉴 설명">
							<hr>
					        
					        <button class="save" id="saveNewBtn">저장</button>
					        <button class="close" id="closeNewBtn">취소</button>
					    </div>
					</div>
                	<div id="newImg">
	            		<!-- 신메뉴 이미지_좌 -->
	                    <img data-aos="fade-right" data-aos-delay="50" data-aos-duration="3000" src="${newContent.img}">
	            		<!-- 신메뉴 설명 -->
	                    <div class="explain" id="exp2">
	                        <h2>${newContent.title} <span>| new</span></h2>
	                        <p data-aos="fade-left" data-aos-delay="50" data-aos-duration="3000">
	                            ${newContent.des}
	                        </p>
	                    </div>
                    </div>
                </article>
            </div>
        	<!-- 디저트 -->
            <article class="row4">
                <h1 data-aos="flip-down" data-aos-delay="50">dessert</h1>
                <div class="dessertWrap">
                	<!-- 수정 버튼 -->
                	<sec:authorize access="hasRole('ROLE_ADMIN')">
	            		<button class="edit" type="button" id="editDessertBtn">수정</button>
	            	</sec:authorize>
	            	<!-- 모달 -->
					<div class="editModal" id="editDessertModal">
					    <div class="editModalContent">
					        <h2>디저트 이미지 & 이름 수정</h2>
					        
					        <label>디저트 이미지1:</label>
							<img id="previewDessert1" src="${dessertContent.img1}" alt="이미지1" style="width:150px;height:auto;">
							<input type="file" id="fileDessertInput1" accept="image/*"><br>
							<!-- 기존 경로 hidden -->
							<input type="hidden" id="existingDessertImg1" value="${dessertContent.img1}">
							<input type="text" id="titleDessert1" value="${dessertContent.title1}" placeholder="디저트 이름1">
							<hr>
							
							<label>디저트 이미지2:</label>
							<img id="previewDessert2" src="${dessertContent.img2}" alt="이미지2" style="width:150px;height:auto;">
							<input type="file" id="fileDessertInput2" accept="image/*"><br>
							<!-- 기존 경로 hidden -->
							<input type="hidden" id="existingDessertImg2" value="${dessertContent.img2}">
							<input type="text" id="titleDessert2" value="${dessertContent.title2}" placeholder="디저트 이름2">
					        <hr>
					        
					        <label>디저트 이미지3:</label>
							<img id="previewDessert3" src="${dessertContent.img3}" alt="이미지3" style="width:150px;height:auto;">
							<input type="file" id="fileDessertInput3" accept="image/*"><br>
							<!-- 기존 경로 hidden -->
							<input type="hidden" id="existingDessertImg3" value="${dessertContent.img3}">
							<input type="text" id="titleDessert3" value="${dessertContent.title3}" placeholder="디저트 이름3">
							<hr>
							
							<label>디저트 이미지4:</label>
							<img id="previewDessert4" src="${dessertContent.img4}" alt="이미지4" style="width:150px;height:auto;">
							<input type="file" id="fileDessertInput4" accept="image/*"><br>
							<!-- 기존 경로 hidden -->
							<input type="hidden" id="existingDessertImg4" value="${dessertContent.img4}">
							<input type="text" id="titleDessert4" value="${dessertContent.title4}" placeholder="디저트 이름4">
					        <hr>
					        
					        <label>디저트 이미지5:</label>
							<img id="previewDessert5" src="${dessertContent.img5}" alt="이미지5" style="width:150px;height:auto;">
							<input type="file" id="fileDessertInput5" accept="image/*"><br>
							<!-- 기존 경로 hidden -->
							<input type="hidden" id="existingDessertImg5" value="${dessertContent.img5}">
							<input type="text" id="titleDessert5" value="${dessertContent.title5}" placeholder="디저트 이름5">
							<hr>
					        
					        <button class="save" id="saveDessertBtn">저장</button>
					        <button class="close" id="closeDessertBtn">취소</button>
					    </div>
					</div>
                    <div data-aos="fade-up" data-aos-delay="500" class="dessert" id="dessertImg1">
                        <img id="scone" src="${dessertContent.img1}" alt="${dessertContent.title1}">
                        <div class="overlay2">
                            <p>${dessertContent.title1}</p>
                            <button><a href="dessert">more</a></button>
                        </div>
                    </div>
                    <div data-aos="fade-down" data-aos-delay="500" class="dessert" id="dessertImg2">
                        <img src="${dessertContent.img2}" alt="${dessertContent.title2}">
                        <div class="overlay2">
                            <p>${dessertContent.title2}</p>
                            <button><a href="dessert">more</a></button>
                        </div>
                    </div>
                    <div data-aos="fade-up" data-aos-delay="500" class="dessert" id="dessertImg3">
                        <img src="${dessertContent.img3}" alt="${dessertContent.title3}">
                        <div class="overlay2">
                            <p>${dessertContent.title3}</p>
                            <button><a href="dessert">more</a></button>
                        </div>
                    </div>
                    <div data-aos="fade-down" data-aos-delay="500" class="dessert" id="dessertImg4">
                        <img src="${dessertContent.img4}" alt="${dessertContent.title4}">
                        <div class="overlay2">
                            <p>${dessertContent.title4}</p>
                            <button><a href="dessert">more</a></button>
                        </div>
                    </div>
                    <div data-aos="fade-up" data-aos-delay="500" class="dessert" id="dessertImg5">
                        <img src="${dessertContent.img5}" alt="${dessertContent.title5}">
                        <div class="overlay2">
                            <p>${dessertContent.title5}</p>
                            <button><a href="dessert">more</a></button>
                        </div>
                    </div>
                </div>
            </article>
        </section>
        <!-- footer -->
        <jsp:include page="/WEB-INF/views/footer.jsp" />
    </div>

<script>
const token = document.querySelector('meta[name="_csrf"]').content;
const header = document.querySelector('meta[name="_csrf_header"]').content;

AOS.init({
    duration: 2000, // 애니메이션 지속 시간 (ms)
    easing: 'ease-in-out-back',
    once: false // 한 번만 실행
    
});

let selectedFiles = {};

//기존 값 저장 객체
let originalValues = {};

// 메인 배너 이미지 모달창
// 모달 열기 시 기존 값 저장
function enableEditMainModal() {
    // 텍스트 input 값 저장
    originalValues['title1'] = document.getElementById('title1').value;
    originalValues['desc1'] = document.getElementById('desc1').value;
    originalValues['title2'] = document.getElementById('title2').value;
    originalValues['desc2'] = document.getElementById('desc2').value;

    // 이미지 src 저장
    originalValues['img1'] = document.getElementById('preview1').src;
    originalValues['img2'] = document.getElementById('preview2').src;

    // 모달 열기
    document.getElementById('editMainModal').style.display = 'flex';
}

// 취소 시 기존 값 복원
function cancelEditMainModal() {
    // 텍스트 input 값 복원
    document.getElementById('title1').value = originalValues['title1'];
    document.getElementById('desc1').value = originalValues['desc1'];
    document.getElementById('title2').value = originalValues['title2'];
    document.getElementById('desc2').value = originalValues['desc2'];

    // 이미지 src 복원
    document.getElementById('preview1').src = originalValues['img1'];
    document.getElementById('preview2').src = originalValues['img2'];

    // 파일 input 초기화
    document.getElementById('fileInput1').value = "";
    document.getElementById('fileInput2').value = "";

    // 모달 닫기
    document.getElementById('editMainModal').style.display = 'none';
}

// 이미지 미리보기
document.getElementById('fileInput1').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('preview1').src = URL.createObjectURL(file);
});

document.getElementById('fileInput2').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('preview2').src = URL.createObjectURL(file);
});

// 버튼 이벤트 연결
document.getElementById('editMainBtn').addEventListener('click', enableEditMainModal);
document.getElementById('closeMainBtn').addEventListener('click', cancelEditMainModal);

// 저장 버튼 클릭 시 서버 업로드
document.getElementById("saveMainBtn").addEventListener("click", function () {
    const formData = new FormData();
    const file1 = document.getElementById("fileInput1").files[0];
    const file2 = document.getElementById("fileInput2").files[0];
    
    if (file1) {
        formData.append("mainImg1", file1);
    } else {
        formData.append("existingImg1", document.getElementById("existingImg1").value);
    }

    if (file2) {
        formData.append("mainImg2", file2);
    } else {
        formData.append("existingImg2", document.getElementById("existingImg2").value);
    }

    formData.append("title1", document.getElementById("title1").value);
    formData.append("desc1", document.getElementById("desc1").value);
    formData.append("title2", document.getElementById("title2").value);
    formData.append("desc2", document.getElementById("desc2").value);

    fetch("/updateMainContent", {
        method: "POST",
        headers: {
            [header]: token // CSRF 토큰
        },
        body: formData
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {
            location.reload();
        } else {
            alert("업데이트 실패");
        }
    })
    .catch(err => console.error("업로드 실패:", err));
});

// 시그니처 메뉴 모달창
// 모달 열기 시 기존 값 저장
function enableEditSigModal() {
    // 텍스트 input 값 저장
    originalValues['sigtitle'] = document.getElementById('sigtitle').value;
    originalValues['sigdesc'] = document.getElementById('sigdesc').value;

    // 이미지 src 저장
    originalValues['sigimg'] = document.getElementById('sigpreview').src;
    // 모달 열기
    document.getElementById('editSigModal').style.display = 'flex';
}

// 취소 시 기존 값 복원
function cancelEditSigModal() {
    // 텍스트 input 값 복원
    document.getElementById('sigtitle').value = originalValues['sigtitle'];
    document.getElementById('sigdesc').value = originalValues['sigdesc'];

    // 이미지 src 복원
    document.getElementById('sigpreview').src = originalValues['sigimg'];

    // 파일 input 초기화
    document.getElementById('sigfileInput').value = "";

    // 모달 닫기
    document.getElementById('editSigModal').style.display = 'none';
}

// 이미지 미리보기
document.getElementById('sigfileInput').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('sigpreview').src = URL.createObjectURL(file);
});

// 버튼 이벤트 연결
document.getElementById('editSigBtn').addEventListener('click', enableEditSigModal);
document.getElementById('closeSigBtn').addEventListener('click', cancelEditSigModal);

// 저장 버튼 클릭 시 서버 업로드
document.getElementById("saveSigBtn").addEventListener("click", function () {
    const sigformData = new FormData();
    const sigfile = document.getElementById("sigfileInput").files[0];
    
    if (sigfile) {
    	sigformData.append("sigImg", sigfile);
    } else {
    	sigformData.append("sigexistingImg", document.getElementById("sigexistingImg").value);
    }

    sigformData.append("sigtitle", document.getElementById("sigtitle").value);
    sigformData.append("sigdesc", document.getElementById("sigdesc").value);

    fetch("/updateSigContent", {
        method: "POST",
        headers: {
            [header]: token // CSRF 토큰
        },
        body: sigformData
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {
            location.reload();
        } else {
            alert("업데이트 실패");
        }
    })
    .catch(err => console.error("업로드 실패:", err));
});

// 신메뉴 모달창
//모달 열기 시 기존 값 저장
function enableEditNewModal() {
 // 텍스트 input 값 저장
 originalValues['newtitle'] = document.getElementById('newtitle').value;
 originalValues['newdesc'] = document.getElementById('newdesc').value;

 // 이미지 src 저장
 originalValues['newimg'] = document.getElementById('newpreview').src;
 // 모달 열기
 document.getElementById('editNewModal').style.display = 'flex';
}

//취소 시 기존 값 복원
function cancelEditNewModal() {
 // 텍스트 input 값 복원
 document.getElementById('newtitle').value = originalValues['newtitle'];
 document.getElementById('newdesc').value = originalValues['newdesc'];

 // 이미지 src 복원
 document.getElementById('newpreview').src = originalValues['newimg'];

 // 파일 input 초기화
 document.getElementById('newfileInput').value = "";

 // 모달 닫기
 document.getElementById('editNewModal').style.display = 'none';
}

//이미지 미리보기
document.getElementById('newfileInput').addEventListener('change', function() {
 const file = this.files[0];
 if (file) document.getElementById('newpreview').src = URL.createObjectURL(file);
});

//버튼 이벤트 연결
document.getElementById('editNewBtn').addEventListener('click', enableEditNewModal);
document.getElementById('closeNewBtn').addEventListener('click', cancelEditNewModal);

//저장 버튼 클릭 시 서버 업로드
document.getElementById("saveNewBtn").addEventListener("click", function () {
 const newformData = new FormData();
 const newfile = document.getElementById("newfileInput").files[0];
 
 if (newfile) {
	 newformData.append("newImg", newfile);
 } else {
	 newformData.append("newexistingImg", document.getElementById("newexistingImg").value);
 }

 newformData.append("newtitle", document.getElementById("newtitle").value);
 newformData.append("newdesc", document.getElementById("newdesc").value);

 fetch("/updateNewContent", {
     method: "POST",
     headers: {
         [header]: token // CSRF 토큰
     },
     body: newformData
 })
 .then(res => res.json())
 .then(data => {
     if (data.status === "success") {
         location.reload();
     } else {
         alert("업데이트 실패");
     }
 })
 .catch(err => console.error("업로드 실패:", err));
});

// 디저트 모달창
// 모달 열기 시 기존 값 저장
function enableEditDessertModal() {
    // 텍스트 input 값 저장
    originalValues['titleDessert1'] = document.getElementById('titleDessert1').value;
    originalValues['titleDessert2'] = document.getElementById('titleDessert2').value;
    originalValues['titleDessert3'] = document.getElementById('titleDessert3').value;
    originalValues['titleDessert4'] = document.getElementById('titleDessert4').value;
    originalValues['titleDessert5'] = document.getElementById('titleDessert5').value;

    // 이미지 src 저장
    originalValues['imgDessert1'] = document.getElementById('previewDessert1').src;
    originalValues['imgDessert2'] = document.getElementById('previewDessert2').src;
    originalValues['imgDessert3'] = document.getElementById('previewDessert3').src;
    originalValues['imgDessert4'] = document.getElementById('previewDessert4').src;
    originalValues['imgDessert5'] = document.getElementById('previewDessert5').src;

    // 모달 열기
    document.getElementById('editDessertModal').style.display = 'flex';
}

// 취소 시 기존 값 복원
function cancelEditDessertModal() {
    // 텍스트 input 값 복원
    document.getElementById('titleDessert1').value = originalValues['titleDessert1'];
    document.getElementById('titleDessert2').value = originalValues['titleDessert2'];
    document.getElementById('titleDessert3').value = originalValues['titleDessert3'];
    document.getElementById('titleDessert4').value = originalValues['titleDessert4'];
    document.getElementById('titleDessert5').value = originalValues['titleDessert5'];

    // 이미지 src 복원
    document.getElementById('previewDessert1').src = originalValues['imgDessert1'];
    document.getElementById('previewDessert2').src = originalValues['imgDessert2'];
    document.getElementById('previewDessert3').src = originalValues['imgDessert3'];
    document.getElementById('previewDessert4').src = originalValues['imgDessert4'];
    document.getElementById('previewDessert5').src = originalValues['imgDessert5'];

    // 파일 input 초기화
    document.getElementById('fileDessertInput1').value = "";
    document.getElementById('fileDessertInput2').value = "";
    document.getElementById('fileDessertInput3').value = "";
    document.getElementById('fileDessertInput4').value = "";
    document.getElementById('fileDessertInput5').value = "";

    // 모달 닫기
    document.getElementById('editDessertModal').style.display = 'none';
}

// 이미지 미리보기
document.getElementById('fileDessertInput1').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('previewDessert1').src = URL.createObjectURL(file);
});

document.getElementById('fileDessertInput2').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('previewDessert2').src = URL.createObjectURL(file);
});

document.getElementById('fileDessertInput3').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('previewDessert3').src = URL.createObjectURL(file);
});

document.getElementById('fileDessertInput4').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('previewDessert4').src = URL.createObjectURL(file);
});

document.getElementById('fileDessertInput5').addEventListener('change', function() {
    const file = this.files[0];
    if (file) document.getElementById('previewDessert5').src = URL.createObjectURL(file);
});

// 버튼 이벤트 연결
document.getElementById('editDessertBtn').addEventListener('click', enableEditDessertModal);
document.getElementById('closeDessertBtn').addEventListener('click', cancelEditDessertModal);

// 저장 버튼 클릭 시 서버 업로드
document.getElementById("saveDessertBtn").addEventListener("click", function () {
    const formData = new FormData();
    const file1 = document.getElementById("fileDessertInput1").files[0];
    const file2 = document.getElementById("fileDessertInput2").files[0];
    const file3 = document.getElementById("fileDessertInput3").files[0];
    const file4 = document.getElementById("fileDessertInput4").files[0];
    const file5 = document.getElementById("fileDessertInput5").files[0];
    
    if (file1) {
        formData.append("dessertImg1", file1);
    } else {
        formData.append("existingDessertImg1", document.getElementById("existingDessertImg1").value);
    }

    if (file2) {
        formData.append("dessertImg2", file2);
    } else {
        formData.append("existingDessertImg2", document.getElementById("existingDessertImg2").value);
    }
    
    if (file3) {
        formData.append("dessertImg3", file3);
    } else {
        formData.append("existingDessertImg3", document.getElementById("existingDessertImg3").value);
    }

    if (file4) {
        formData.append("dessertImg4", file4);
    } else {
        formData.append("existingDessertImg4", document.getElementById("existingDessertImg4").value);
    }
    
    if (file5) {
        formData.append("dessertImg5", file5);
    } else {
        formData.append("existingDessertImg5", document.getElementById("existingDessertImg5").value);
    }

    formData.append("titleDessert1", document.getElementById("titleDessert1").value);
    formData.append("titleDessert2", document.getElementById("titleDessert2").value);
    formData.append("titleDessert3", document.getElementById("titleDessert3").value);
    formData.append("titleDessert4", document.getElementById("titleDessert4").value);
    formData.append("titleDessert5", document.getElementById("titleDessert5").value);

    fetch("/updateDessertContent", {
        method: "POST",
        headers: {
            [header]: token // CSRF 토큰
        },
        body: formData
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {
            location.reload();
        } else {
            alert("업데이트 실패");
        }
    })
    .catch(err => console.error("업로드 실패:", err));
});

</script>
</body>
</html>