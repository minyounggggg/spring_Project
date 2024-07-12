<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberMypage</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	
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
			height : 180px;
			margin-bottom : 20px;
		}
		.profile-box{
			width : 69%;
			margin-right : 1%;
			float : left;
			padding : 30px;
			height : 180px;
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
			padding : 30px;
			height : 180px;
		}
		.point-box .point-icon{
			float : left;
			width : 40%;
		}
		.point-box .point-info{
			float : left;
			width : 60%;
		}
		.pet-box{
			width : 350px;
			height : 200px;
			padding : 30px;
			margin-right : 20px;
		}
		.pet-box .pet-profile{
			width : 36%;
			/* box-shadow : 5px 10px 8px rgba(0, 0, 50, 0.1); */
		    overflow:hidden;
		    float : left;
		}
		.pet-box .pet-profile img{
			border-radius : 100px;
			width : 100px;
			height : 100px;
			object-fit: cover;
		}
		.pet-box .pet-info{
			float : left;
			width : 64%;
			margin-top : 14px;
		}
		.pet-insertBox{
			display : flex;
			justify-content: center;
			align-items: center;
			width : 410px;
			height : 260px;
			margin-right : 5px;
		}
		
	</style>
	<!-- swiper css -->
	<style>
	    .swiper {
	      width: 100%;
	      height: 300px;
	    }
	    .swiper-slide {
	      /* text-align: center; */
	      /* font-size: 18px; */
	      width: 30%;
	      /* 
	      display: flex;
	      justify-content: center;
	      align-items: center;
	       */
	    }
	    .swiper-slide img {
	    /* 
	      display: block;
	      width: 100%;
	      height: 100%;
	      object-fit: cover;
	       */
	    }
	    /* 모달 css */
		#myModal1{
    		background-color: rgba(0,0,0,0.3);
    	}
    	#myModal1 .modal-content{
    		background-color: transparent;
    		border: none;
    	}
    	#myModal1 .modal-dialog {
	        width : 400px;
	    }
	    #myModal1 .modal-header{
	    	border: none;
	    	margin-bottom: 10px;
	    }
	    #myModal1 button.close{
	    	background-color: #fff;
	    	border-radius: 100px;
	    }
	    
		#myModal1 .modal-profile-box{
			width : 100%;
			padding : 35px 50px;
			/* height : 180px; */
		}
		.modal-profile-box .modal-profile{
			/* box-shadow : 5px 10px 8px rgba(0, 0, 50, 0.1); */
			width : 100%;
		    overflow:hidden;
	        text-align: center;
            margin-bottom: 20px;
		}
		.modal-profile-box .modal-profile img{
			border-radius : 100px;
			width : 180px;
			height : 180px;
			object-fit: cover;
		}
		.modal-profile-box .modal-info{
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
	</style>
	
	<script>
		'use stript';
		
		function memberUpdate() {
			
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
	
		<div class="sec01">
			<div class="profile-box sec-boxStyle">
				<section class="profile">
					<img src="${ctp}/resources/data/member/${vo.photo}"/>
				</section>
				<section class="info">
					<p style="font-size:26px;font-weight:700;color:#444;margin:0 0 5px">${vo.nickName}</p>
					<p><img src="${ctp}/resources/images/memberMypage/place.png" style="width:20px;margin-right:5px;"/>${vo.address}</p>
					<p>안녕하세용 &nbsp;&nbsp;|&nbsp;&nbsp; <a href="javascript:memberUpdate()" data-toggle="modal" data-target="#myModal1">수정하기</a></p> 
				</section>
			</div>
			<div class="point-box sec-boxStyle">
				<section class="point-icon">
					<img src="${ctp}/resources/images/memberMypage/cherry001.jpg" style="width:110px;border-radius:100px;box-shadow : 5px 8px 5px rgba(0, 0, 50, 0.1);"/>
				</section>
				<section class="point-info text-right" style="padding-right:10px;">
					<p style="font-size:18px;font-weight:500;color:#444;margin:0 0 5px">내가 수확한 체리</p>
					<p style="font-size:24px;font-weight:700;color:#444;margin:0;"><img src="${ctp}/resources/images/memberMypage/cherry001.jpg" style="width:30px;margin-right:5px;"/>${vo.point}</p>
				</section>
			</div>
		</div>
		
		
		<!-- The Modal 회원정보수정 모달 memberUpdate-->
		<div class="modal fade" id="myModal1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
				
					<!-- Modal Header -->
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					
					<!-- Modal body -->
							<div class="modal-profile-box sec-boxStyle">
								<section class="modal-profile">
									<img src="${ctp}/resources/data/member/${vo.photo}"/>
								</section>
								<section class="modal-info">
									<p style="font-size:18px;font-weight:600;color:#888;margin:0"><span style="color:#578de4;">ID _</span> ${vo.mid}</p>
									<p style="font-size:18px;font-weight:600;color:#888;margin:0 0 5px"><span style="color:#578de4;">E-mail _</span> ${vo.email}</p>
									<p style="font-size:12px;color:#555;">* 아이디와 이메일은 서비스 이용과정 인증 절차 등으로 인해 직접 삭제하거나 변경이 불가능합니다.</p>
									<input type="text" id="nickName" name="nickName" class="modal-nick" value="${vo.nickName}"/>
									<input type="text" id="address" name="address" class="modal-address" value="${vo.address}"/>
									<button type="button" class="btn btn-primary form-control" onclick="memberUpdate()">수정하기</button>
								</section>
							</div>
					<!-- 
					Modal footer
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</div>
					 -->
				</div>
			</div>
		</div>
		
		
		<div class="sec02">
			<div class="swiper mySwiper">
				<div class="swiper-wrapper">
					<c:forEach var="pVo" items="${pVos}" varStatus="st">
						<div class="swiper-slide">
							<div class="pet-box sec-boxStyle">
								<section class="pet-profile">
									<img src="${ctp}/resources/data/member/${pVo.petPhoto}"/>
								</section>
								<section class="pet-info">
									<p style="font-size:26px;font-weight:700;color:#444;margin:0 0 5px">${pVo.petName} <span style="font-size:16px;font-weight:400;color:#444;">· ${pVo.petGender}</span></p>
									<p style="font-size:18px;"><img src="${ctp}/resources/images/memberMypage/birthday-icon.png" style="width:24px;margin:0 5px 5px 0;"/>${pVo.petBirthday}</p>
								</section>
								<hr style="clear:both;margin-top:40px"/>
								<section>
									<p>${pVo.petInfo}</p>
									<p>${pVo.playWith}</p>
								</section>
							</div>
						</div>
					</c:forEach>
					<div class="swiper-slide">
						<section class="pet-insertBox sec-boxStyle">
							<p><img src="${ctp}/resources/images/memberMypage/add.png" style="width:30px;margin-right:10px;border-radius:100px;background-color:#fff;"/></p>
							<p>반려동물 프로필 추가하기</p>
						</section>
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
			      spaceBetween: 40,
			      freeMode: true,
			      scrollbar: {
				          el: ".swiper-scrollbar",
				          hide: true
					  }
			  /* 
			      pagination: {
				          el: ".swiper-pagination",
				          clickable: true
				        }
			   */
				  });
			</script>
		  <%-- 
			<section class="pet-insertBox sec-boxStyle">
				<p><img src="${ctp}/resources/images/memberMypage/add.png" style="width:30px;margin-right:10px;border-radius:100px;background-color:#fff;"/></p>
				<p>반려동물 프로필 추가하기</p>
			</section>
			 --%>
		</div>
		
	</div>
</body>
</html>