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
		/* p {margin:0;} */
		.inner {width : 1300px; margin : 0 auto; padding-top:150px;}
		.sec-boxStyle{
			background-color : #f9f9f9;
			border-radius : 30px;
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
		}
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
			padding : 30px 45px;
			width : 630px;
			/* display: inline-block; */
			float : left;
			margin : 10px;
			cursor: pointer;
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
		    /* margin-left: 5px; */
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
		    border: solid 1px #FF2121;
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
	    
	    .productImgSec {
		    width:270px;
		    height:140px;
		    overflow:hidden;
		    margin:0 auto;
		}
		.productImg {
		    width:100%;
		    height:100%;
		    object-fit:cover;
		}
	</style>
	<script>
		// 파일선택시 파일명 출력
		$(window).on('load', function() {
		    fileCus();
		})
	
		function fileCus() {
		    $(".file_cus input[type=file]").on("change", function() {
		        const fileName = $(this).val().split("\\").pop();
		        $(this).siblings(".file_name").text(fileName || "사진을 선택해주세요!!");
		    });
		}
		
		let imgFiles = [];
		
		$(document).ready(function() {
			$("#file").on("change", function(e) {
				$(".swiper-wrapper").empty();
				
				let files = e.target.files;
				let filesArr = Array.prototype.slice.call(files);
				
				let idx = 0;
				filesArr.forEach(function(f) {
					if(!f.type.match("image.*")){
						alert("이미지파일만 업로드하실 수 있습니다.");
						return false;
					}
					imgFiles.push(f);
				
					let reader = new FileReader();
					reader.onload = function(e) {
						let str = "<div class='swiper-slide' id='imgId"+idx+"'><a href='javascript:void(0);' onclick='deleteImage("+idx+")' ><img src='"+e.target.result+"' data-file='"+f.name+"' title='그림을 클릭하시면 제거됩니다.("+idx+")'/></a></div>";
						$(".swiper-wrapper").append(str);
						idx++;
					}
					reader.readAsDataURL(f);	// readAsDataURL는 예약어
				});
			});
		});
		
		function deleteImage(idx) {
			imgFiles.slice(idx,1);
			
			let imgId = "#imgId" + idx;
			$(imgId).remove();
		}
		
		function productReviewInsertOK() {
			let petCategory = productReviewInsertForm.petCategory.value;
			let productCategory = productReviewInsertForm.productCategory.value;
			let brand = productReviewInsertForm.brand.value;
			let productName = productReviewInsertForm.productName.value;
			let memberHeart = productReviewInsertForm.memberHeart.value;
			let petHeart = productReviewInsertForm.petHeart.value;
			let goodPoint = productReviewInsertForm.goodPoint.value;
			let badPoint = productReviewInsertForm.badPoint.value;
			let file = productReviewInsertForm.file.value;
			let repurchase = productReviewInsertForm.repurchase.value;
			/* 
			if(petCategory==""){
				alert("제품을 사용한 반려동물의 종류를 선택해주세요!");
				productReviewInsertForm.petCategory.focus;
				return false;
			}
			 */
			if(productCategory==""){
				alert("제품의 종류를 선택해주세요!");
				productReviewInsertForm.productCategory.focus;
				return false;
			}
			else if(brand==""){
				alert("제품의 브랜드를 작성해주세요!");
				productReviewInsertForm.brand.focus;
				return false;
			}
			else if(productName==""){
				alert("제품명을 작성해주세요!");
				productReviewInsertForm.productName.focus;
				return false;
			}
			else if(memberHeart==""){
				alert("제품에 대한 반려인의 만족도를 체크해주세요!");
				productReviewInsertForm.memberHeart.focus;
				return false;
			}
			else if(petHeart==""){
				alert("제품에 대한 반려동물의 선호도를 체크해주세요!");
				productReviewInsertForm.petHeart.focus;
				return false;
			}
			else if(goodPoint==""){
				alert("제품의 좋았던 점을 작성해주세요!");
				productReviewInsertForm.goodPoint.focus;
				return false;
			}
			else if(badPoint==""){
				alert("제품의 아쉬웠던 점을 작성해주세요!");
				productReviewInsertForm.badPoint.focus;
				return false;
			}
			else if(repurchase==""){
				alert("제품의 재구매 여부를 체크해주세요!");
				productReviewInsertForm.repurchase.focus;
				return false;
			}
			
			if(imgFiles.length<1){
				alert("제품 인증을 위해 1개 이상의 사진을 업로드해주세요!");
				return false;
			}
			else if(file == ""){
				alert("제품 인증을 위해 1개 이상의 사진을 업로드해주세요!");
				return false;
			}
			
			let imgNames = "";
			for (let i=0; i<imgFiles.length; i++){
				imgNames += imgFiles[i].name + "/";
			}
			imgNames = imgNames.substring(0, imgNames.length-1);
			//$("#pdPhoto").val(imgNames);
			productReviewInsertForm.pdPhoto.value = imgNames;
			console.log(pdPhoto);
			
			productReviewInsertForm.submit();
		}
		/* 
		function petCategoryOp(obj) {
			var petCategorySelect = obj.value;
			$.ajax({
				url : "${ctp}/review/petCategoryCheck",
				type : "post",
				data : {petCategorySelect : petCategorySelect},
				success : function(res) {
					if(res != "0") location.reload();
					else alert("오류발생! 다시 시도해주세요.");
				},
				error : function() {
					alert("전송실패");
				}
			});
		}
		 */
		 
		function partCheck() {
			let part = $("#part").val();
			location.href = "productReview?pag=${pag}&pageSize=${pageSize}&part="+part;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<div class="sec01">
			<!--
			<section>
				<select class="petCategory" onchange="petCategoryOp(this)">
					<option value="모든동물">모든동물</option>
					<option value="강아지">강아지</option>
					<option value="고양이">고양이</option>
					<option value="기타동물">기타동물</option>
				</select>
			</section>
				-->
			<section>
				<form name="partForm">
					<select name="part" id="part" onchange="partCheck()">
					<option ${pageVO.part == "모든제품" ? "selected" : ""}>모든제품</option>
					<option ${pageVO.part == "사료" ? "selected" : ""}>사료</option>
					<option ${pageVO.part == "간식" ? "selected" : ""}>간식</option>
					<option ${pageVO.part == "장난감" ? "selected" : ""}>장난감</option>
					<option ${pageVO.part == "영양제" ? "selected" : ""}>영양제</option>
					<option ${pageVO.part == "용품" ? "selected" : ""}>용품</option>
					</select>
				</form>
			</section>
			<!--
			<section>
				<select class="listCategory" id="listCategory">
					<option value="최신순" selected>최신순</option>
					<option value="OK">재구매 할래요</option>
					<option value="NO">재구매 안할래요</option>
					<option value="Um">재구매 고민중</option>
				</select>
			</section>
				-->
		</div>
		<div class="sec02">
			<c:forEach var="reviewVo" items="${reviewVos}" varStatus="st">
				<div class="reviewSec" onclick="location.href='productReviewContent?idx=${reviewVo.idx}';">
					<section class="reviewSecInfo">
						<p><img src="${ctp}/resources/data/member/${reviewVo.photo}" style="width:60px;height:60px;object-fit:cover;border-radius: 50px;"/>
						<span class="reviewNickName">${reviewVo.nickName} · </span>
						<span class="reviewUploadDate">${(reviewVo.uploadDate).substring(0,10)}</span>
						<span class="petCategoryVal">${reviewVo.petCategory}</span>
						<span class="productCategoryVal">${reviewVo.productCategory}</span></p>
					</section>
					<section class="reviewSecMore"> 
						···
					</section>
					<hr style="clear:both;"/>
					
					<section class="HeartPoint">
						<section style="margin-bottom:10px;">
							<span style="color: #636363; font-size: 14px; font-weight: 500; margin:0 5px;">반려인 &nbsp;&nbsp;</span>
							<span class="memberHeart">
								<c:forEach var="i" begin="1" end="${reviewVo.memberHeart}" varStatus="iSt"><font color="#EB403D">❤︎</font></c:forEach>
								<c:forEach var="i" begin="1" end="${5 - reviewVo.memberHeart}" varStatus="iSt"><font color="#FFBDBD">❤︎</font></c:forEach>
							</span>
						</section>
						<section>
							<span style="color: #636363; font-size: 14px; font-weight: 500; margin:0 5px;">반려동물 </span>
							<span class="petHeart">
								<c:forEach var="i" begin="1" end="${reviewVo.petHeart}" varStatus="iSt"><font color="#EB403D">❤︎</font></c:forEach>
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
					<section class="productInfo">
						<p class="productBrand" style="color:#578de4;font-size:17px;font-weight: 700;margin:0 0 0 1px;">${reviewVo.brand}</p>
						<p class="productName" style="font-size:25px;font-weight:600;color:#333;">${reviewVo.productName}</p>
						<section class="productImgSec">
							<c:set var="productPhotos" value="${fn:split(reviewVo.productPhoto, '/')}"/>
							<span class="productImg">
								<c:forEach var="productPhoto" items="${productPhotos}">
									<img src="${ctp}/resources/data/productReview/${productPhoto}" style="width:120px;height:120px;border-radius:15px;margin: 0 5px 20px 0;object-fit: cover;"/>
								</c:forEach>
							</span>
						</section>
					</section>
					
					<hr style="clear:both;"/>
					<section class="reviewHeart">
						<span style="font-size:15px;margin-right:15px;"><img src="${ctp}/resources/images/icon/love.png" style="width:25px;margin: 0 5px 5px 0;"/>${reviewVo.goodHeart}</span>
						<span style="font-size:15px;margin-right:15px;"><img src="${ctp}/resources/images/icon/speech-bubble.png" style="width:25px;margin: 0 5px 5px 0;"/>${reviewVo.commentCnt}</span>
						<span style="font-size:15px;"><img src="${ctp}/resources/images/icon/visibility.png" style="width:25px;margin: 0 5px 5px 0;"/>${reviewVo.readNum}</span>
					</section>
				</div>
			</c:forEach>	
		</div>
		
		<!-- 블록페이지 시작! -->
		<div class="text-center" style="clear:both;padding:70px 0;">
			<ul class="pagination justify-content-center">
			<c:if test="${pageVO.pag > 1 }"><li class="page-item"><a class="page-link text-secondary" href="productReview?pag=1&pageSize=${pageVO.pageSize}">첫 페이지</a></li></c:if>
			<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="productReview?pag=${(pageVO.curBlock-1) * pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
			<c:forEach var="i" begin="${(pageVO.curBlock * pageVO.blockSize)+1}" end="${(pageVO.curBlock * pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
				<!-- 현재있는 페이지 수만 굵게 표시한다. -->
				<c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="productReview?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if> 
				<!-- 현재있는 페이지가 아닌 숫자는 일반 표시, 두껍게 하지 않는다. -->
				<c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="productReview?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
			</c:forEach>
			<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="productReview?pag=${(pageVO.curBlock+1) * (pageVO.blockSize+1)}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
			<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="productReview?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막 페이지</a></li></c:if>
			</ul>
		</div>
		<!-- 블록페이지 끝! -->
		
	</div>
	<div class="insertNav" style="bottom: 60px; right: 70px; position: fixed;">
		<section data-toggle="modal" data-target="#insertModal"><img src="${ctp}/resources/images/icon/insertBtn.png" style="margin-bottom:10px;width:80px;cursor:pointer;"/></section>
		<section><a href="#"><img src="${ctp}/resources/images/icon/topBtn.png" style="width:80px;"/></a></section>
	</div>
	
	
	<!-- 제품후기 insert 모달-->
	<div class="modal fade" id="insertModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<form name="productReviewInsertForm" method="post" action="productReviewInsert" enctype="multipart/form-data">
					<div class="modal-profile-box sec-boxStyle">
					
						<p style="font-size:14px;color:#444;margin:10px 0 0;">* 반려동물</p>
						<div class="form-group">
							<div class="check-box" id="check-box">
								<input type="checkbox" class="check-box-input" value="강아지" id="petCategory1" name="petCategory"/>
								<label for="petCategory1">강아지</label>
								<input type="checkbox" class="check-box-input" value="고양이" id="petCategory2" name="petCategory"/>
								<label for="petCategory2">고양이</label>
								<input type="checkbox" class="check-box-input" value="기타동뮬" id="petCategory3" name="petCategory"/>
								<label for="petCategory3">기타동뮬</label>
							</div>
						</div>
					
						<p style="font-size:14px;color:#444;margin:10px 0 0;">* 제품종류</p>
						<div class="form-group">
							<div class="radio-box" id="radio-box">
								<input type="radio" class="check-box-input" value="사료" id="productCategory1" name="productCategory" checked/>
								<label for="productCategory1">사료</label>
								<input type="radio" class="check-box-input" value="간식" id="productCategory2" name="productCategory"/>
								<label for="productCategory2">간식</label>
								<input type="radio" class="check-box-input" value="장난감" id="productCategory3" name="productCategory"/>
								<label for="productCategory3">장난감</label>
								<input type="radio" class="check-box-input" value="영양제" id="productCategory4" name="productCategory"/>
								<label for="productCategory4">영양제</label>
								<input type="radio" class="check-box-input" value="용품" id="productCategory5" name="productCategory"/>
								<label for="productCategory5">용품</label>
								<input type="radio" class="check-box-input" value="기타" id="productCategory6" name="productCategory"/>
								<label for="productCategory6">기타</label>
							</div>
						</div>
						<section style="width:50%;float:left;padding-right:5px;">
							<p style="font-size:14px;color:#444;margin:10px 0 0;"><span style="color:#578de4;">*</span> 제품 브랜드</p>
							<input type="text" id="brand" name="brand" class="modal-petName form-control" required />
						</section>
						<section style="width:50%;float:left;padding-left:5px;">
							<p style="font-size:14px;color:#444;margin:10px 0 0;"><span style="color:#578de4;">*</span> 제품명</p>
							<input type="text" id="productName" name="productName" class="modal-petName form-control" required />
						</section>
						
						<section id="HeartInsert" style="width:100%;clear:both;">
							<fieldset style="border:0px;">
								<section style="width:50%;float:left;padding-right:5px;">
									<span class="HeartInsertBar">
										<input type="radio" name="memberHeart" value="5" id="memberHeart1"/><label for="memberHeart1">❤︎</label>
										<input type="radio" name="memberHeart" value="4" id="memberHeart2"/><label for="memberHeart2">❤︎</label>
										<input type="radio" name="memberHeart" value="3" id="memberHeart3"/><label for="memberHeart3">❤︎</label>
										<input type="radio" name="memberHeart" value="2" id="memberHeart4"/><label for="memberHeart4">❤︎</label>
										<input type="radio" name="memberHeart" value="1" id="memberHeart5" checked/><label for="memberHeart5">❤︎</label>
									</span>
									<span style="font-size:14px;color:#444;margin:10px 0 0;"> 반려인 만족도 <span style="color:#578de4;">*</span></span>
								</section>
								<section style="width:50%;float:left;padding-left:5px;">
									<span class="HeartInsertBar">
										<input type="radio" name="petHeart" value="5" id="petHeart1"/><label for="petHeart1">❤︎</label>
										<input type="radio" name="petHeart" value="4" id="petHeart2"/><label for="petHeart2">❤︎</label>
										<input type="radio" name="petHeart" value="3" id="petHeart3"/><label for="petHeart3">❤︎</label>
										<input type="radio" name="petHeart" value="2" id="petHeart4"/><label for="petHeart4">❤︎</label>
										<input type="radio" name="petHeart" value="1" id="petHeart5" checked/><label for="petHeart5">❤︎</label>
									</span>
									<span style="font-size:14px;color:#444;margin:10px 0 0;">반려동물 선호도 <span style="color:#578de4;">*</span></span>
								</section>
							</fieldset>
						</section>
						<section style="width:50%;float:left;padding-right:5px;">
							<p style="font-size:14px;color:#444;margin:5px 0 0;"><span style="color:#578de4;">*</span> 추천하고싶은 부분</p>
							<textarea rows="3" name="goodPoint" id="goodPoint" class="modal-goodPoint form-control"></textarea>
						</section>
						<section style="width:50%;float:left;padding-left:5px;margin-bottom:15px;">
							<p style="font-size:14px;color:#444;margin:5px 0 0;"><span style="color:#578de4;">*</span> 아쉬웠던 부분</p>
							<textarea rows="3" name="badPoint" id="badPoint" class="modal-badPoint form-control"></textarea>
						</section>
						<section class="file_cus" style="clear:both;margin-top:10px;">
						    <label>
						        <input type="file" name="fName" id="file" multiple accept=".jpg, .gif, .png" />
						        <span class="file_name" id="file_name"><span style="color:#578de4;">*</span> 제품 사진을 선택해주세요.</span>
						        <span class="file_btn">사진선택</span>
						    </label>
						</section>
						<%-- 
						<section class="modal-profile">
							<img id="photoDemo" src="${ctp}/resources/data/productReview/productNoimage.png"/>
						</section>
						 --%>
						<!-- <section class="modal-profile"> -->
						<section class="swiper-modal-box">
							 <!-- Swiper -->
							  <div class="swiper mySwiper">
							    <div class="swiper-wrapper">
							      <div class="swiper-slide">
							      	<img id="photoDemo" src="${ctp}/resources/data/productReview/productNoimage.png"/>
							      </div>
							    </div>
							    <div class="swiper-scrollbar"></div>
							  </div>
							
							  <!-- Swiper JS -->
							  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
							
							  <!-- Initialize Swiper -->
							  <script>
								  var swiper = new Swiper(".mySwiper", {
									  slidesPerView: "auto",
								      /* spaceBetween: 40, */
								      freeMode: true,
								      scrollbar: {
									          el: ".swiper-scrollbar",
									          hide: true
											}
							    });
							  </script>
						</section>
						
						<p style="font-size:14px;color:#444;margin:10px 0 0;"><span style="color:#578de4;">*</span> 재구매의사</p>
						<div class="form-group">
							<div class="radio-box" id="repurchaseRadio-box">
								<input type="radio" class="check-box-input" value="OK" id="repurchase1" name="repurchase"/>
								<label for="repurchase1">네</label>
								<input type="radio" class="check-box-input" value="NO" id="repurchase2" name="repurchase"/>
								<label for="repurchase2">아니요</label>
								<input type="radio" class="check-box-input" value="Um" id="repurchase3" name="repurchase"/>
								<label for="repurchase3">고민중입니다</label>
							</div>
						</div>
						
						<section class="modal-info">
							<button type="button" class="petInsertOkBtn" onclick="productReviewInsertOK()">등록하기</button>
						</section>
						
						<input type="hidden" name="mid" value="${sMid}"/>
						<input type="hidden" name="nickName" value="${sNickName}"/>
						<input type="hidden" name="photo" value="${sPhoto}"/>
						<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
						<input type="hidden" name="pdPhoto" id="pdPhoto"/>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		$('#insertModal').on('hidden.bs.modal', function (e) {
			$(this).find('form')[0].reset();
			$(this).find('#file_name').text('제품 사진을 선택해주세요.');
			$(this).find('.swiper-wrapper').html('<div class="swiper-slide"><img id="photoDemo" src="${ctp}/resources/data/productReview/productNoimage.png"/></div>');
			$(this).find('#file').empty();
			console.log(file.value);
		});
		/* 
		$(document).ready(function() {
          $('#insertModal').on('hidden.bs.modal', function() {
        	  $('input#file').val('');
            });
        });
		  */
	</script>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>