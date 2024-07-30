<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>petCafe.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="icon" href="${ctp}/resources/favicon/love.png">
	
	<!-- swiper link -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

	<!-- 구글폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap');
	</style>
		
	<style>
		* {font-family: 'Noto Sans KR', sans-serif;}
		a {text-decoration: none; color: inherit;}
		a:link {text-decoration: none;}
		/* p {margin:0;} */
		.inner {width : 1300px; margin : 0 auto; padding-top:150px;}
		.sec-boxStyle{
			background-color : #f9f9f9;
			border-radius : 30px;
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
		}
	</style>
	<script>
    //'use strict';
    
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div id="map" style="width:100%;height:500px;"></div>
	</div>
	
	<!-- 카카오맴 자바스크립트 AIP -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bed81139daac8fd06f75e2c669b1570&libraries=clusterer"></script>
	<script>
     
     var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
         center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
         level : 10 // 지도의 확대 레벨 
     });
     
     // 마커 클러스터러를 생성합니다 
     var clusterer = new kakao.maps.MarkerClusterer({
         map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
         averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
         minLevel: 10 // 클러스터 할 최소 지도 레벨 
     });
  
     // 데이터를 가져오기 위해 jQuery를 사용합니다
     // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
     var vos = ${jsonVos}
     console.log(vos);
	// 데이터에서 좌표 값을 가지고 마커를 표시합니다
	// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	var markers = $(vos).map(function(i, position) {
	return new kakao.maps.Marker({
		position : new kakao.maps.LatLng(position.latitude, position.longitude)
		});
	});

	// 클러스터러에 마커들을 추가합니다
	clusterer.addMarkers(markers);
     
     
	</script>
	
	
	
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>