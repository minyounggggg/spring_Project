<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hospital.jsp</title>
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
	    
	    .mapSec{
	    	float : left;
	    	width:50%;
	    	height:500px;
	    	border-radius: 30px;
	    	border: solid 5px #578de4;
	    	margin-bottom: 30px;
    		/* box-shadow: 10px 14px 14px rgba(0, 0, 50, 0.1); */
	    }
	    .mapSearchSec{float:left; width:50%; padding:30px;}
	    
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
	    .addressSearchBtn, .cafeReviewBtn{
		    background-color: #578de4;
		    border-radius: 50px;
		    border: none;
		    color: #fff;
		    padding: 7px 20px;
		    margin-left: 10px;
	    	font-size: 13px;
	    	width : 140px;
		}
		.cafeReviewBtn {margin:0 10px 0 0;}
		.addressSearchBtn:hover {background-color: #3478db;}
		.cafeReviewBtn:hover {background-color: #3478db;}
		
		.cafeInfoSec{
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
			clear: both;
			width: 100%;
			padding: 40px 35px 20px;
			margin: 30px 0;
			background-color: #f9f9f9;
			border-radius: 30px;
		}
		p.placePick {
		    border: dashed 2px #ededed;
		    border-radius: 20px;
		    height: 354px;
		    padding: 30px;
		    color: #999999;
		}
	</style>
	<script>
    'use strict';
    
	let addressSw = 0;
	
	
    
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div id="map" class="mapSec"></div>
		
		<div class="mapSearchSec">
			<div class="form-group">
			    <label for="address"><span style="color:#578de4"><b>* </b></span>현재 내 활동지역 주변으로 설정되어있습니다. 원하는 동네를 검색해보세요!<span style="color:#888;font-size:12px;"><br/>(장소가 뜨지 않을시 좀 더 정확하게 입력해주세요 ex.서울특별시 강남구 압구정동)</span></label>
			    <div class="input-group" style="margin-bottom: 25px;">
				    <input type="text" class="form-control address" value="${memberVO.address}" id="address" placeholder="동네를 입력해주세요. (ex.압구정, 사창동, 군위읍, 죽암리 ...)" name="address" required />
				    <div class="input-group-prepend">
				    	<input type="button" value="주소검색" id="addressSearchBtn" class="addressSearchBtn" onclick="addressSearch()" />	
				    </div>
				</div>
		    </div>
			<div id="cafeReviewMore">
				<p class="placePick">#원하는 장소의 마커를 클릭해 해당장소의 상세정보와 다양한 후기를 둘러보세요</p>
			</div>
		</div>
		
		<div id="demo"></div>
		
		<div id="plz">
			<c:forEach var="vo" items="${vos}">
				<p>${vo.idx}</p>
			</c:forEach>
		</div>
	</div>
	
	<!-- 카카오맴 자바스크립트 AIP -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4bed81139daac8fd06f75e2c669b1570&libraries=services"></script>
	<script>
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.51246004256557, 127.10287209239357), // 지도의 중심좌표
	        level: 6 // 지도의 확대 레벨
	    };
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		//var points=[];
		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	    //var bounds = new kakao.maps.LatLngBounds();
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		var memberAddressStr = document.getElementById("address").value;
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(memberAddressStr, function(result, status) {
		    // 정상적으로 검색이 완료됐으면 
		    if (status === kakao.maps.services.Status.OK) {
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});
		
		function addressSearch() {
			var searchString = document.getElementById("address").value;
			if(searchString.trim()==""){
				alert("검색어를 입력해주세요");
				document.getElementById("address").focus();
				return false;
			}
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(searchString, function(result, status) {
			
			    // 정상적으로 검색이 완료됐으면 
			    if (status === kakao.maps.services.Status.OK) {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});
		}
		  
		var vos = ${jsonVos};
		
		// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
		vos.forEach(function(position) {
			
			var imageSrc = '${ctp}/resources/images/icon/petCafeIcon.png', // 마커이미지의 주소입니다    
		    imageSize = new kakao.maps.Size(35, 35), // 마커이미지의 크기입니다
		    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		      
		    var latlng = new kakao.maps.LatLng(position.latitude, position.longitude);
			/* 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다 */
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
			    markerPosition = latlng; // 마커가 표시될 위치입니다
			    
			    
			// points 배열에 좌표 추가
            //points.push(new kakao.maps.LatLng(position.latitude, position.longitude));

            // LatLngBounds 객체에 좌표를 추가합니다
            //bounds.extend(points[position.idx]);
			    
	
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition, 
			    image: markerImage // 마커이미지 설정 
			});
			marker.setMap(map);
		     
		 	// 마커에 표시할 인포윈도우를 생성합니다 
		    var infowindow = new kakao.maps.InfoWindow({
		    	// 인포윈도우에 표시할 내용
		        content: '<div class="infoWin" style="height:135px;border-radius: 20px;">' +
		        			'<section style="background-color:#578de4;padding:20px 20px 5px;"><p style="font-size:18px;color:#fff;"><b>'+ position.placeName + '</b></p></section>' +
		        			'<section style="padding:10px 20px;"><p style="font-size:13px;">'+ position.rdnmAddress + '</p></section>' +
		        		 '</div>' 
		    });

		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		    
		    var parkingCheck = position.parking == "Y" ? "주차가능":"주차어려움";
		    
		    kakao.maps.event.addListener(marker, 'click', function() {
		    	//console.log(miniViewVos);
			    // 마커클릭이벤트
		    	document.getElementById("demo").innerHTML = 
		    		'<div class="cafeInfoSec">' +
		    			'<p style="font-size: 25px;font-weight: 600;color: #333333;">' + position.placeName + '<span style="margin-left: 5px;font-size: 17px;font-weight: 500;color: #939396;"> '+position.category+' • '+position.placeInfo+'</span></p>' + 
		    			'<p style="margin-bottom: 30px;">방문자후기 0 • 찜 0</p>'+
		    			'<hr/>'+
		    			'<div>'+
		    				'<section style="float:left;width:33%;border-right: solid 1px #dbdbdb;padding-right: 20px;text-align: center;">' +
		    					'<p style="margin-bottom: 0;font-size: 16px;font-weight: 700;color: #999;">주차</p><p>' + 
		    					'<p style="margin-bottom: 0;font-weight: 600;font-size: 20px;">'+ parkingCheck +'</p>' +
		    					
		    				'</p></section>' +
		    				'<section style="float:left;width:33%;border-right: solid 1px #dbdbdb;padding-right: 20px;text-align: center;">' +
		    					'<p style="margin-bottom: 10px;font-size: 16px;font-weight: 700;color: #999;">찜</p>' + 
		    					'<button><img src="${ctp}/resources/images/icon/love.png" style="width:30px;"/></button>' +
		    				'</section>' +
		    				'<section style="float:left;width:33%;text-align: center;">' +
		    					'<p style="margin-bottom: 10px;font-size: 16px;font-weight: 700;color: #999;">반려동물 크기 제한</p>' + 
		    					'<p style="margin-bottom: 0;font-weight: 600;font-size: 20px;">' + position.petSize + '</p>' +
		    				'</section>' +
		    			'</div>'+
		    			'<hr style="clear:both;"/>'+
		    			'<section style="background-color:#ebebeb;padding:10px;border-radius:10px;margin-bottom:10px;"><img src="${ctp}/resources/images/icon/information.png" style="width:20px;margin:0 10px 2px 0;"/><span>매장별 변동사항이 있을 수 있습니다.</span></section>'+
		    			'<section style="padding:10px">'+
			    			'<p><img src="${ctp}/resources/images/icon/place.png" style="width:20px;margin:0 10px 4px 0;"/>'+position.rdnmAddress+'</p>'+
			    			'<p><img src="${ctp}/resources/images/icon/clock.png" style="width:20px;margin:0 10px 4px 0;"/><span style="font-size:16px;font-weight:600;margin-right: 5px;">영업시간 </span>'+position.openTime+'</p>'+
			    			'<p><img src="${ctp}/resources/images/icon/information.png" style="width:20px;margin:0 10px 4px 0;"/><span style="font-size:16px;font-weight:600;margin-right: 5px;">휴무 </span>'+position.closedDay+'</p>'+
			    			'<p><img src="${ctp}/resources/images/icon/information.png" style="width:20px;margin:0 10px 4px 0;"/><span style="font-size:16px;font-weight:600;margin-right: 5px;">제한사항 </span>'+position.petLimit+'</p>'+
			    			'<p><img src="${ctp}/resources/images/icon/home.png" style="width:20px;margin:0 10px 4px 0;"/><a href="'+position.homePage+'" target="_blank" style="color:#578de4;">'+position.homePage+'</a></p>'+
		    			'<section>'+
		    		'</div>';
		    		
		    	document.getElementById("cafeReviewMore").innerHTML = 
		    		'<div><a class="cafeReviewBtn" href="hospitalReviewList?idx='+ position.idx +'";>['+position.placeName+'] 리뷰 보기</a>'+
		    		'<a class="cafeReviewBtn" href="hospitalReviewInsert?placeIdx='+ position.idx +'";>['+position.placeName+'] 후기 작성하기</a>'+
		    		'</div>'+
		    		'<div id="reviewMiniView"></div>';
		    	
		    	$.ajax({
		    		url : '${ctp}/petPlace/reviewMiniView',
		    		type : 'post',
		    		data : {idx : position.idx},
		    		success : function(vos) {
						if(vos != 0){
							
						}
					},
		    		error : function() {
						alert('전송오류');
					}
		    	});
			});
	    });
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}
		/* 
		function setBounds() {
	        // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
	        // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
	        map.setBounds(bounds);
	    }
		 */
	</script>
	
	
	
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>