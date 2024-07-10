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
	*{font-family: 'Noto Sans KR', sans-serif; }
	body{
		display : flex;
		justify-content: center;
		align-items: center;
		/* height: 100vh; */
		background-color : #eee;
		padding : 30px 0;
	}
	.joinForm{
		width : 1300px;
		border-radius : 30px;
		background-color : #f9f9f9;
		box-shadow : 8px 15px 10px rgba(0, 0, 50, 0.1);
		height: 700px;
	}
	.sec01{
		/* background-image : url("${ctp}/resources/images/memberLogin/testBG.jpg"); */
		float : left;
		width : 50%;
		padding : 30px;
	}
	.sec02{
		/* background : url("${ctp}/resources/images/memberLogin/testBG.jpg"); */
		float : left;
		width : 50%;
		padding : 30px;
	}
</style>
<script>
	'use strict';
	
	let idCheckSw = 0;
    let nickCheckSw = 0;
	
	function fCheck() {
		let regMid = /^[a-zA-Z0-9_]{4,20}$/;			// 아이디는 4~20의 영문 대/소문자와 숫자와 밑줄 가능
	    let regNickName = /^[가-힣a-zA-Z0-9_]{1,6}$/;		// 닉네임은 한글, 영문대소문자, 숫자, 밑줄만 가능
	    let regPwd = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{1,10}$/;	// 대소문자 + 숫자 + 특수문자가 *각각 1개 이상 + 1~10자리
	    
	    let mid = myform.mid.value.trim();
	    let pwd = myform.pwd.value.trim();
	    let nickName = myform.nickName.value.trim();
	   //let address = myform.address.value;
	    
	    let email1 = myform.email1.value.trim();
	    let email2 = myform.email2.value.trim();
	    let email = email1 + "@" + email2;
	    /* 
	    let tel1 = myform.tel1.value.trim();
	    let tel2 = myform.tel2.value.trim();
	    let tel3 = myform.tel3.value.trim();
	    let tel = tel1 + "-" + tel2 + "-" + tel3;
	    
	    // 주소 (시군구 sl)
	    let postcode = myform.postcode.value.trim();
	    let roadAddress = myform.roadAddress.value.trim();
	    let detailAddress = myform.detailAddress.value.trim();
	    let extraAddress = myform.extraAddress.value.trim();
	    let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
	     */
	    // c:if 써서 정규식 코드와 문자열이 틀리면 빨간표시 맞게 적으면 초록색으로 체크표시뜨게 해보깅
	    if(!regMid.test(mid)){
	    	alert("아이디는 4~20자리 영문 대/소문자와 숫자와 밑줄만 가능합니다.");
	    	myform.mid.focus();
	    	return false;
	    }
	    else if(!regPwd.test(pwd)){
	    	alert("비밀번호는 대소문자, 숫자, 특수문자가 *각각 1개 이상 포함된 1~10자리로 작성해주세요.");
	    	myform.mid.focus();
	    	return false;
	    }
	    else if(!regNickName.test(nickName)){
	    	alert("닉네임은 한글, 영문 대/소문자, 숫자, 밑줄만 가능합니다.");
	    	myform.mid.focus();
	    	return false;
	    }
	    // 이메일, 전화번호 형식 체크도하기
	    /* 
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
		 */
		if(idCheckSw == 0){
			alert("아이디 중복체크 버튼을 눌러주세요.");
			document.getElementById("midBtn").focus();
		}
		else if(nickNameBtn == 0){
			alert("닉네임 중복체크 버튼을 눌러주세요.");
			document.getElementById("nickNameBtn").focus();
		}
		else {
			myform.email.value = email;
			
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
					else alert("사용가능한 아이디입니다.")
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
					else alert("사용가능한 닉네임입니다.")
				},
				error : function() {
					alert("전송오류");
				}
			});
		}
	}
	
	$(function() {
		$("#mid").on("blur", () => {idCheckSw = 0;});
		$("#nickName").on("blur", () => {nickCheckSw = 0;});
	});
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
	<div class="joinForm">
		<form name="myform" method="post">
			<section class="sec01">
				<%-- <div class="text-center"><img src="${ctp}/images/memberLogin/logo03.png" class="logo" style="width:300px">회원가입</div> --%>
				<!-- 반려동물 커뮤니티 사이트, 커플 일정 공유 캘린더 --><!-- 커플 일정공유 캘린더, 친구맺어진 사람들끼리만 공유, 한쪽이 수정중이면 다른 한쪽은 수정불가 -->
				<!-- 반려동물이용 시설, 내가 찜한 목록 -->
				<!-- 산책인증 챌린지 -->
				회원가입
				<%-- 
				<div  class="form-group">
				    프로필 사진 (귀여운 내 짝꿍을 자랑해보세요!)(파일용량:2MByte이내) :
				    <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border mb-3"/>
				    <img id="demoImg" width="200px"/>
				    <hr/>
			    </div>
			    <div class="form-group">
				    <label for="name">반려동물 이름 <span style="color:#DB4455"><b>*</b></span></label>
				    <input type="text" class="form-control" id="petName" placeholder="반려동물의 이름을 입력해주세요." name="petName" required />
			    </div>
			    <div class="form-group">
			      <div class="form-check-inline">
			        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			        <label class="form-check-label">
			          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남아
			        </label>
			      </div>
			      <div class="form-check-inline">
			        <label class="form-check-label">
			          <input type="radio" class="form-check-input" name="gender" value="여자">여아
			        </label>
			      </div>
			    </div>
			    <div class="form-group">
				    <label for="birthday">반려동물 생일</label>
				    <input type="date" name="petBirthday" id="petBirthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
			    </div>
			     --%>
			    
			    <!-- 특이사항 적을지 말지? -->
			</section>
			<section class="sec02">
			    <div class="form-group">
				    <label for="mid">아이디 <span style="color:#DB4455"><b>*</b></span></label>
				    <div class="input-group mb-1">
					    <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
					    <div class="input-group-prepend">
					    	<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-secondary" onclick="idCheck()" />	
					    </div>
					</div>
			    </div>
			    <div class="form-group">
				    <label for="pwd">비밀번호 <span style="color:#DB4455"><b>*</b></span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
			    </div>
			    <div class="form-group">
				    <label for="nickName">별명 <span style="color:#DB4455"><b>*</b></span></label>
				    <div class="input-group mb-1">
					    <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
					    <div class="input-group-prepend">
					    	<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary" onclick="nickCheck()"/>
					    </div>
				    </div>
			    </div>
			    <div class="form-group">
			      <label for="email1">Email address <span style="color:#DB4455"><b>*</b></span></label>
			        <div class="input-group mb-3">
			          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
			          <div class="input-group-append">
			            <select name="email2" class="custom-select">
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
	          <!-- 
			    <div class="form-group">
			      <div class="input-group mb-3">
			        <div class="input-group-prepend">
			          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			            <select name="tel1" class="custom-select">
			              <option value="010" selected>010</option>
			              <option value="02">02</option>
			              <option value="031">"031"</option>
			              <option value="032">032</option>
			              <option value="041">041</option>
			              <option value="042">042</option>
			              <option value="043">043</option>
			              <option value="051">051</option>
			              <option value="052">052</option>
			              <option value="061">061</option>
			              <option value="062">062</option>
			            </select>-
			        </div>
			        <input type="text" name="tel1" size=3 maxlength=3 class="form-control" required/>-
			        <input type="text" name="tel2" size=4 maxlength=4 class="form-control" required/>-
			        <input type="text" name="tel3" size=4 maxlength=4 class="form-control" required/>
			      </div>
			    </div>
             -->
             <!-- 
			    <div class="form-group">주소는 시군구동 까지만 입력받아서 같은 동네 사람들끼리 검색? (청주시/상당구/용암동)
			      <label for="address">주소 <span style="color:#DB4455"><b>*</b></span></label>
			      <div class="input-group mb-1">
			        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" required>
			        <div class="input-group-append">
			          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
			        </div>
			      </div>
			      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" required>
			      <div class="input-group mb-1">
			        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
			        <div class="input-group-append">
			          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
			        </div>
			      </div>
			    </div>
			     -->
			     <div class="form-group">
				    <label for="address">활동지역 <span style="color:#DB4455"><b>*</b></span></label>
				    <input type="text" class="form-control" id="address" placeholder="주소를 입력해주세요." name="address" required />
			    </div>
			    <hr/>
			    <div class="btnSec"><button type="button" onclick="fCheck()" class="btn btn-primary form-control mb-2">가입하기</button></div>
			</section>
			<input type="hidden" name="email"/>
			<!-- <input type="hidden" name="tel"/> -->
			<!-- <input type="hidden" name="address"/> -->
			<!-- <input type="hidden" name="fName" id="file"/> -->
	  	</form>
	</div>
</body>
</html>