<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>title</title>
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
		.startBtn{
			border: solid 1px #578ed4;
		    padding: 10px 30px;
		    background-color: #578de4;
		    color: #fff;
		}
		#question-01, #question-02, #question-03, #finish{display:none;}
	</style>
	<script>
    	'use strict';
    	
    	function mbtiResult() {
			let ei01 = mbtiForm.ei01.value;
			console.log(ei01);
			let ei02 = mbtiForm.ei02.value;
			let ei03 = mbtiForm.ei03.value;
			let eORi = parseInt(ei01) + parseInt(ei02) + parseInt(ei03);
			console.log(eORi);
			
			$.ajax({
				url : "${ctp}/mbti/mbtiResultOK",
				type : "post",
				data : {eORi : eORi},
				success : function (res) {
					if(res == "E") alert("당신의 MBTI는 E입니다.");
					else alert("당신의 MBTI는 I입니다.");
				},
				error : function () {
					alert("전송오류");
				}
			});
		}
    
    	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<div class="inner">
		<h2>mbti test</h2>
		<hr/>
		<button class="startBtn" id="startBtn">시작하기</button>
		<hr/>
		<form name="mbtiForm" method="post">
			<div id="question">
				<div id="question-01">
					<p>당신은 밖에서 노는걸 좋아하나요?(E/I)</p>
					<div class="form-group">
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input-01" id="answer-01" name="ei01" value="1" ><span style="font-size:14px">YES</span>
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input-01" id="answer-02" name="ei01" value="0"><span style="font-size:14px">NO</span>
							</label>
						</div>
					</div>
				</div>
				<div id="question-02">
					<p>당신은 모르는사람한테 말을 잘 거나요?(E/I)</p>
					<div class="form-group">
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input-02" id="answer-03" name="ei02" value="1" ><span style="font-size:14px">YES</span>
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input-02" id="answer-04" name="ei02" value="0"><span style="font-size:14px">NO</span>
							</label>
						</div>
					</div>
				</div>
				<div id="question-03">
					<p>당신은 장기자랑 하는걸 좋아하나요?(E/I)</p>
					<div class="form-group">
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input-03" id="answer-05" name="ei03" value="1" ><span style="font-size:14px">YES</span>
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label">
								<input type="radio" class="form-check-input-03" id="answer-06" name="ei03" value="0"><span style="font-size:14px">NO</span>
							</label>
						</div>
					</div>
				</div>
				
				<div id="finish"><input type="button" onclick="mbtiResult()" value="결과보기"/></div>
			</div>
		</form>
		<input type="hidden" name="eORi"/>
	</div><!-- inner 끝 -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
   	'use strict';
   
   	$('#startBtn').click(function() {
   		$('#question-01').fadeIn('slow');
	});
   	$('.form-check-input-01').click(function() {
   		$('#question-01').fadeOut('slow',function(){
	   		$('#question-02').fadeIn('slow');
   		});
	});
   	$('.form-check-input-02').click(function() {
   		$('#question-02').fadeOut('slow',function(){
	   		$('#question-03').fadeIn('slow');
   		});
	});
   	$('.form-check-input-03').click(function() {
   		$('#question-03').fadeOut('slow',function(){
	   		$('#finish').fadeIn('slow');
   		});
	});
   	
</script>
</body>
</html>