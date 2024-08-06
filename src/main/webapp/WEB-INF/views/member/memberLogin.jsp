<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>memberLogin.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />

<!-- 구글폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<style>
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');
</style>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script><!-- 카카오로그인 js파일 -->
<script>
	//카카오로그인(자바스크립트 앱키 등록)
	window.Kakao.init("4bed81139daac8fd06f75e2c669b1570");
	
	function kakaoLogin() {
		window.Kakao.Auth.login({		//window.Kakao.~~~ 카카오명령을 쓰기위해 Kakao.을 붙여준다. (window는 생략가능)
			scope: 'profile_nickname, account_email',
			success : function (autoObj) {
				console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급됨,,");
				window.Kakao.API.request({
					url : '/v2/user/me',
					success : function(res){
						const kakao_account = res.kakao_account;
						console.log(kakao_account);
						location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
					}
				});
			}	
		});
	}
	
</script>
<style>
	* {font-family: 'Noto Sans KR', sans-serif; }
	a {text-decoration: none; color: inherit;}
	a:link{text-decoration: none;}
	body{
		display : flex;
		justify-content: center;
		/* align-items: center; */
		/* height: 100vh; */
		background-color : #eee;
		/* padding-top : 150px; */
	}
	nav{
		padding : 15px 0 10px;
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
	.loginForm{
		margin-top: 140px;
		display : flex;
		width : 1000px;
		border-radius : 30px;
		box-shadow : 8px 15px 10px rgba(0, 0, 50, 0.1);
	}
	.sec01{
		/* background-image : url("${ctp}/resources/images/memberLogin/login_bg_02.png"); */
		background-color : #999999;
		float : left;
		width : 50%;
		/* height: 500px; */
		border-radius : 30px 0 0 30px;
	}
	.sec02{
		/* background : url("${ctp}/resources/images/memberLogin/testBG.jpg"); */
		font-family: "Noto Sans KR", sans-serif;
		background-color : #f9f9f9;
		float : left;
		width : 50%;
		/* height: 500px; */
		border-radius : 0 30px 30px 0;
		padding : 50px 60px;
	}
	.loginBtn, .joinBtn{
		background-color: #578de4;
	    padding: 12px 0;
    	margin-bottom: 10px;
	    width : 100%;
	    border-radius: 50px;
	    border: none;
	    color: #fff;
    	font-size: 16px;
	}
	.loginBtn:hover {background-color: #3478db;}
	.joinBtn:hover {background-color: #3478db;}
	.kakaologinBtn{
		background-color: #fee500;
	    padding: 12px 0;
    	margin-bottom: 10px;
	    width : 100%;
	    border-radius: 50px;
	    border: none;
	    color: #181600;
    	font-size: 16px;
    	font-weight: 800;
	}
	.kakaologinBtn:hover {background-color: #ffd800;color: #181600;}
	
</style>
</head>
<body>
	<nav>
		<div class="nav-top">
			<div class="nav-logo"><!-- 홈컨트롤러 home부분 memberMain.jsp main.jsp로 바꾸고 수정해놓기 -->
				<a href="${ctp}/member/memberMain"><img src="${ctp}/resources/images/memberMain/logo.png" style="width:140px; margin-bottom:5px;"/></a>
			</div>
			<div class="nav-login text-right">
				<c:if test="${empty sNickName}">
					<a href="${ctp}/member/memberLogin">로그인</a> &nbsp;|&nbsp; <a href="${ctp}/member/memberJoin">회원가입</a>
				</c:if>
				<c:if test="${!empty sNickName}"><!-- 카카오로그아웃, 네이버로그아웃 추가 -->
					<p style="font-size:14px;font-weight:600;color:#578de4;">${sNickName}<span style="font-size:14px;font-weight:400;color:#333333;">님 안녕하세요! &nbsp;|&nbsp; 
					<a href="${ctp}/member/memberMypage">마이페이지</a> &nbsp;|&nbsp; <a href="${ctp}/member/memberLogout">로그아웃</a></span></p>
				</c:if>
			</div>
		</div>
	</nav>
	<div class="loginForm">
		<section class="sec01">
			<img src="${ctp}/resources/images/memberLogin/login_bg_03.png" />
			<!-- ios 이미지 편집 후 넣어주세용 -->
		</section>
		<section class="sec02">
			<form name="myform" method="post">
				<img src="${ctp}/resources/images/memberLogin/loginicon01.png" style="width:50px"/>
				<p style="color:#2F2F2F;font-size:36px; font-weight:700;margin:20px 0;">LOGIN</p>
		    	<input type="text" name="mid" id="mid" placeholder="User ID" autofocus required class="form-control mb-1" style="height:45px"/>
		       	<input type="checkbox" name="idSave" id="idSave" checked class="mb-3 ml-2"/> 아이디 저장
			    <input type="password" name="pwd" placeholder="Password" required class="form-control mb-4" style="height:45px"/>
			    <button type="submit" class="loginBtn">로그인</button>
				<button type="button" onclick="location.href='${ctp}/member/memberJoin';" class="joinBtn">회원가입</button>
				<button type="button" onclick="kakaoLogin()" class="kakaologinBtn">카카오 로그인</button>
				<!-- <a href="javascript:kakaoLogin()" class="kakaologinBtn">카카오 로그인</a> -->
				<%-- <a href="javascript:kakaoLogin()"><img src="${ctp}/resources/images/kakao_login_medium_wide.png"/></a> --%>
		  	</form>
		</section>
	</div>
</body>
</html>