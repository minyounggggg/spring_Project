<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>footer.jap</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
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
		/* p{margin : 0;} */
		footer{
			background-color : #444;
			color : #fff;
			clear : both;
			padding : 100px 0;
		    font-weight: 100;
    		font-size: 14px;
		}
		.footerInner{
			width : 1300px;
			margin : 0 auto;
		}
	</style>
</head>
<body>
	<footer>
		<div class="footerInner">
			<P>개인정보처리방침 | 이용약관 | 고객센터</P>
			<P>충청북도 청주시 서원구 사창동 148-7 4층</P>
			<P>シロも家族です！ パパがいてママがいて私がいてチャンアがいて,シロも家族です！ 新シロですよ！ 小さくなっても頭脳は同じ！ 真実はいつも１つ！ </P>
			<P>© HappyYoung Corp.</P>
		</div>
	</footer>
</body>
</html>