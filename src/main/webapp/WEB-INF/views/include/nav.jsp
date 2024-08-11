<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>nav.jap</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<!-- 파비콘 -->
	<link rel="icon" href="${ctp}/resources/favicon/love.png">
	<!-- 구글폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap');
	</style>
	
	<style>
		*{font-family: 'Noto Sans KR', sans-serif; }
		a {  
			text-decoration: none;
			color: inherit;
		}
		a:link{text-decoration: none;}
		/* 
		.inner{
			width : 1300px;
			margin : 0 auto;
		}
		 */
		nav{
			padding : 10px 0 20px;
			box-shadow : 0px 5px 5px rgba(0, 0, 50, 0.1);
			position: fixed;
			width : 100%;
			background-color : #fff;
			z-index : 99;
		}
		nav .nav-top{
			margin : 0 auto;
			width : 1300px;
		}
		nav .nav-logo{
			float : left;
			width : 30%;
		}
		nav .nav-login p{
			margin : 0;
		}
		nav .nav-login{
			float : left;
			width : 70%;
			font-size : 14px;
		}
		nav hr {
			margin : 10px 0 20px;
			clear : both;
		}
		nav .nav{
			width : 1300px;
			margin : 0 auto;
			text-align: center;
		    display: flex;
		    justify-content: space-between;
		}
	</style>
	
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		// 카카오 로그아웃
		window.Kakao.init("4bed81139daac8fd06f75e2c669b1570");
		function kakaoLogout() {
			const accessToken = Kakao.Auth.getAccessToken();
			if(accessToken){	// 내 토큰이 살아잇다면 끊어조
				Kakao.Auth.logout(function () {
					window.location.href = "https://kauth.kakao.com/oauth/logout?client_id=4bed81139daac8fd06f75e2c669b1570&logout_redirect_uri=http://localhost:9090/javaclassS/member/memberLogout";
				});
			}
		}
	</script>
</head>
<body>
	<nav>
		<div class="nav-top">
			<div class="nav-logo"><!-- 홈컨트롤러 home부분 memberMain.jsp main.jsp로 바꾸고 수정해놓기 -->
				<a href="${ctp}/member/memberMain"><img src="${ctp}/resources/images/memberMain/logo.png" style="width:140px; margin-bottom:8px;"/></a>
			</div>
			<div class="nav-login text-right">
				<c:if test="${empty sNickName}">
					<a href="${ctp}/member/memberLogin">로그인</a> &nbsp;|&nbsp; <a href="${ctp}/member/memberJoin">회원가입</a>
				</c:if>
				<c:if test="${!empty sNickName}"><!-- 카카오로그아웃, 네이버로그아웃 추가 -->
					<p style="font-size:14px;font-weight:600;color:#578de4;">${sNickName}<span style="font-size:14px;font-weight:400;color:#333333;">님 안녕하세요! &nbsp;|&nbsp; 
					<c:if test="${sLevel == 0}"><a href="${ctp}/admin/adminMain">관리자페이지</a> &nbsp;|&nbsp;</c:if>
					<a href="${ctp}/member/memberMypage">마이페이지</a> &nbsp;|&nbsp; <a href="${ctp}/member/memberLogout">로그아웃</a></span></p>
				</c:if>
			</div>
		</div>
		<hr/>
		<div class="nav" style="font-size:16px;font-weight:700;">
			<a href="${ctp}/mbti/mbti">Only-E.W</a>
			<a href="#">동네수다</a>
			<a href="${ctp}/review/productReview">제품후기</a>
			<a href="${ctp}/hospital/hospital">온동네병원</a>
			<a href="${ctp}/petPlace/petCafe">카페</a>
			<a href="#">식당</a>
			<a href="#">펜션&글램핑</a>
		</div>
	</nav>
</body>
</html>