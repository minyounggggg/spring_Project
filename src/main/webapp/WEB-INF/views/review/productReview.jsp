<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productReview.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="icon" href="${ctp}/resources/favicon/love.png">

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
		.inner {width : 1300px; margin : 0 auto; padding-top:150px;}
		.sec01{padding-bottom:40px;}
		.sec01 .petCategory{
			float : left;
		}
		.sec01 .productCategory{
			float : left;
		}
		.sec01 .listCategory{
			float : right;
		}
		.reviewSec{
			background-color : #f9f9f9;
			border-radius : 30px;
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
			padding : 30px 55px;
			width : 630px;
			display: inline-block;
			float : left;
			margin : 10px;
		}
		.sec02 .reviewNickName{
			font-size: 18px;
		    margin-left: 15px;
		    font-weight: 600;
		    color: #444;
		}
		.sec02 .reviewUploadDate{
			margin-right : 10px;
			color: #999;
		}
		.sec02 .petCategoryVal, .productCategoryVal{
		    margin-left: 5px;
		    border-radius: 50px;
		    border: solid 1px #578de4;
		    padding: 3px 12px;
		    color: #578de4;
		    font-size: 14px;
    		font-weight: 600;
		}
		.sec02 .reviewSecInfo{float:left;width:80%;}
		.sec02 .reviewSecMore{float:left;width:20%;text-align: right;}
		.sec02 .productInfo{float:left;width:50%;}
		.sec02 .HeartPoint{float:left;width:50%;}
		.sec02 .memberHeart, .sec02 .petHeart {
		    border: solid 2px #FF2121;
		    border-radius: 50px;
		    padding: 1px 10px;
		    width: fit-content;
		}
		.sec02 .goodtxt, .sec02 .badtxt{
			border-radius: 50px;
		    background-color: #578de430;
		    color: #3174df;
		    font-size: 15px;
		    font-weight: 600;
		    padding: 3px 15px;
		}
		.sec02 .badtxt{background-color: #99999933; color: #999999;}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div class="sec01">
			<section>
				<select class="petCategory">
					<option value="모든동물" selected>모든동물</option>
					<option value="강아지">강아지</option>
					<option value="고양이">고양이</option>
					<option value="기타동물">기타동물</option>
				</select>
			</section>
			<section>
				<select class="productCategory">
					<option value="모든제품" selected>모든제품</option>
					<option value="사료">사료</option>
					<option value="간식">간식</option>
					<option value="장난감">장난감</option>
					<option value="영양제">영양제</option>
					<option value="용품">용품</option>
				</select>
			</section>
			<section>
				<select class="listCategory" id="listCategory">
					<option value="최신순" selected>최신순</option>
					<option value="OK">재구매 할래요</option>
					<option value="NO">재구매 안할래요</option>
					<option value="Um">재구매 고민중</option>
				</select>
			</section>
		</div>
		<div class="sec02">
			<c:forEach var="reviewVo" items="${reviewVos}" varStatus="st">
				<div class="reviewSec">
					<section class="reviewSecInfo">
						<p><img src="${ctp}/resources/data/member/${reviewVo.photo}" style="width:60px;"/>
						<span class="reviewNickName">${reviewVo.nickName} · </span>
						<span class="reviewUploadDate">${(reviewVo.uploadDate).substring(11,16)}</span>
						<span class="petCategoryVal">${reviewVo.petCategory}</span>
						<span class="productCategoryVal">${reviewVo.productCategory}</span></p>
					</section>
					<section class="reviewSecMore">
						···
					</section>
					<hr style="clear:both;"/>
					<section class="productInfo">
						<p class="productBrand" style="color:#578de4;font-size:17px;font-weight: 700;margin:0 0 0 1px;">${reviewVo.brand}</p>
						<p class="productName" style="font-size:25px;font-weight:600;color:#333;">${reviewVo.productName}</p>
						<img src="${ctp}/resources/data/productReview/${reviewVo.productPhoto}" style="width:120px;border-radius:15px;margin: 0 10px 20px 0;"/>
					</section>
					<section class="HeartPoint">
						<section style="margin-bottom:10px;">
							<span style="color: #636363; font-size: 14px; font-weight: 500; margin:0 5px;">반려인 </span>
							<span class="memberHeart">
								<c:forEach var="i" begin="1" end="${reviewVo.memberHeart}" varStatus="iSt"><font color="#FF2121">❤︎</font></c:forEach>
								<c:forEach var="i" begin="1" end="${5 - reviewVo.memberHeart}" varStatus="iSt"><font color="#FFBDBD">❤︎</font></c:forEach>
							</span>
						</section>
						<section>
							<span style="color: #636363; font-size: 14px; font-weight: 500; margin:0 5px;">반려동물 </span>
							<span class="petHeart">
								<c:forEach var="i" begin="1" end="${reviewVo.petHeart}" varStatus="iSt"><font color="#FF2121">❤︎</font></c:forEach>
								<c:forEach var="i" begin="1" end="${5 - reviewVo.petHeart}" varStatus="iSt"><font color="#FFBDBD">❤︎</font></c:forEach>
							</span>
						</section>
						<section class="gbPoint" style="margin-top:30px;">
							<span class="goodtxt">이런 점이 좋아요</span>
							<p style="font-size: 14px; color: #999; margin: 10px 0 20px 9px;">제품 후기 자세히보기 ></p>
							<span class="badtxt">이런 점이 아쉬워요</span>
							<p style="font-size: 14px; color: #999; margin: 10px 0 20px 9px;">제품 후기 자세히보기 ></p>
						</section>
					</section>
					<hr style="clear:both;"/>
					<section class="reviewHeart">
						<span style="font-size:15px;margin-right:15px;"><img src="${ctp}/resources/images/icon/love.png" style="width:25px;margin: 0 5px 5px 0;"/>${reviewVo.goodHeart}</span>
						<span style="font-size:15px;"><img src="${ctp}/resources/images/icon/speech-bubble.png" style="width:25px;margin: 0 5px 5px 0;"/>${reviewVo.commentCnt}</span>
					</section>
				</div>
			</c:forEach>	
		</div>
	</div>
	<div class="insertNav" style="bottom: 60px; right: 70px; position: fixed;">
		<section><a href="javascript:"><img src="${ctp}/resources/images/icon/insertBtn.png" style="width:90px;"/></a></section>
		<section><a href="#listCategory"><img src="${ctp}/resources/images/icon/topBtn.png" style="width:90px;"/></a></section>
	</div>
</body>
</html>