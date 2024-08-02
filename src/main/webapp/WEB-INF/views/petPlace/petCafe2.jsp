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
	
	    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
	    .wrap * {padding: 0;margin: 0;}
	    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
	    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
	    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
	    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
	    .info .close:hover {cursor: pointer;}
	    .info .body {position: relative;overflow: hidden;}
	    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
	    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
	    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
	    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
	    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	    .info .link {color: #5085BB;}
	    
	    .mapSec{
	    	float : left;
	    	width:50%;
	    	height:500px;
	    }
	</style>
	<script>
    //'use strict';
    
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div id="map" class="mapSec"></div>
		<div>
			멤버 정보 불러오기
		</div>
	</div>
	
	<!-- 카카오맴 자바스크립트 AIP -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bed81139daac8fd06f75e2c669b1570&libraries=clusterer"></script>
	<script>
	
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	//var infowindow = new kakao.maps.InfoWindow({zIndex:99});
     
    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
         center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
         level : 10 // 지도의 확대 레벨 
    });
     
    // 마커 클러스터러를 생성합니다 
    /* 
    var clusterer = new kakao.maps.MarkerClusterer({
    	map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 10, // 클러스터 할 최소 지도 레벨 
       // disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
    });
     */
    // 데이터를 가져오기 위해 jQuery를 사용합니다
    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
    var vos = ${jsonVos}
    
	/* 
    vos.forEach(function(position) {
	    var latlng = new kakao.maps.LatLng(position.latitude, position.longitude);
	    var marker = new kakao.maps.Marker({
		    map: map,
		    position: latlng,
		    title: position.placeName + "\n" + position.lnmAddress
	    });
    });
     */
    var clusterer = new kakao.maps.MarkerClusterer({
	    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
	    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
	    minLevel: 10 // 클러스터 할 최소 지도 레벨
    });
 

    var markers = $(vos).map(function(i, position) {
	    return new kakao.maps.Marker({
		    position : new kakao.maps.LatLng(position.latitude, position.longitude),
		    title : position.placeName + "\n" + position.lnmAddress
	    });
    });
    
    
    
   
	// 데이터에서 좌표 값을 가지고 마커를 표시합니다
	// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	
		/* 
	var markers = $(vos).map(function(i, position) {
		return new kakao.maps.Marker({
			position : new kakao.maps.LatLng(position.latitude, position.longitude),
			title : position.placeName +"\n"+ position.lnmAddress
			//title : content
		});
		var overlay = new kakao.maps.CustomOverlay({
		    content: content,
		    map: map,
		    position: new kakao.maps.LatLng(position.latitude, position.longitude)
		});
		kakao.maps.event.addListener(markers, 'click', function() {
		    overlay.setMap(map);
		});
	});
		 */
	
	// 클러스터러에 마커들을 추가합니다
	clusterer.addMarkers(markers);
	
	

	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
	/* 
	function closeOverlay() {
	    overlay.setMap(null);     
	}
	 */
	</script>
	
	
	
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>