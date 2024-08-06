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
	    
	    /* ==================================================================================== */
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
		
		/* ======================================================================== */
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
		.returnVisitOK, .returnVisitNO{
			margin-left: 10px;
		    border-radius: 50px;
		    border: solid 1px #578de4;
		    padding: 5px 18px;
		    color: #578de4;
		    font-size: 14px;
    		font-weight: 500;
    		letter-spacing: -1px;
		}
		.friend{
		    border-radius: 50px;
		    border: solid 1px #EB403D;
		    padding: 3px 12px;
		    color: #EB403D;
		    font-size: 14px;
    		font-weight: 600;
    		background: transparent;
		}
		.backBtn{
			width: 100%;
		    background-color: #bdbdbd;
		    border: none;
		    height: 40px;
		    border-radius: 20px;
		    color: #fff;
		    font-size: 16px;
		    margin-top: 16px;
		}
		.backBtn:hover {background-color: #666;}
	</style>
	<script>
    	'use strict';
    
    	function cafeReviewDelete() {
    		let ans = confirm("해당 카페 리뷰를 삭제 하시겠습니까?");
        	if(ans) location.href = "cafeReviewDelete?idx=${vo.idx}&placeIdx=${cafeVO.idx}";
		}
    	
    	function wishPickBtn(placeIdx) {
    		if (${empty sLevel}) {
        		alert("로그인 후 이용가능합니다.");
        		return false;
        	}
    		$.ajax({
    			url : "${ctp}/petPlace/wishPlaceSave",
    			type : "post",
    			data : {placeIdx : placeIdx, part : "cafe"},
    			success : function(res) {
    				if(res != 0){
    					alert("찜한 목록에 추가되었습니다!");
    					location.reload();
    				}
    				else {
    					let ans = confirm("이미 찜한 목록에 추가되었습니다.\n찜한 목록에서 삭제하시겠습니까?");
    			    	if(ans){
    						$.ajax({
    							url : "${ctp}/petPlace/wishPlaceDelete",
    							type : "post",
    							data : {placeIdx : placeIdx, part : "cafe"},
    							success : function(res) {
    								if(res != "0") {
    									alert("해당장소가 찜한 목록에서 삭제되었습니다.");
    									location.reload();
    								}
    								else alert("찜삭제처리실패");
    							},
    							error : function() {
    								alert("전송오류");
    							}
    						});
    			    	}
    				}
    			},
    			error : function() {
    				alert("전송오류");
    			}
    		});
    	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div class="cafeInfoSec">
			<div id="map" class="mapSec"></div>
			<section class="infoSec">
				<p style="font-size: 22px;font-weight: 600; color: #333;">${cafeVO.placeName}<span style="font-weight: 500;font-size: 15px;color: #8b8b8b;margin-left: 5px;">${cafeVO.category} · ${cafeVO.placeInfo}</span></p>
				<c:if test="${empty sWishPlace}"><p>방문자후기 0 • 찜 <button onclick="wishPickBtn(${cafeVO.idx})"><img src="${ctp}/resources/images/icon/love-3.png" style="width:30px;"/></button> 0</p></c:if>
				<c:if test="${!empty sWishPlace}"><p>방문자후기 0 • 찜 <button onclick="wishPickBtn(${cafeVO.idx})"><img src="${ctp}/resources/images/icon/love.png" style="width:30px;"/></button> 0</p></c:if>
				<hr/>
				<p><img src="${ctp}/resources/images/icon/place.png" style="width:20px;margin:0 10px 4px 0;"/>${cafeVO.rdnmAddress}</p>
				<p><img src="${ctp}/resources/images/icon/clock.png" style="width:20px;margin:0 10px 4px 0;"/><span style="font-size:16px;font-weight:600;margin-right: 5px;">영업시간 </span>${cafeVO.openTime}</p>
				<p><img src="${ctp}/resources/images/icon/information.png" style="width:20px;margin:0 10px 4px 0;"/><span style="font-size:16px;font-weight:600;margin-right: 5px;">휴무 </span>${cafeVO.closedDay}</p>
				<p><img src="${ctp}/resources/images/icon/home.png" style="width:20px;margin:0 10px 4px 0;"/><a href="${cafeVO.homePage}" style="color:#578de4;">${cafeVO.homePage}</a></p>
				<input type="button" value="돌아가기" onclick="location.href='petCafeReviewList?idx=${cafeVO.idx}';" class="backBtn" />
			</section>
		</div>
		
		<div class="ReviewContentSec">
			<section>
				<p>
					<img src="${ctp}/resources/data/member/${vo.photo}" style="width:50px;height:50px;object-fit:cover;border-radius: 50px;"/>
					<span style="font-size:16px;font-weight:600;margin-left: 15px;">${vo.nickName}</span> · <span style="font-size:14px;color:#999;margin-right: 20px;">${(vo.uploadDate).substring(0,10)}</span>
					<c:if test="${sMid != vo.mid}"><button class="friend">친구맺기</button></c:if>
					<c:if test="${sMid == vo.mid}">
						<button class="friend" onclick="location.href='petCafeReviewUpdate?idx=${vo.idx}&placeIdx=${cafeVO.idx}';">리뷰수정</button>
						<button class="friend" onclick="cafeReviewDelete()">리뷰삭제</button>
					</c:if>
				</p>
				<hr/>
				<p style="font-size: 20px;font-weight: 500;padding-left: 15px;margin: 25px 0 25px;letter-spacing: -1px;">${vo.title} 
					<c:if test="${vo.returnVisit=='다음에 또 올꺼에요'}"><span class="returnVisitOK">다음에 또 올꺼에요 <img src="${ctp}/resources/images/icon/heartface-emoji.png" style="width:20px;margin-bottom:4px;"/></span></c:if>
					<c:if test="${vo.returnVisit=='재방문은 고민중이에요'}"><span class="returnVisitNO">재방문은 고민중이에요 <img src="${ctp}/resources/images/icon/thinking-face.png" style="width:20px;margin-bottom:4px;"/></span></c:if>
				</p>
				<section style="background-color:#ffffffcf;border-radius: 10px;padding: 15px 30px;">
					<p>${vo.content}</p>
				</section>
			</section>
		</div>
		
	</div><!-- inner 끝 -->
	<div class="insertNav" style="bottom: 100px; right: 90px; position: fixed;">
		<section onclick="location.href='petCafeReviewInsert?placeIdx=${cafeVO.idx}';"><img src="${ctp}/resources/images/icon/insertBtn.png" style="margin-bottom:10px;width:80px;cursor:pointer;"/></section>
		<section><a href="#"><img src="${ctp}/resources/images/icon/topBtn.png" style="width:80px;"/></a></section>
	</div>
	<input type="hidden" id="placeName" value="${cafeVO.placeName}"/>
	<input type="hidden" id="rdnmAddress" value="${cafeVO.rdnmAddress}"/>
	<input type="hidden" id="latitude" value="${cafeVO.latitude}"/>
	<input type="hidden" id="longitude" value="${cafeVO.longitude}"/>
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