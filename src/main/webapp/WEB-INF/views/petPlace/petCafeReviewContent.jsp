<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>petCafeReviwContent.jsp</title>
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
		button {
		    border: none;
		    background-color: transparent;
		}
	    
	    input::placeholder{color:#ddd !important;font-size: 14px !important;}
		input#address, #addressPick{
		    border-radius: 50px;
	        height: 40px;
	        padding: 0 22px;
		    font-size: 15px;
		    color: #333;
		}
		label{
			padding-left: 5px;
		    color: #666;
		    font-size: 14px;
		}
		span#addressTxt:hover {
		    cursor: pointer;
		    color: #578de4;
	    }
	    .addressReSearchBtn{
		    border-radius: 50px;
		    border: none;
		    color: #fff;
	    	background-color: #777;
		    padding: 7px 20px;
		    margin-left: 10px;
	    	font-size: 13px;
	    	width : 140px;
	    }
	    .addressSearchBtn{
		    background-color: #578de4;
		    border-radius: 50px;
		    border: none;
		    color: #fff;
		    padding: 7px 20px;
		    margin-left: 10px;
	    	font-size: 13px;
	    	width : 140px;
		}
		.addressReSearchBtn:hover {background-color: #666;}
		.addressSearchBtn:hover {background-color: #3478db;}
		
		.cafeInfoSec{
	    	float : left;
	    	width:35%;
	    	margin-right: 2%;
	    	border-radius: 20px;
	    	margin-bottom: 30px;
	    	/* border: solid 5px #578de4; */
    		/* box-shadow: 10px 14px 14px rgba(0, 0, 50, 0.1); */
	    }
		.mapSec{
	    	width:100%;
	    	height:400px;
	    	border-radius: 20px 20px 0 0;
	    }
	    .infoSec{
	    	width:100%;
	    	border-radius: 0 0 20px 20px;
	    	padding: 30px;
	    	background-color: #f9f9f9;
	    }
		.ReviewContentSec{
			float : left;
	    	width:63%;
	    	border-radius: 30px;
	    	margin-bottom: 30px;
	    	background-color: #f9f9f9;
    		padding : 30px;
	    	/* border: solid 5px #578de4; */
    		/* box-shadow: 10px 14px 14px rgba(0, 0, 50, 0.1); */
		}
	</style>
	<script>
    	'use strict';
    
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div class="cafeInfoSec">
			<div id="map" class="mapSec"></div>
			<%-- 
			<section class="infoSec" onclick="location.href='petCafeReviewContent?idx=${vo.idx}';">
				<p>${cafeVO.placeName}<span>${cafeVO.category} • ${cafeVO.placeInfo}</span></p>
				<p>방문자후기 0 • 찜 0</p>
				<p>${cafeVO.rdnmAddress}</p>
				<p>영업시간 <span>${cafeVO.openTime}</span></p>
				<p>휴무 <span>${cafeVO.closedDay}</span></p>
				<p>${cafeVO.homePage}</p>
			</section>
			 --%>
		</div>
		
		<div class="ReviewContentSec">
			<section>
				<p><img src="${ctp}/resources/data/member/${vo.photo}" style="width:50px;height:50px;object-fit:cover;border-radius: 50px;"/>${vo.nickName} · ${(vo.uploadDate).substring(0,10)}</p>
				<p>${vo.title}</p>
				<hr/>
			</section>
		</div>
		
	</div><!-- inner 끝 -->
	<%-- 
	<input type="hidden" id="placeName" value="${cafeVO.placeName}"/>
	<input type="hidden" id="rdnmAddress" value="${cafeVO.rdnmAddress}"/>
	<input type="hidden" id="latitude" value="${cafeVO.latitude}"/>
	<input type="hidden" id="longitude" value="${cafeVO.longitude}"/>
	 --%>
	<!-- 카카오맴 자바스크립트 AIP -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bed81139daac8fd06f75e2c669b1570"></script>
	<script>
	
		var placeName = document.getElementById('placeName').value;
		var rdnmAddress = document.getElementById('rdnmAddress').value;
		var latitude = document.getElementById('latitude').value;
		var longitude = document.getElementById('longitude').value;
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		var iwContent = '<div class="infoWin" style="height:135px;border-radius: 20px;">' +
							'<section style="background-color:#578de4;padding:20px 20px 5px;"><p style="font-size:18px;color:#fff;"><b>'+ placeName + '</b></p></section>' +
							'<section style="padding:10px 20px;"><p style="font-size:13px;">'+ rdnmAddress + '</p></section>' +
						'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다
		
		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker); 
		
	</script>
	
	
	
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>