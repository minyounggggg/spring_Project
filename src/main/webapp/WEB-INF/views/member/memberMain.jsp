<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>memberJoin.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<link rel="icon" href="${ctp}/resources/favicon/love.png">

<!-- 구글폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap');
</style>

<!-- swiper link -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />


<style>
	*{font-family: 'Noto Sans KR', sans-serif; }
	a {  
		text-decoration: none;
		color: inherit;
	}
	a:link{text-decoration: none;}
	body{
		/* display : flex;
		justify-content: center;
		align-items: center; */
		/* height: 100vh; */
		position: relative;
		background-color : #fff;
	}
	.inner{
		width : 1300px;
		margin : 0 auto;
	}
	nav{
		padding : 10px 0 20px;
		box-shadow : 0px 5px 5px rgba(0, 0, 50, 0.1);
		position: fixed;
		width : 100%;
		background-color : #fff;
		z-index : 99;
	}
	nav .nav-login{
		font-size : 14px;
	}
	nav hr {margin : 10px 0 20px}
	nav .nav{
		text-align: center;
	    display: flex;
	    justify-content: space-between;
	}
	header{
		background-color : #fcfdff;
		height : 500px;
		width : 100%;
	}
	header .header-sec01{
		padding-top : 180px;
	}
	header div span{
		font-size : 55px;
		font-weight : 300;
		color : #333333;
	}
	.swiper {
      width: 100%;
      height: 420px;
      padding : 10px 0;
      margin : 120px 0 80px;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #eee;
      display: flex;
      justify-content: center;
      align-items: center;
      /* width: 48.3% !important; */
      height: 350px;
      /* margin : 10px; */
      border-radius : 30px;
	  box-shadow : 5px 8px 8px rgba(0, 0, 50, 0.2);
    }
    .swiper-slide img {
      display: block;
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius : 30px;
    }
	.secStyle{
		background-color : #f7f7f7;
		border-radius : 30px;
		box-shadow : 8px 15px 10px rgba(0, 0, 50, 0.1);
		margin : 10px;
	}
	.sec1{
		float : left;
		width : 50%;
		height: 300px;
	}
	.sec2{
		float : left;
		width : 50%;
		height: 300px;
	}
	.gradient-sec{
		background : linear-gradient(to top, rgba(87,141,288,0.3), rgba(0,0,255,0));
	}
	.sec02{
		padding-bottom : 100px;
	}
	.sec02 span{
		font-size : 40px;
		font-weight : 300;
		color : #333333;
	}
	.sec02-contentBox{
		clear : both;
		height: 500px;
	}
	
</style>
<script>
	'use strict';
	
	
	
</script>
</head>
<body>
	<nav>
		<div class="nav-login inner text-right">
			<c:if test="${empty sNickName}">
				<a href="${ctp}/member/memberLogin">로그인</a> &nbsp;|&nbsp; <a href="${ctp}/member/memberJoin">회원가입</a>
			</c:if>
			<c:if test="${!empty sNickName}">
				<p style="font-size:14px;font-weight:600;color:#578de4;">${sNickName}<span style="font-size:14px;font-weight:400;color:#333333;">님 안녕하세요! &nbsp;|&nbsp; <a href="${ctp}/member/memberLogout">로그아웃</a></span></p>
			</c:if>
		</div>
		<hr/>
		<div class="nav inner" style="font-size:16px;font-weight:700;">
			<a href="#">Only-E.W</a>
			<a href="#">동네수다</a>
			<a href="#">제품후기</a>
			<a href="#">온동네병원</a>
			<a href="#">카페</a>
			<a href="#">식당</a>
			<a href="#">펜션&글램핑</a>
		</div>
	</nav>
	<header>
		<div class="header-sec01 inner">
			<div class="sec1">
				<p style="font-size:20px;font-weight:700;color:#578de4;margin-top:20px;">Enjoy With</p>
				<p style="font-size:55px;font-weight:700;color:#578de4;">반려동물<span>과</span> 함께 <span>즐기고싶어</span></p>
				<p style="font-size:18px;">내가없으면 얜 혼자있어야 되는데 심심심하겠다.<br/>
				나도 맨날 같이 데리고 나가서 놀고싶은데 제약이 너무 많아<br/>
				어디 괜찮은곳 없을까? <br/>
				항상 즐거운곳을 가거나 맛있는걸 먹으면 같이 옴뇸뇸 하고싶어잉 ~~ </p>
			</div>
			<div class="sec2">
				<img src="${ctp}/resources/images/memberMain/main_bn01.png" style="width:100%"/>
			</div>
		</div>
	</header>
	<div class="inner sec01">
		<div class="swiper mySwiper">
		    <div class="swiper-wrapper">
		      <div class="swiper-slide"><img src="${ctp}/resources/images/memberMain/main_event01.png"/></div>
		      <div class="swiper-slide"><img src="${ctp}/resources/images/memberMain/main_event02.png"/></div>
		      <div class="swiper-slide"><img src="${ctp}/resources/images/memberMain/main_event01.png"/></div>
		      <div class="swiper-slide"><img src="${ctp}/resources/images/memberMain/main_event02.png"/></div>
		      <div class="swiper-slide"><img src="${ctp}/resources/images/memberMain/main_event01.png"/></div>
		      <div class="swiper-slide"><img src="${ctp}/resources/images/memberMain/main_event02.png"/></div>
		    </div>
		    <div class="swiper-pagination"></div>
	  	</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script>
	    var swiper = new Swiper(".mySwiper", {
	    	slidesPerView: 2,
	        spaceBetween: 40,
	        loop: true,
	    	/* effect: "fade",*/
	    	autoplay: {
	            delay: 3000,
	            disableOnInteraction: false,
	        }, 
	      	pagination: {
	        	el: ".swiper-pagination",
	        	clickable: true,
	        	dynamicBullets: true,
	      	},
	    });
	</script>
	<div class="gradient-sec">
		<div class="inner sec02">
			<section class="text-center">
				<p style="font-size:20px;font-weight:700;color:#578de4;margin-top:20px;">Enjoy With</p>
				<p style="font-size:40px;font-weight:700;color:#333333;margin-bottom:60px;">반려동물<span>과</span> 함께 <span>즐기고싶어</span></p>
			</section>
			<section style="margin-bottom:30px">
			<!-- 임시 이미지 교체하기 (후기 이모지 혹은 검색 키워드 적어놓은 이모지 카드 나열해놓기) -->
				<img src="${ctp}/resources/images/memberMain/imsi01.png" style="width:25%"/>
				<img src="${ctp}/resources/images/memberMain/imsi02.png" style="width:25%"/>
				<img src="${ctp}/resources/images/memberMain/imsi03.png" style="width:25%"/>
				<img src="${ctp}/resources/images/memberMain/imsi03.png" style="width:24%"/>
			</section>
			<section class="secStyle sec02-contentBox">
				<p>sec03</p>
			</section>
		</div>
	</div>
</body>
</html>