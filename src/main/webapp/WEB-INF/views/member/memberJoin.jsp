<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>memberJoin.jsp</title>
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
	* {font-family: 'Noto Sans KR', sans-serif; }
	a {text-decoration: none; color: inherit;}
	a:link{text-decoration: none;}
	body{
		display : flex;
		justify-content: center;
		/* align-items: center; */
		/* height: 100vh; */
		background-color : #eee;
		/* padding : 110px 0 0; */
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
	.joinForm{
		width : 1200px;
		border-radius : 30px;
		background-color : #f9f9f9;
		box-shadow : 8px 15px 10px rgba(0, 0, 50, 0.1);
		height: 670px;
	    margin-top: 140px;
	}
	.sec01{
		background-image : url("${ctp}/resources/images/memberLogin/login_bg_03.png"); 
		background-color : #999;
		height: 670px;
		border-radius : 30px 0 0 30px;
		
		float : left;
		width : 50%;
		padding : 30px;
	}
	.sec02{
		/* background : url("${ctp}/resources/images/memberLogin/testBG.jpg"); */
		
		float : left;
		width : 50%;
		padding : 60px 60px 50px;
	}
	input::placeholder{color:#ddd !important;font-size: 14px !important;}
	input#mid, #pwd, #nickName, #address, #addressPick, #email1, #email2{
	    border-radius: 50px;
        height: 40px;
        padding: 0 22px;
	    font-size: 15px;
	    color: #333;
	}
	#email1{border-radius: 50px 0 0 50px;}
	#email2{border-radius: 0 50px 50px 0;padding: 0px 25px 0px 15px;}
	label{
		padding-left: 5px;
	    color: #666;
	    font-size: 14px;
	}
	span#addressTxt:hover {
	    cursor: pointer;
	    color: #578de4;
    }
    .idCheckBtnNO, .nickCheckBtnNO, .addressReSearchBtn, .memberJoinNOBtn{
	    padding: 15px 0;
	    width : 100%;
	    border-radius: 50px;
	    border: none;
	    color: #fff;
    }
	.idCheckBtnNO, .nickCheckBtnNO, .addressReSearchBtn{
    	background-color: #777;
	    padding: 7px 20px;
	    margin-left: 10px;
    	font-size: 13px;
    	width : 140px;
    }
    .memberJoinNOBtn{
    	background-color: #ddd;
	    font-size: 18px;
    	font-weight: 600;
	}
    
	.idCheckBtnOK, .nickCheckBtnOK, .addressSearchBtn, .memberJoinOKBtn{
	    background-color: #578de4;
	    padding: 15px 0;
	    width : 100%;
	    border-radius: 50px;
	    border: none;
	    color: #fff;
	}
	.idCheckBtnOK, .nickCheckBtnOK, .addressSearchBtn{
	    padding: 7px 20px;
	    margin-left: 10px;
    	font-size: 13px;
    	width : 140px;
	}
	.memberJoinOKBtn{
	    font-size: 18px;
    	font-weight: 600;
	}
	.idCheckBtnNO:hover {background-color: #666;}
	.nickCheckBtnNO:hover {background-color: #666;}
	.addressReSearchBtn:hover {background-color: #666;}
	.addressSearchBtn:hover {background-color: #3478db;}
	.memberJoinOKBtn:hover {background-color: #3478db;}
	
</style>
<script>
	'use strict';
	
	let addressSw = 0;
	
	function addressSearch() {
		let searchString = document.getElementById("address").value;
		if(searchString.trim()==""){
			alert("주소를 입력해주세요");
			document.getElementById("address").focus();
			return false;
		}
		$('#spinnerIcon').show();
		//https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+(page*15+1)+"&where=web
		//https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%9D%B8%EC%82%AC%EC%9D%B4%EB%93%9C
		//https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%95%95%EA%B5%AC%EC%A0%95
		//https://species.nibr.go.kr/endangeredspecies/rehome/survey/popup_gov_area2.jsp
		let search = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+searchString;
		let searchSelector = "div.m8nnz";
		
		$.ajax({
			url : "${ctp}/member/memberAddressSearchOK",
			type : "post",
			data : {search:search, searchSelector : searchSelector},
			success : function (vos) {
				if(vos != ""){
					let str = '';
					for(let i=0; i<vos.length; i++) {
						str += vos[i] + "<br/>";
					}
					$("#demo").html('<span id="addressTxt"><span style="color:#578de4;">⦁ &nbsp;&nbsp;</span>'+str+'</span>');
					$('#addressTxt').click(function() {
						$('.address').val(str.substring(20, str.indexOf('</')));
						$('#addressTxt').hide();
						$('#addressSearchBtn').hide();
						$('#addressReSearchBtn').show();
						$('#address').hide();
						$('#addressPick').show();
						addressSw = 1;
					});
					$('#addressReSearchBtn').click(function() {
						$('#address').show();
						$('#address').val('');
						$('#addressPick').hide();
						$('#addressSearchBtn').show();
						$('#addressReSearchBtn').hide();
						addressSw = 0;
					});
				}
				else $("#demo").html("<span style='color:#666;font-size:14px;'>※ 검색된 자료가 없습니다.<br/>(지역을 좀 더 자세히 적어주세요. (ex.서울특별시 강남구 압구정동...))</span>");
				$('#spinnerIcon').hide();
			},
			error : function () {
				alert("전송오류~!");
			}
		});
	}
	
	
	
	let idCheckSw = 0;
    let nickCheckSw = 0;
	
	function fCheck() {
		// 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
		let regMid = /^[a-zA-Z0-9_]{4,16}$/;			
		
	    // 닉네임은 한글, 영문대소문자, 숫자, 밑줄만 가능
	    let regNickName = /^[가-힣a-zA-Z0-9_]{2,6}$/;		
	    
	    // 문자, 숫자 1개이상 포함, 8자리 이상
	    let regPwd = /(?=.*\d)(?=.*[a-zA-ZS]).{4,20}/; 	
	    
	    // 이메일 형식 ex) abc123@defgh456.ijk
	    let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 	
	    // " -" ," _"," ." 세개의 문자 입력을 허용하며 도메인 주소 " ."  이전에 "@" 가 나와야 하고, 도메인 주소 "."   이후에 2-3 문자는 와야된다. 
	    
	    let mid = myform.mid.value.trim();
	    let pwd = myform.pwd.value.trim();
	    let nickName = myform.nickName.value.trim();
	    let address = myform.address.value;
	    let addressPick = myform.addressPick.value;
	    
	    let email1 = myform.email1.value.trim();
	    let email2 = myform.email2.value.trim();
	    let email = email1 + email2;
	    
	    if(mid == ""){
	    	alert("아이디를 입력해주세요.");
	    	myform.mid.focus();
	    	return false;
	    }
	    else if(pwd == ""){
	    	alert("비밀번호를 입력해주세요.");
	    	myform.pwd.focus();
	    	return false;
	    }
	    else if(nickName == ""){
	    	alert("활동명을 입력해주세요.");
	    	myform.nickName.focus();
	    	return false;
	    }
	    else if(email == ""){
	    	alert("이메일을 입력해주세요.");
	    	myform.email.focus();
	    	return false;
	    }
	    else if(address == ""){
	    	alert("주소를 입력해주세요.");
	    	document.getElementById('address').focus();
	    	return false;
	    }
	    else if(addressPick == ""){
	    	alert("주소를 검색해 활동지역을 선택해주세요.");
	    	document.getElementById('addressSearchBtn').focus();
	    	return false;
	    }
	    
	    // c:if 써서 정규식 코드와 문자열이 틀리면 빨간표시 맞게 적으면 초록색으로 체크표시뜨게 해보깅
	    if(!regMid.test(mid)){
	    	alert("아이디는 4~16자리 영문 대/소문자와 숫자와 밑줄만 가능합니다.");
	    	myform.mid.focus();
	    	return false;
	    }
	    else if(!regPwd.test(pwd)){
	    	alert("비밀번호는 4~20자리 영문 대/소문자와 숫자 1개이상 포함하여 작성해주세요.");
	    	myform.mid.focus();
	    	return false;
	    }
	    else if(!regNickName.test(nickName)){
	    	alert("닉네임은 4~6자 이하 한글, 영문 대/소문자, 숫자, 밑줄만 가능합니다.");
	    	myform.mid.focus();
	    	return false;
	    }
	    else if(!regEmail.test(email)){
	    	alert("올바른 이메일 형식으로 입력해주세요.");
	    	myform.email1.focus();
	    	return false;
	    }
	    
	    
	    
		if(idCheckSw == 0){
			alert("아이디 중복체크 버튼을 눌러주세요.");
			document.getElementById("idCheckBtnNO").focus();
		}
		else if(nickCheckSw == 0){
			alert("닉네임 중복체크 버튼을 눌러주세요.");
			document.getElementById("nickCheckBtnNO").focus();
		}
		else if(addressSw == 0){
			alert("주소를 검색해 활동지역을 선택해주세요.");
			document.getElementById("addressSearchBtn").focus();
		}
		else {
			myform.email.value = email;
			myform.photo.value = 'noimage.png';
			
			myform.submit();
		}
		
		
	}
	
	function idCheck() {
		let mid = myform.mid.value.trim()
		if (mid == ""){
			alert("아이디를 입력해주세요");
			myform.mid.focus();
			return false;
		}
		else {
			idCheckSw = 1;
			
			$.ajax({
				url : "${ctp}/member/memberIdCheck",
				type : "post",
				data : {mid : mid},
				success : function (res) {
					if(res != "0") {
						alert("이미 사용중인 아이디입니다!\n다시 입력해주세요.");
						myform.mid.focus();
						return false;
					}
					else {
						alert("사용가능한 아이디입니다.");
						$('#idCheckBtnOK').show();
						$('#idCheckBtnNO').hide();
					}
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
	}
	
	function nickCheck() {
		let nickName = myform.nickName.value.trim()
		if (nickName == ""){
			alert("닉네임을 입력해주세요");
			myform.nickName.focus();
			return false;
		}
		else {
			nickCheckSw = 1;
			
			$.ajax({
				url : "${ctp}/member/memberNickCheck",
				type : "post",
				data : {nickName : nickName},
				success : function (res) {
					if(res != "0") {
						alert("이미 사용중인 닉네임입니다!\n다시 입력해주세요.");
						myform.nickName.focus();
						return false;
					}
					else {
						alert("사용가능한 닉네임입니다.");
						$('#nickCheckBtnOK').show();
						$('#nickCheckBtnNO').hide();
					}
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
	}
	
	$(function () {
		$("#mid").on("keydown", function() {
			idCheckSw = 0;
			$('#idCheckBtnOK').hide();
			$('#idCheckBtnNO').show();
		});
		
		$("#nickName").on("keydown", function() {
			nickCheckSw = 0;
			$('#nickCheckBtnOK').hide();
			$('#nickCheckBtnNO').show();
		});
		
	});
	
	$(function() {
		let pwd = myform.pwd.value.trim();
		let email1 = myform.email1.value.trim();
		let address = myform.address.value.trim();
		
		$('#memberJoinNOBtn').prop('disabled', true);
		$('#mid').on('input', function() {
			if(idCheckSw != 0 && nickCheckSw != 0 && pwd != "" && email1 != "" && address != ""){
				$('#memberJoinNOBtn').prop('disabled', false);
			}
			else $('#memberJoinNOBtn').prop('disabled', true);
		});
		
	});
	
	/* 
	
	$('button').prop('disabled', true);
    $('input[type=text]').on('input', function() {
        if ($(this).val() !== '') {
            $('button').prop('disabled', false);
        }
        else {
            $('button').prop('disabled', true);
        }
    });
	
	*/
	
	/* 
	$(function() {
		$("#mid").on("blur", () => {idCheckSw = 0;});
		$("#nickName").on("blur", () => {nickCheckSw = 0;});
	});
	  */
	 /* 
	 function() {
		 $("#mid").on("blur"){
			 {idCheckSw = 0;};
			 $('#idCheckBtnOK').hide();
			 $('#idCheckBtnNO').show();
		 }
	}
	  */
	  /* 
	$(function() {
		let pwd = myform.pwd.value.trim();
		let email1 = myform.email1.value.trim();
		let address = myform.address.value.trim();
		if(idCheckSw != 0 && nickCheckSw != 0 && pwd != "" && email1 != "" && address != ""){
			$('#memberJoinOKBtn').show();
			$('#memberJoinNOBtn').hide();
		}
	});
	
	 */
	
	/* 
	function imgCheck(e) {
		if(e.files && e.files[0]){
			let reder = new fileReader();
			reader.onload = function(e) {
				document.getElementById("#demoImg").src = e.target.result;
			}
			reader.readAsDataURL(e.files[0]);
		}
	}
	 */
</script>
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
	<div class="joinForm">
		<form name="myform" method="post">
			<section class="sec01">
				<%-- <div class="text-center"><img src="${ctp}/images/memberLogin/login_bg_03.png" class="logo" style="width:300px">회원가입</div> --%>
				<!-- 반려동물 커뮤니티 사이트, 커플 일정 공유 캘린더 --><!-- 커플 일정공유 캘린더, 친구맺어진 사람들끼리만 공유, 한쪽이 수정중이면 다른 한쪽은 수정불가 -->
				<!-- 반려동물이용 시설, 내가 찜한 목록 -->
				<!-- 산책인증 챌린지 
				회원가입img-->
			    
			    <!-- 특이사항 적을지 말지? -->
			</section>
			<section class="sec02">
			    <div class="form-group">
				    <label for="mid"><span style="color:#578de4"><b>* </b></span>아이디<span style="color:#888;font-size:12px;"> (4~16자 영문 대/소문자와 숫자, 밑줄만 가능)</span></label>
				    <div class="input-group mb-1">
					    <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력해주세요." required autofocus/>
					    <div class="input-group-prepend">
					    	<input type="button" value="아이디 중복체크" id="idCheckBtnNO" class="idCheckBtnNO" onclick="idCheck()" />	
					    	<input type="button" value="아이디 중복체크" id="idCheckBtnOK" class="idCheckBtnOK" style="display:none;" onclick="idCheck()" />	
					    </div>
					</div>
			    </div>
			    <div class="form-group">
				    <label for="pwd"><span style="color:#578de4"><b>* </b></span>비밀번호<span style="color:#888;font-size:12px;"> (4~20자 영문 대/소문자와 숫자 1개이상 포함)</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력해주세요." name="pwd" required />
			    </div>
			    <div class="form-group">
				    <label for="nickName"><span style="color:#578de4"><b>* </b></span>활동명<span style="color:#888;font-size:12px;"> (4~6자 한글, 영문 대/소문자, 숫자, 밑줄만 가능)</span></label>
				    <div class="input-group mb-1">
					    <input type="text" class="form-control" id="nickName" placeholder="활동명을 입력해주세요." name="nickName" required />
					    <div class="input-group-prepend">
					    	<input type="button" id="nickCheckBtnNO" value="활동명 중복체크" class="nickCheckBtnNO" onclick="nickCheck()"/>
					    	<input type="button" id="nickCheckBtnOK" value="활동명 중복체크" class="nickCheckBtnOK" style="display:none;" onclick="nickCheck()"/>
					    </div>
				    </div>
			    </div>
			    <div class="form-group">
			      <label for="email1"><span style="color:#578de4"><b>* </b></span>Email</label>
			        <div class="input-group mb-3">
			          <input type="text" class="form-control" placeholder="Email을 입력해주세요." id="email1" name="email1" required />
			          <div class="input-group-append">
			            <select name="email2" id="email2" class="custom-select">
			              <option value="@naver.com" selected>@naver.com</option>
			              <option value="@hanmail.net">@hanmail.net</option>
			              <option value="@hotmail.com">@hotmail.com</option>
			              <option value="@gmail.com">@gmail.com</option>
			              <option value="@nate.com">@nate.com</option>
			              <option value="@yahoo.com">@yahoo.com</option>
			            </select>
			          </div>
			        </div>
			    </div>
			    
			    <div class="form-group">
				    <label for="address"><span style="color:#578de4"><b>* </b></span>활동지역<span style="color:#888;font-size:12px;"> (ex.압구정, 사창동, 군위읍, 죽암리 ...)</span></label>
				    <div class="input-group mb-1">
					    <input type="text" class="form-control address" id="address" placeholder="동네를 입력해주세요. (ex.압구정, 사창동, 군위읍, 죽암리 ...)" name="address" required />
					    <input type="text" class="form-control address" id="addressPick" placeholder="동네를 입력해주세요. (ex.압구정, 사창동, 군위읍, 죽암리 ...)" name="addressPick" required readonly style="display:none;"/>
					    <div class="input-group-prepend">
					    	<input type="button" value="주소검색" id="addressSearchBtn" class="addressSearchBtn" onclick="addressSearch()" />	
					    	<input type="button" value="다시검색" id="addressReSearchBtn" class="addressReSearchBtn" style="display:none;" />	
					    </div>
					</div>
					<div id="demo" style="height:70px;padding:10px 10px;"><span id="spinnerIcon" class="spinner-border text-primary" style="display:none;width:20px;height:20px;border:2px solid currentcolor;border-right-color: transparent;"></span></div>
			    </div>
			    
			    <div class="btnSec">
			    	<button type="button" onclick="fCheck()" class="memberJoinOKBtn" id="memberJoinOKBtn">가입하기</button>
			    	<!-- <button type="button" onclick="fCheck()" class="memberJoinNOBtn" id="memberJoinNOBtn">가입하기</button> -->
			    	<!-- <a href="#" class="btn memberJoinNOBtn disabled" id="memberJoinNOBtn">가입아직</a> -->
			    </div>
			</section>
			<input type="hidden" name="email"/>
			<input type="hidden" name="photo"/>
	  	</form>
	</div>
	
	<script>
		$('#addressSearchBtn').click(function() {
			$('#address').val('');
		});
	</script>
	
</body>
</html>