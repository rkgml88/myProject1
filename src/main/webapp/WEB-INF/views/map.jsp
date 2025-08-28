<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IN COFFEE | MAP</title>
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/map.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="resources/js/nav.js"></script>
</head>
<body>
	<!-- 카테고리 -->
    <jsp:include page="/WEB-INF/views/nav.jsp" />
    
    <section>
        <div id="banner">
            <h1>IN COFFEE</h1>
        </div>
        <div id="category">
            <h1>map</h1>
        </div>
        <div id="contain">
            <div id="main">     
                <div id="map"></div>
                <div id="bottomRow">
                    <div id="mapExplain">
                        <p><span class="blue">주소 | </span>울산 남구 삼산중로100번길 26, KM빌딩/ 1~4층</p>
                        <p><span class="blue">문의전화 | </span>123-4567-8910</p>
                        <p><span class="blue">카페 이용시간 | </span>매일 오전 10시~오후10시</p>
                    </div>
                    <div id="mapBtn">
                        <button id="navigationBtn">길찾기</button>
                        <button id="loadviewBtn">로드뷰</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- footer -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />
    
    <!-- 1. 카카오 지도 API 불러오기 -->
	<script type="text/javascript" 
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=18969b10a382e1848dfb925f9f2de757&autoload=false"></script>

	
	<!-- 2. 지도 띄우기 및 마커 표시 -->
	<script>
	window.kakaoAsyncInit = function() {
	    const destLat = 35.541924;
	    const destLng = 129.338237;
	    const destinationName = "그린컴퓨터아카데미 울산캠퍼스";
	
	    const container = document.getElementById('map');
	    const options = { center: new kakao.maps.LatLng(destLat, destLng), level: 2 };
	    const map = new kakao.maps.Map(container, options);
	
	    const marker = new kakao.maps.Marker({ position: new kakao.maps.LatLng(destLat, destLng) });
	    marker.setMap(map);
	
	    document.getElementById("navigationBtn").addEventListener("click", function() {
	        const url = "https://map.kakao.com/link/to/" 
	                  + encodeURIComponent(destinationName) + "," + destLat + "," + destLng;
	        window.open(url, '_blank');
	    });
	
	    document.getElementById("loadviewBtn").addEventListener("click", function() {
	        const url = "https://map.kakao.com/link/roadview/" + destLat + "," + destLng;
	        window.open(url, '_blank');
	    });
	};
	
	// SDK 로드 후 init 실행
	kakao.maps.load(kakaoAsyncInit);
	</script>



</body>
</html>