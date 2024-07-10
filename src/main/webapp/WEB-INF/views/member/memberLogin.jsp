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
	body{
		display : flex;
		justify-content: center;
		align-items: center;
		/* height: 100vh; */
		background-color : #eee;
		padding-top : 150px;
	}
	.loginForm{
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
		height: 500px;
		border-radius : 30px 0 0 30px;
	}
	.sec02{
		/* background : url("${ctp}/resources/images/memberLogin/testBG.jpg"); */
		font-family: "Noto Sans KR", sans-serif;
		background-color : #f9f9f9;
		float : left;
		width : 50%;
		height: 500px;
		border-radius : 0 30px 30px 0;
		padding : 30px;
	}
</style>
</head>
<body>
	<div class="loginForm">
		<section class="sec01">
			<%-- <img src="${ctp}/resources/images/memberLogin/login_bg_02.png" /> --%>
			<!-- ios 이미지 편집 후 넣어주세용 -->
		</section>
		<section class="sec02">
			<form name="myform" method="post">
				<img src="${ctp}/resources/images/memberLogin/loginicon01.png" style="width:50px"/>
				<p style="color:#2F2F2F;font-size:36px; font-weight:700;margin:20px 0;">LOGIN</p>
		    	<input type="text" name="mid" id="mid" placeholder="User ID" autofocus required class="form-control mb-1" style="height:45px"/>
		       	<input type="checkbox" name="idSave" id="idSave" checked class="mb-3 ml-2"/> 아이디 저장
			    <input type="password" name="pwd" placeholder="Password" required class="form-control mb-4" style="height:45px"/>
			    <button type="submit" class="btn btn-primary form-control mb-2">로그인</button>
				<button type="button" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary form-control mb-2">회원가입</button>
				<a href="javascript:kakaoLogin()"><img src="${ctp}/resources/images/kakao_login_medium_wide.png"/></a>
		  	</form>
		</section>
	</div>
</body>
</html>