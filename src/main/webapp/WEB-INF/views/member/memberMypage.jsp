<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberMypage</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
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
			padding : 150px 0 0;
			width : 1300px;
			margin : 0 auto;
		}
		.sec-boxStyle{
			background-color : #f9f9f9;
			border-radius : 30px;
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
		}
		.sec01{
			margin-bottom : 50px;
			height : 200px;
		}
		.profile-box{
			width : 69%;
			margin-right : 1%;
			float : left;
			height : 200px;
			padding : 30px;
		}
		.profile-box .profile{
			width : 20%;
			float : left;
			/* box-shadow : 5px 10px 8px rgba(0, 0, 50, 0.1); */
		    overflow:hidden;
		}
		.profile-box .profile img{
			border-radius : 100px;
			width : 100px;
			height : 100px;
			object-fit: cover;
		}
		.profile-box .info{
			float : left;
			width : 80%;
		}
		.point-box{
			width : 30%;
			float : left;
			height : 200px;
			padding : 30px;
		}
		.pet-box01{
			width : 30%;
			float : left;
			height : 200px;
			padding : 30px;
		}
		.pet-box02{
			width : 30%;
			float : left;
		}
		.pet-box01 .profile{
			width : 100px;
			height : 100px;
			border-radius : 100px;
			/* box-shadow : 5px 10px 8px rgba(0, 0, 50, 0.1); */
		    overflow:hidden;
		}
		.pet-box01 .profile img{
			width : 100%;
			height : 100%;
			object-fit: cover;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div class="sec01">
			<section class="profile-box sec-boxStyle">
				<div class="profile">
					<img src="${ctp}/resources/data/member/${vo.photo}"/>
				</div>
				<div class="info">
					<p style="font-size:26px;font-weight:700;color:#444;margin:0 0 5px">${vo.nickName}</p>
					<p><img src="${ctp}/resources/images/memberMypage/place.png" style="width:20px;margin-right:5px;"/>${vo.address}</p>
					<p>안녕하세용</p>
				</div>
			</section>
			<section class="point-box sec-boxStyle">
				<img src="${ctp}/resources/images/memberMypage/cherry001.jpg" style="width:100px;border-radius:100px;box-shadow : 5px 8px 5px rgba(0, 0, 50, 0.1);"/>
			</section>
		</div>
		<div class="sec02">
			<section class="pet-box01 sec-boxStyle">
				<div class="profile">
					<img src="${ctp}/resources/data/member/${vo.photo}"/>
				</div>
			</section>
			<section class="pet-box02 sec-boxStyle">
				pet-box02
			</section>
		</div>
	</div>
</body>
</html>