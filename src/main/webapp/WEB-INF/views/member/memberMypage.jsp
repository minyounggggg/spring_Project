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
		    border: dashed 2px #578de4;
			width : 410px;
		    height: 310px;
			margin-right : 5px;
			cursor:pointer;
		}
		
	</style>
	<!-- swiper css -->
	<style>
	    .swiper {
	      width: 100%;
	      height: 350px;
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
	    .swiper-scrollbar-drag{background: var(--swiper-scrollbar-drag-bg-color, rgba(87, 141, 228, 1));}
	    
	    /* 모달 css */
		#myModal1{
    		background-color: rgba(0,0,0,0.3);
    	}
    	#myModal1 .modal-content, #myModal2 .modal-content{
    		background-color: transparent;
    		border: none;
    	}
    	#myModal1 .modal-dialog {
	        width : 400px;
	    }
	    #myModal1 .modal-header, #myModal2 .modal-header{
	    	border: none;
	    	margin-bottom: 10px;
	    }
	    #myModal1 button.close, #myModal2 button.close{
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
		}
		.modal-profile-box .modal-profile img{
			border-radius : 100px;
			width : 180px;
			height : 180px;
			object-fit: cover;
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
		
		#myModal2 .modal-profile-box{
			width : 100%;
			padding : 35px 50px;
		}
		
		/* 사진파일업로드 css */
		.file_cus label {display: block; width: 100%; margin: 15px 0 20px; font-size: 0; cursor: pointer;}
		input[type="file"] {overflow: hidden;position: absolute;width: 1px;height: 1px;margin: -1px;font-size: initial;clip: rect(0 0 0 0);}
		.file_name {
			overflow: hidden; display: inline-block;
			vertical-align: middle; width: calc(100% - 108px);
			height: 40px; padding:0 12px; border: 1px solid #ddd;
			border-radius:4px; font-size: 14px; line-height: 38px;
			color: #111; white-space: nowrap; text-overflow: ellipsis;
		}
		.file_btn {
			display: inline-block; vertical-align: middle;
			width: 100px; height: 40px; margin-left: 8px;
			background: #578de4; border-radius:4px; font-size: 14px;
			font-weight: 500; line-height: 40px; color: #fff; text-align: center;
		}
		input[type="file"]:focus-visible ~ .file_btn, .file_cus:hover .file_btn {background: #3478db;}

		.petInsertOkBtn {
		    background-color: #578de4;
		    border-color: #578de4;
		    margin-top: 25px;
		    padding: 10px 0 10px;
		    width : 100%;
		    border-radius: 3px;
		    border: none;
		    color: #fff;
		}
		.petInsertOkBtn:hover {background-color: #3478db;}
	</style>
	
	<script>
		
		// 파일선택시 파일명 출력
		$(window).on('load', function() {
		    fileCus();
		})
	
		function fileCus() {
		    $(".file_cus input[type=file]").on("change", function() {
		        const fileName = $(this).val().split("\\").pop();
		        $(this).siblings(".file_name").text(fileName || "사진을 선택해주세요.");
		    });
		}

		// 선택된 사진 미리보기
	    function imgCheck(e) {
	    	if(e.files && e.files[0]) {
	    		let reader = new FileReader();
	    		reader.onload = function(e) {
	    			document.getElementById("photoDemo").src = e.target.result;
	    		}
	    		reader.readAsDataURL(e.files[0]);
	    	}
	    }

		// 반려동물 insert
		function petInsert() {
			let petName = document.getElementById("petName").value.trim();
			
			let fName = document.getElementById("file").value;
			if(fName.trim() != "") {
				let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				let maxSize = 1024 * 1024 * 5;
				let fileSize = document.getElementById("file").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
					alert("그림파일만 업로드 가능합니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 5MByte입니다.");
					return false;
				}
			}
			
			petInsertForm.submit();
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
								<div class="pet-box-margin">
									<section class="pet-profile">
										<img src="${ctp}/resources/data/memberPet/${pVo.petPhoto}"/>
									</section>
									<section class="pet-info">
										<p style="font-size:24px;font-weight:700;color:#444;margin:0 0 5px">${pVo.petName} <span style="font-size:16px;font-weight:400;color:#444;">· ${pVo.petGender}</span></p>
										<p style="font-size:16px;margin:0 0 30px;"><img src="${ctp}/resources/images/memberMypage/birthday-icon.png" style="width:22px;margin:0 5px 5px 0;"/>${pVo.petBirthday}</p>
									</section>
								</div>
								<section>
									<hr style="clear:both;"/>
									<p style="font-size:14px;margin:0 0 5px;color:#777;"><img src="${ctp}/resources/images/memberMypage/speech-balloon.png" style="width:20px;margin:0 5px 5px 0;">우리 애기는 ...</p>
									<p>${pVo.petInfo}</p>
									<p style="font-size:14px;margin:0 0 5px;color:#777;"><img src="${ctp}/resources/images/memberMypage/person-running.png" style="width:20px;margin:0 5px 5px 0;">함께하고싶은 동네 생활이 있어요!</p>
									<p style="margin:0">${pVo.playWith}</p>
								</section>
							</div>
						</div>
					</c:forEach>
					<div class="swiper-slide">
						<section class="pet-insertBox sec-boxStyle" data-toggle="modal" data-target="#myModal2">
							<div><img src="${ctp}/resources/images/memberMypage/add.png" style="width:30px;margin-right:10px;border-radius:100px;background-color:#fff;"/></div>
							<div>반려동물 프로필 추가하기</div>
						</section>
					</div>
				</div>
				<div class="swiper-scrollbar"></div>
			</div>
			
			
			<!-- The Modal 반려동물 insert 모달-->
			<div class="modal fade" id="myModal2">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal body -->
						<form name="petInsertForm" method="post" action="memberMypagePetInsert" enctype="multipart/form-data">
							<div class="modal-profile-box sec-boxStyle">
								<section class="modal-profile">
									<img id="photoDemo" src="${ctp}/resources/data/memberPet/noimage-pet.png"/>
								</section>
								<!-- 
								<div  class="form-group">
							      회원 사진(파일용량:2MByte이내) :
							      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
							    </div>
							     -->
							    <div class="file_cus">
								    <label>
								        <input type="file" name="fName" id="file" onchange="imgCheck(this)">
								        <span class="file_name">사진을 선택해주세요.</span>
								        <span class="file_btn">사진선택</span>
								    </label>
								</div>
								
								<section class="modal-info">
									<p style="font-size:14px;color:#444;margin:10px 0 0;"><span style="color:#578de4;">*</span> 이름을 알려주세요!</p>
									<input type="text" id="petName" name="petName" class="modal-petName form-control" />
									<div class="form-group">
										<div class="form-check-inline">
											<label class="form-check-label">
												<input type="radio" class="form-check-input" name="petGender" value="남아" checked>남아
											</label>
										</div>
										<div class="form-check-inline">
											<label class="form-check-label">
												<input type="radio" class="form-check-input" name="petGender" value="여아">여아
											</label>
										</div>
										<div class="form-check-inline">
											<label class="form-check-label">
												<input type="radio" class="form-check-input" name="petGender" value="중성화">중성화
											</label>
										</div>
									</div>
									<p style="font-size:14px;color:#444;margin:0;"><span style="color:#578de4;">*</span> 생일을 알려주세요! (추정날짜도 좋아요♥)</p>
									<div class="form-group">
										<input type="date" id="petBirthday" name="petBirthday" value="<%=java.time.LocalDate.now() %>" class="modal-petBirthday form-control"/>
									</div>
									<p style="font-size:14px;color:#444;margin:10px 0 0;"><span style="color:#578de4;">*</span> 반려동물의 간단한 소개부탁해요</p>
									<input type="text" id="petInfo" name="petInfo" class="modal-petInfo form-control" />
									<p style="font-size:14px;color:#444;margin:10px 0 0;">* 반려동물과 함께하고싶은 동네생활이 있나요?</p>
									<input type="text" id="playWith" name="playWith" class="modal-playWith form-control" />
									<button type="button" class="petInsertOkBtn" onclick="petInsert()">등록하기</button>
								</section>
								<input type="hidden" name="petWith" value="${sMid}"/>
							</div>
						</form>
					</div>
				</div>
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