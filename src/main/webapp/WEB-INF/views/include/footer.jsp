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
			<P>footer입니다. 아ㅏ 외 이럿캐 귀찬냐 대충 뚝-따ㅏㄱHappyYoung --</P>
			<P>HappyYoung --Here 연락주ㅜ쇼</P>
			<P>이곳의 Content is from ㅗ메ㅔㅔ 아이고 HappyYoung -- HappyYoung -- 小さくなっても頭脳は同じ！ 真実はいつも１つ！</P>
			<P>シロも家族です！ パパがいてママがいて私がいてチャンアがいて,シロも家族です！ 新シロですよ！</P>
		</div>
	</footer>
</body>
</html>