<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productReviewContent.jsp</title>
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
		p {margin:0;}
		.inner {
			width : 1300px;
			margin : 0 auto;
			padding: 150px 50px 0;
			border-left: solid 1px #ddd;
			border-right: solid 1px #ddd;
		}
		.sec-boxStyle{
			background-color : #f9f9f9;
			border-radius : 30px;
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
		}
		.sec02, .sec03{float:left; width:50%;}
		
		.reviewSec{
			background-color : #f9f9f9;
			border-radius : 30px;
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
			padding : 30px 45px;
			width : 630px;
			display: inline-block;
			float : left;
			margin : 10px;
		}
		.reviewNickName{
			font-size: 18px;
		    margin-left: 15px;
		    font-weight: 600;
		    color: #444;
		}
		.reviewUploadDate{
			margin-right : 10px;
			color: #999;
		}
		.friend{
			margin-left: 5px;
		    border-radius: 50px;
		    border: solid 1px #EB403D;
		    padding: 3px 12px;
		    color: #EB403D;
		    font-size: 14px;
    		font-weight: 600;
		}
		.petCategoryVal, .productCategoryVal{
		    margin-left: 5px;
		    border-radius: 50px;
		    border: solid 1px #578de4;
		    padding: 3px 12px;
		    color: #578de4;
		    font-size: 14px;
    		font-weight: 600;
		}
		.repurchaseOKTxt{
			margin-left: 10px;
		    border-radius: 50px;
		    border: solid 1px #578de4;
		    padding: 5px 18px;
		    color: #578de4;
		    font-size: 17px;
    		font-weight: 600;
		}
		.reviewSecInfo{float:left;width:80%;}
		.reviewSecMore{float:left;width:20%;text-align: right;}
		.HeartPoint{float:left;width:50%;}
		.memberHeart, .petHeart {
		    /* border: solid 1px #FF2121; */
		    border-radius: 50px;
		    padding: 1px 10px;
		    width: fit-content;
		}
		.goodtxt, .badtxt{
			border-radius: 50px;
		    background-color: #578de430;
		    color: #3174df;
		    font-size: 15px;
		    font-weight: 600;
		    padding: 3px 15px;
		}
		.badtxt{background-color: #99999933; color: #999999;}
		
		/* 모달 css */

    	#insertModal .modal-content{
    		background-color: transparent;
    		border: none;
    	}
    	
    	#insertModal .modal-dialog {
	        max-width: 710px;
	    }
	     
	    #myModal1 .modal-header, #insertModal .modal-header, #myModal3 .modal-header{
	    	border: none;
	    	margin-bottom: 10px;
	    }
	    #myModal1 button.close, #insertModal button.close, #myModal3 button.close{
	    	background-color: #fff;
	    	border-radius: 100px;
	    }
	    
		#insertModal .modal-profile-box{
			width : 710px;
			padding : 35px 50px;
			/* height : 180px; */
		}
		.modal-profile-box .modal-profile{
			/* box-shadow : 5px 10px 8px rgba(0, 0, 50, 0.1); */
			width : 100%;
		    overflow:hidden;
	        /* text-align: center; */
		}
		.modal-profile-box .swiper-slide img{
			border-radius : 20px;
			width : 130px;
			height : 130px;
			object-fit: cover;
			margin-right : 5px;
		}
		#myModal1 .modal-profile-box .modal-info{
			width : 100%;
		    text-align: center;
		}
		input#nickName {
		    border: none;
		    border-bottom: solid 1px #578de4;
		    background-color: transparent;
		    font-size: 24px;
		    font-weight: 700;
		    color: #444;
        	width: 100%;
       	    text-align: right;
       	    padding: 0 5px 0;
		}
		/* input:focus {outline: 2px solid #d50000;} */ /* outline 테두리 속성 수정 */
		input#nickName:focus {outline: none;} /* outline 테두리 없애기 */
		input#address {
		    border: none;
		    border-bottom: solid 1px #578de4;
		    background-color: transparent;
		    font-size: 18px;
		    font-weight: 500;
		    color: #444;
        	width: 100%;
       	    text-align: right;
       	    padding: 10px 5px 5px;
		}
		input#address:focus {outline: none;}
		
		input[type="text"] {border-radius: 50px; padding: 10px 20px;}
		input[type="date"] {border-radius: 50px; padding: 10px 20px;}
		
		/* 반려동물 종류 체크박스 */
		#check-box input[type="checkbox"] {
			appearance: none;
		}
		#check-box input[type="checkbox"] + label{
		    border: solid 1px #ced4da;
		    border-radius: 50px;
	        padding: 8px 20px;
		    margin: 5px 5px 0 0;
	        color: #a1a1a1;
		}
		#check-box input[type="checkbox"]:checked + label{
			border: solid 1px #578de4;
			color: #578de4;
		}
		
		/* 제품종류 라디오박스 */
		#radio-box input[type="radio"] {
			appearance: none;
		}
		#radio-box input[type="radio"] + label{
		    border: solid 1px #ced4da;
		    border-radius: 50px;
	        padding: 8px 20px;
		    margin: 5px 5px 0 0;
	        color: #a1a1a1;
		}
		#radio-box input[type=radio]:checked + label{
			border: solid 1px #578de4;
			color: #578de4;
		}
		
		/* 재구매의사 라디오박스 */
		#repurchaseRadio-box input[type="radio"] {
			appearance: none;
		}
		#repurchaseRadio-box label{
		    border: solid 1px #ced4da;
		    border-radius: 50px;
	        padding: 8px 20px;
		    margin: 5px 5px 0 0;
	        color: #a1a1a1;
		}
		#repurchaseRadio-box input[type=radio]:checked + label{
			border: solid 1px #578de4;
			color: #578de4;
		}
		
		/* 하트 스타일 설정하기 */
    	#HeartInsert fieldset{
    		direction : rtl;
    		padding : 10px 0;
    	}
    	#HeartInsert input[type=radio] {
    		display : none;
    	}
    	#HeartInsert label {
    		font-size : 1.6em;
    		color : transparent;
    		text-shadow : 0 0 0 #f0f0f0;
    	}
    	#HeartInsert label:hover{
    		color: #EB403D;
    	}
    	#HeartInsert label:hover ~ label{
    		color: #EB403D;
    	}
    	#HeartInsert input[type=radio]:checked ~ label{
    		color: #EB403D;
    	}
    	span.HeartInsertBar {
		    border-radius: 50px;
		    border: solid 1px #EB403D;
		    padding: 10px 20px 5px;
		    margin-left: 12px;
		}
		
		textarea#goodPoint, #badPoint {
		    margin-top: 5px;
		    border-radius: 10px;
		}
		span.petBox-playWith {
		    border: solid 1px #578de4;
		    border-radius: 50px;
		    padding: 8px 20px;
		    color: #578de4;
		    margin: 5px 5px 0 0;
		}
		
		/* 사진파일업로드 css */
		.file_cus label {display: block; width: 100%; margin: 15px 0 15px; font-size: 0; cursor: pointer;}
		input[type="file"] {overflow: hidden;position: absolute;width: 1px;height: 1px;margin: -1px;font-size: initial;clip: rect(0 0 0 0);}
		.file_name {
			overflow: hidden; display: inline-block; border-radius: 50px !important;
			vertical-align: middle; width: calc(100% - 108px);
			height: 40px; padding:0 12px; border: 1px solid #ddd;
			font-size: 14px; line-height: 38px;
			color: #111; white-space: nowrap; text-overflow: ellipsis;
		}
		.file_btn {
			display: inline-block; vertical-align: middle;
			width: 100px; height: 40px; margin-left: 8px; border-radius: 50px;
			background: #578de4;font-size: 14px;
			font-weight: 500; line-height: 40px; color: #fff; text-align: center;
		}
		input[type="file"]:focus-visible ~ .file_btn, .file_cus:hover .file_btn {background: #3478db;}

		.memberUpdateBtn, .petInsertOkBtn, .petUpdateOkBtn {
		    background-color: #578de4;
		    border-color: #578de4;
		    margin-top: 25px;
		    padding: 10px 0 10px;
		    width : 100%;
		    border-radius: 50px;
		    border: none;
		    color: #fff;
		}
		button.petDeleteBtn {
		    width: 100%;
		    border: none;
		    background: transparent;
		    margin-top: 10px;
		    color: #999;
		}
		.memberUpdateBtn:hover {background-color: #3478db;}
		.petInsertOkBtn:hover {background-color: #3478db;}
		.petUpdateOkBtn:hover {background-color: #3478db;}
		
		/* swiper css */
		.swiper {
	      width: 100%;
	      height: 150px;
	    }
	    .swiper-slide {
	      width: 140px;
	    }
	    .swiper-scrollbar-drag{background: var(--swiper-scrollbar-drag-bg-color, rgba(87, 141, 228, 1));}
	</style>
	<script>
		
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div class="sec01">
			<section class="reviewSecInfo">
				<p><img src="${ctp}/resources/data/member/${vo.photo}" style="width:60px;"/>
				<span class="reviewNickName">${vo.nickName} · </span>
				<span class="reviewUploadDate">${(vo.uploadDate).substring(0,16)}</span>
				<span class="friend">친구맺기</span></p>
			</section>
			<section class="reviewSecMore">
				<span class="petCategoryVal">${vo.petCategory}</span>
				<span class="productCategoryVal">${vo.productCategory}</span>
			</section>
		</div>
		<hr style="clear:both;"/>
		<div class="sec02">
			<section class="productInfo">
				<section style="margin-bottom:30px;">
					<p class="productBrand" style="color:#578de4;font-size:17px;font-weight: 700;margin:0 0 0 1px;">${vo.brand}</p>
					<p class="productName" style="font-size:25px;font-weight:600;color:#333;">${vo.productName}
					<c:if test="${vo.repurchase == 'OK'}"><span class="repurchaseOKTxt">재구매하고싶어요 <img src="${ctp}/resources/images/icon/heartface-emoji.png" style="width:20px;margin-bottom:4px;"/></span></c:if>
					<c:if test="${vo.repurchase == 'NO'}"><span class="repurchaseNOTxt">${vo.repurchase}</span></c:if>
					<c:if test="${vo.repurchase == 'Um'}"><span class="repurchaseUmTxt">${vo.repurchase}</span></c:if></p>
				</section>
				<section style="margin-bottom:10px;">
					<span style="color: #636363; font-size: 14px; font-weight: 500; margin:0 5px;">반려인 &nbsp;&nbsp;</span>
					<span class="memberHeart">
						<c:forEach var="i" begin="1" end="${vo.memberHeart}" varStatus="iSt"><font color="#EB403D">❤︎</font></c:forEach>
						<c:forEach var="i" begin="1" end="${5 - vo.memberHeart}" varStatus="iSt"><font color="#FFBDBD">❤︎</font></c:forEach>
					</span>
				</section>
				<section>
					<span style="color: #636363; font-size: 14px; font-weight: 500; margin:0 5px;">반려동물 </span>
					<span class="petHeart">
						<c:forEach var="i" begin="1" end="${vo.petHeart}" varStatus="iSt"><font color="#EB403D">❤︎</font></c:forEach>
						<c:forEach var="i" begin="1" end="${5 - vo.petHeart}" varStatus="iSt"><font color="#FFBDBD">❤︎</font></c:forEach>
					</span>
				</section>
				<section class="gbPoint" style="margin-top:30px;">
					<span class="goodtxt">이런 점이 좋아요</span>
					<p style="font-size: 14px; color: #999; margin: 10px 0 20px 9px;">${vo.goodPoint}</p>
					<span class="badtxt">이런 점이 아쉬워요</span>
					<p style="font-size: 14px; color: #999; margin: 10px 0 20px 9px;">${vo.badPoint}</p>
				</section>
			</section>
		</div>
		<div class="sec03">
			<section class="productInfo">
				<c:set var="productPhotos" value="${fn:split(vo.productPhoto, '/')}"/>
				<c:forEach var="productPhoto" items="${productPhotos}">
					<img src="${ctp}/resources/data/productReview/${productPhoto}" style="width:120px;height:120px;border-radius:15px;margin: 0 5px 20px 0;object-fit: cover;"/>
				</c:forEach>
			</section>
			<section id="productPhotoDemo"></section>
		</div>
		<hr style="clear:both;"/>
		<section class="reviewHeart">
			<span style="font-size:15px;margin-right:15px;"><img src="${ctp}/resources/images/icon/love.png" style="width:25px;margin: 0 5px 5px 0;"/>${vo.goodHeart}</span>
			<span style="font-size:15px;"><img src="${ctp}/resources/images/icon/speech-bubble.png" style="width:25px;margin: 0 5px 5px 0;"/>${vo.commentCnt}</span>
		</section>
	</div>
	<div class="insertNav" style="bottom: 60px; right: 70px; position: fixed;">
		<section data-toggle="modal" data-target="#insertModal"><img src="${ctp}/resources/images/icon/insertBtn.png" style="width:90px;cursor:pointer;"/></section>
		<section><a href="#listCategory"><img src="${ctp}/resources/images/icon/topBtn.png" style="width:90px;"/></a></section>
	</div>
	
	
</body>
</html>