<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>wishPlace</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="icon" href="ctp/resources/favicon/love.png">
	
	<!-- 구글폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap');
		
		
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
		button {border: none; background-color: transparent;}
		
		
		.wishPlaceSec{
			display : flex;
			justify-content: space-between;
		}
		.wishCafeSec, .wishHospitalSec{
			width : 48%;
			margin-bottom : 40px;
		}
		.wishCafeInfo, .wishHospitalInfo{
			border: solid 1px #e9ecef;
		    padding: 20px 20px;
		    border-radius: 5px;
		    margin-bottom: 5px;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		.cafeNameTxt, .hospitalNameTxt{
			font-size: 20px;
		    font-weight: 600;
		    margin-bottom: 10px;
		}
		.cafeNameAddressTxt, .hospitalNameAddressTxt{
			font-size: 15px;
		    font-weight: 400;
		    margin-left: 15px;
		    color: #7f7f7f;
    		letter-spacing: -1px;
		}
		.cafeSaveDateTxt, .hospitalSaveDateTxt{
			color: #c5c5c5;
			margin-bottom: 0;
		}
		.titleTxt{
			font-size: 18px;
		    font-weight: 700;
		    letter-spacing: -1px;
		    margin-top: 35px;
		}
		.infoSec{
			
		}
		.moreBtn-1{
			border: solid 1px #578de4;
		    border-radius: 20px;
		    padding: 2px 14px;
		    color: #578de4;
		    font-size: 14px;
		}
		.moreBtn-1:hover{background-color: #578DE4;color:#fff;}
	</style>
	<script>
    	'use strict';
    	
    	
    
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div class="wishPlaceSec">
			
			<section class="wishCafeSec">
				<p class="titleTxt"><img src="${ctp}/resources/images/icon/love.png" style="width:25px;margin: 0 5px 5px 5px;"/><span style="color:#578de4;">${sNickName}</span>님이 가고싶은 카페 List</p>
				<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
				<c:forEach var="cafeVO" items="${cafeVos}">
					<section class="wishCafeInfo">
						<section class="infoSec">
							<p class="cafeNameTxt">${cafeVO.placeName}<span class="cafeNameAddressTxt">${cafeVO.sido} ${cafeVO.sigungu} ${cafeVO.dong}</span></p>
							<p class="cafeSaveDateTxt">${(cafeVO.saveDate).substring(0,10)}</p>
						</section>
						<section class="moreBtn"><button onclick="location.href='${ctp}/petPlace/petCafeReviewList?idx=${cafeVO.placeIdx}';" class="moreBtn-1">cafe more</button></section>
					</section>
				</c:forEach>
				<!-- 블록페이지 시작 -->
				<div class="text-center">
				  <ul class="pagination justify-content-center">
					  <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
					  <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
					  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
					    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="wishPlace?mid=${sMid}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
					    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
					  </c:forEach>
					  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
					  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
				  </ul>
				</div>
				<!-- 블록페이지 끝 -->
				<br/>
				<!-- 검색기 시작 -->
				<!--
				<div class="container text-center">
				  <form name="searchForm" method="post" action="boardSearch">
				    <b>검색 : </b>
				    <select name="search" id="search">
				      <option value="title">글제목</option>
				      <option value="nickName">글쓴이</option>
				      <option value="content">글내용</option>
				    </select>
				    <input type="text" name="searchString" id="searchString" required />
				    <input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
				    <input type="hidden" name="pag" value="${pageVO.pag}"/>
				    <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
				  </form>
				</div>
				-->
				<!-- 검색기 끝 -->
			</section>	
			
			<section class="wishHospitalSec">
				<p class="titleTxt"><img src="${ctp}/resources/images/icon/love.png" style="width:25px;margin: 0 5px 5px 5px;"/>반려동물을 믿고 맡길 수 있는 병원 List</p>
				<c:forEach var="hospitalVO" items="${hospitalVos}">
					<section class="wishHospitalInfo">
						<section class="infoSec">
							<p class="cafeNameTxt">${hospitalVO.placeName}<span class="cafeNameAddressTxt">${hospitalVO.sido} ${hospitalVO.sigungu} ${hospitalVO.dong}</span></p>
							<p class="cafeSaveDateTxt">${(hospitalVO.saveDate).substring(0,10)}</p>
						</section>
						<section class="moreBtn"><button onclick="location.href='${ctp}/hospital/hospitalReviewList?idx=${hospitalVO.placeIdx}';" class="moreBtn-1">hospital more</button></section>
					</section>
				</c:forEach>
				<!-- 블록페이지 시작 -->
				<div class="text-center">
				  <ul class="pagination justify-content-center">
					  <c:if test="${pageVOh.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=1&pageSize=${pageVOh.pageSize}">첫페이지</a></li></c:if>
					  <c:if test="${pageVOh.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${(pageVOh.curBlock-1)*pageVOh.blockSize + 1}&pageSize=${pageVOh.pageSize}">이전블록</a></li></c:if>
					  <c:forEach var="i" begin="${(pageVOh.curBlock*pageVOh.blockSize)+1}" end="${(pageVOh.curBlock*pageVOh.blockSize) + pageVOh.blockSize}" varStatus="st">
					    <c:if test="${i <= pageVOh.totPage && i == pageVOh.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="wishPlace?mid=${sMid}&pag=${i}&pageSize=${pageVOh.pageSize}">${i}</a></li></c:if>
					    <c:if test="${i <= pageVOh.totPage && i != pageVOh.pag}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${i}&pageSize=${pageVOh.pageSize}">${i}</a></li></c:if>
					  </c:forEach>
					  <c:if test="${pageVOh.curBlock < pageVOh.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${(pageVOh.curBlock+1)*pageVOh.blockSize+1}&pageSize=${pageVOh.pageSize}">다음블록</a></li></c:if>
					  <c:if test="${pageVOh.pag < pageVOh.totPage}"><li class="page-item"><a class="page-link text-secondary" href="wishPlace?mid=${sMid}&pag=${pageVOh.totPage}&pageSize=${pageVOh.pageSize}">마지막페이지</a></li></c:if>
				  </ul>
				</div>
				<!-- 블록페이지 끝 -->
			</section>	
			
		</div>
	</div><!-- inner 끝  -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>