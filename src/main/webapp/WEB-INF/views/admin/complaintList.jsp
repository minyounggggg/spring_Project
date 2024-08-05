<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminMain.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="icon" href="${ctp}/resources/favicon/love.png">
	
	<!-- 구글폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap');
		
		
		* {font-family: 'Noto Sans KR', sans-serif;}
		a {text-decoration: none; color: inherit;}
		a:link{text-decoration: none;}
		/*.seconTitle a:visited, .seconTitle a:active{color: #fff;}*/
		.seconTitle:hover {color:#fff;}
		/* p {margin:0;} */
		body{background-color: #f8f9fa !important;}
		.inner {width : 1300px; margin : 0 auto; padding-top:150px;}
		.sec-boxStyle{
			background-color : #f9f9f9;
			border-radius : 30px;
			box-shadow : 5px 5px 5px rgba(0, 0, 50, 0.1);
		}
		button {border: none; background-color: transparent;}
		
		nav{
			padding : 20px 20px 10px;
			box-shadow : 0px 5px 5px rgba(0, 0, 50, 0.1);
			position: fixed;
			width : 100%;
			background-color : #212529;
			z-index : 99;
		}
		nav .nav-top{
			margin : 0 auto;
			/* width : 1300px; */
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
		
		/* .semiInner{padding-top:100px;} */
		.leftSection{
			padding:100px 20px 50px;
			float: left;
			width : 15em;
			background-color : #212529;
			height: 100vh;
			
		}
		.rightSection{
			padding:140px 40px 50px;
			float: left;
			width : 85%;
		}
		.mainTitle{
			padding: 1.75rem 1rem 0.75rem;
		    font-size: 0.75rem;
		    font-weight: bold;
		    color: #555;
		}
		.seconTitle{
			padding-left: 15px;
		    font-size: 1.2rem;
		    font-weight: 300;
		    color: #adb5bd;
		}
		
		/* pie차트 css */
		rect {fill: #f8f9fa;}
		#pieChart div div div svg g:nth-child(3) path {fill: #fff;}
		
		.container{
			float: left;
			width : 50%;
			padding: 30px 0 0 60px;
		}
		#myChart{
			
		}
		
	</style>
	
	<script>
		function reviewDelete(idx, productPhoto) {
			let ans = confirm("해당 리뷰 신고글을 삭제 하시겠습니까?");
	    	if(ans) {
	    		$.ajax({
	    			url  : "${ctp}/admin/reviewDeleteOk",
	    			type : "post",
	    			data : {
	    				idx : idx,
	    				productPhoto : productPhoto
	    			},
	    			success:function(res) {
	    				if(res != "0") {
	    					alert("신고글이 삭제 되었습니다.");
	    					location.reload();
	    				}
	    				else alert("삭제 오류! 다시 시도해주세요.");
	    			}
	    		});
	    	}
		}
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
					<p style="font-size:14px;font-weight:600;color:#578de4;">${sNickName}<span style="font-size:14px;font-weight:400;color:#fff;">님 안녕하세요! &nbsp;|&nbsp; 
					<a href="${ctp}/member/memberMypage">마이페이지</a> &nbsp;|&nbsp; <a href="${ctp}/member/memberLogout">로그아웃</a></span></p>
				</c:if>
			</div>
		</div>
	</nav>
	<div class="semiInner">
		<div class="leftSection">
			<section>
				<p class="mainTitle">CORE</p>
				<a href="${ctp}/admin/adminMain" class="seconTitle">DashBoard</a>
			</section>
			<section>
				<p class="mainTitle">INTERFACE</p>
				<a href="${ctp}/admin/complaintList" class="seconTitle" style="color:#fff">ComplaintList</a><br/>
				<a href="${ctp}/admin/complaintList" class="seconTitle">Info-01</a><br/>
				<a href="${ctp}/admin/complaintList" class="seconTitle">Info-02</a>
			</section>
		</div>
		<div class="rightSection">
			<div id="totalList">
				<h3 class="text-center mb-4"><b>신고 리스트</b></h3>
				<table class="table table-hover text-center">
					<tr class="table-dark text-dark">
						<th>닉네임</th>
						<th>파트</th>
						<th>제품 이름</th>
						<th>신고 횟수</th>
						<th>비고</th>
					</tr>
					<%-- <c:set var="curScrStarNO" value="${curScrStarNO+1}"></c:set> --%>
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<tr>
							<td>${vo.nickName}</td>
							<td>제품후기</td>
							<td><a href="${ctp}/review/productReviewContent?idx=${vo.idx}" target="_blank">${vo.productName}</a></td>
							<td>${vo.complaint} 회</td>
							<td>
								<button onclick="reviewDelete('${vo.idx}','${vo.productPhoto}')" class="btn btn-danger btn-sm">삭제</button>
							</td>
						</tr>
						<%-- <c:set var="curScrStarNO" value="${curScrStarNO+1}"></c:set> --%>
					</c:forEach>
					<!-- <tr><td colspan="9" class="m-0 p-0"></td></tr> -->
				</table>
			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>