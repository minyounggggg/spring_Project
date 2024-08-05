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
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {

        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['카페리뷰', ${cafeReviewCnt}],
          ['병원리뷰', ${hospitalReviewCnt}],
          ['제품리뷰', ${productReviewCnt}]
        ]);

        var options = {
          title: '금일 리뷰별 업로드 수 (단위 : 개)'
        };

        var chart = new google.visualization.PieChart(document.getElementById('pieChart'));

        chart.draw(data, options);
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
				<a href="${ctp}/admin/adminMain" class="seconTitle" style="color:#fff">DashBoard</a>
			</section>
			<section>
				<p class="mainTitle">INTERFACE</p>
				<a href="${ctp}/admin/complaintList" class="seconTitle">ComplaintList</a><br/>
				<a href="${ctp}/admin/complaintList" class="seconTitle">Info-01</a><br/>
				<a href="${ctp}/admin/complaintList" class="seconTitle">Info-02</a>
			</section>
		</div>
		<div class="rightSection">
			<p style="margin-left: 15px;font-size: 20px;font-weight: 600;"><img src="${ctp}/resources/images/icon/bar-graph.png" style="width:25px;margin: 0 15px 9px 0;"/>일주일간 항목별 업로드 수</p>
			<!-- 부트스트랩차트 section -->
			<div class="container"><canvas id="myChart" ></canvas></div>
			
			<!-- 구글차트 section 
			<div id="pieChart" style="width:600px;height:500px"></div>-->
			
			  <!-- 부트스트랩 -->
			  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
			    integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
			    crossorigin="anonymous"></script>
			  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
			    integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
			    crossorigin="anonymous"></script>
			  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
			    integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
			    crossorigin="anonymous"></script>
			  <!-- 차트 -->
			  <script>
			    var ctx = document.getElementById('myChart');
			    var myChart = new Chart(ctx, {
			      type: 'bar',
			      data: {
			        labels: ['카페리뷰', '병원리뷰', '제품리뷰'],
			        datasets: [{
			          label: '# 단위 (개)',
			          data: [${cafeReviewCnt}, ${hospitalReviewCnt}, ${productReviewCnt}],
			          backgroundColor: [
			            'rgba(255, 99, 132, 0.2)',
			            'rgba(54, 162, 235, 0.2)',
			            'rgba(255, 206, 86, 0.2)'
			          ],
			          borderColor: [
			            'rgba(255, 99, 132, 1)',
			            'rgba(54, 162, 235, 1)',
			            'rgba(255, 206, 86, 1)'
			          ],
			          borderWidth: 1
			        }]
			      },
			      options: {
			        scales: {
			          yAxes: [{
			            ticks: {
			              beginAtZero: true
			            }
			          }]
			        }
			      }
			    });
			
			  </script>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>