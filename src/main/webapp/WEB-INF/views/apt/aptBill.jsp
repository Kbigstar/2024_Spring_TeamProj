<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EcoPlanner 고지서</title>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<style>
body.apt-body {
	padding-top: 150px; /* 네비게이션 바의 높이와 조금 더 추가된 공간을 고려 */
}
</style>
<script>
	var elecUsage = "${sessionScope.login.elecUsage}";
	console.log("JSP에서 설정한 전력량: " + elecUsage); // 값 확인용
	
	var apartComplexcode = "${sessionScope.login.apartComplexcode}";
	console.log("JSP에서 설정한 단지코드: " + apartComplexcode); // 값 확인용
</script>
</head>
<body class="apt-body">
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

	<div class="container"
		style="height: 720px; margin-top: 0px; text-align: center; border: 1px solid #ccc; border-radius: 25px; box-shadow: 1px 2px 2px 2px gray;">
		<div style="margin-bottom: 50px; margin-top: 30px;">
			<span style="font-size: 30px; font-weight: bold;">내 아파트 분석
				[고지서]</span> <br> <br>
			<hr>
		</div>
		<div class="row" style="margin-top: 70px;">

			<div
				class="col-md-4 d-flex flex-column align-items-center justify-content-center text-center">

				<div class="p-3 bg-light border rounded shadow-sm"
					style="width: 400px; height: 400px;">
					<h4>나의 고지서</h4>
					<hr>
					<p style="font-size: 24px; margin-top: 40px;">
						전기세: <strong id="userElecBill"></strong>
					</p>
					<p style="font-size: 24px; margin-top: 40px;">
						전력량: <strong>${sessionScope.login.elecUsage} kWh</strong>
					</p>
					<p style="font-size: 24px; margin-top: 40px">"${sessionScope.login.memNm}
						님" 사용 전력량이
					<p style="font-size: 23px; margin-top: 40px">
						아파트 평균 대비 <strong id="comparisonText"> </strong>
					</p>
				</div>
			</div>
			<div
				class="col-md-4 d-flex flex-column align-items-center justify-content-center text-center">

				<div class="p-3 bg-light border rounded shadow-sm"
					style="width: 400px; height: 400px;">
					<h4>아파트 평균</h4>
					<hr>
					<p style="font-size: 24px; margin-top: 40px">
						전기세: <strong id="aptTotalBill"></strong>
					</p>
					<p style="font-size: 24px; margin-top: 40px">
						전력량: <strong id="aptElecUsage"></strong>
					</p>
					<p style="font-size: 24px; margin-top: 40px" id="aptBuildingName">OOO 아파트</p>
					<p style="font-size: 24px; margin-top: 40px">평균 전기세 입니다.</p>
				</div>
			</div>
			<div
				class="col-md-4 d-flex flex-column align-items-center justify-content-center text-center">
				<div class="p-3 bg-light border rounded shadow-sm"
					style="width: 400px; height: 400px;">

					<div id="exampleChart"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="/js/apt/aptBill.js"></script>
</body>
</html>
