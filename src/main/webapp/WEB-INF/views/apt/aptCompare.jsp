<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EcoPlanner</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<style>
body {
	padding-top: 150px; /* 네비게이션 바의 높이와 조금 더 추가된 공간을 고려 */
}
</style>
</head>
<style>
</style>
<body>
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

	<div class="container-fluid p-0">
		<div class="container mt-5">
			<div class="row">
				<div class="col-md-7 mb-4">
					<div class="p-4 bg-light border rounded shadow-sm"
						style="height: 500px;">
						<div class="container text-center">
							<div class="row row-cols-4 border align-middle"
								style="height: 400px;">
								<div
									class="col border d-flex align-items-center justify-content-center">
									<span> 내 아파트</span>
								</div>
								<div
									class="col border d-flex align-items-center justify-content-center">
									<input type="text" style="width: 100%"
										value="${ sessionScope.login.apartDistrict}"
										disabled="disabled">
								</div>
								<div
									class="col border d-flex align-items-center justify-content-center">
									<input type="text" style="width: 100%"
										value="${ sessionScope.login.apartNeighborhood}"
										disabled="disabled">
								</div>
								<div
									class="col border d-flex align-items-center justify-content-center">
									<input type="text" style="width: 100%"
										value="${ sessionScope.login.apartBuildingnm}"
										disabled="disabled"> <input type="hidden"
										style="width: 100%"
										value="${ sessionScope.login.apartComplexcode}"
										disabled="disabled" id="code">
								</div>

								<div
									class="col border d-flex align-items-center justify-content-center">비교
									아파트</div>
								<div
									class="col border d-flex align-items-center justify-content-center">
									<select class="form-select" aria-label="Default select example"
										id="gu">
										<option value="">구</option>
										<c:forEach items="${comList}" var="code">
											<option value="${code.apartDistrict}">${code.apartDistrict}</option>
										</c:forEach>
									</select>
								</div>
								<div
									class="col border d-flex align-items-center justify-content-center">
									<select class="form-select" aria-label="Default select example"
										id="dong">
										<option value="">동</option>
										<c:forEach items="${codList}" var="code">
											<option value="${code.apartNeighborhood}">${code.apartNeighborhood}</option>
										</c:forEach>
									</select>
								</div>
								<div
									class="col border d-flex align-items-center justify-content-center">
									<select class="form-select" aria-label="Default select example"
										id="apart">
										<option value="">아파트</option>
										<c:forEach items="${coList}" var="code">
											<option value="${code.apartComplexcode}">${code.apartBuildingnm}</option>
										</c:forEach>
									</select>
								</div>

							</div>
						</div>
						<div class="text-lg-end text-center">
							<button type="button" class="btn btn-success "
								style="margin-top: 10px; right: 10%;" id="comparebtn">비교하기</button>
						</div>
					</div>
				</div>
				<div class="col-md-5 mb-4">
					<div class="p-5 bg-light border rounded shadow-sm"
						style="height: 500px;">
						<div id="chart"
							style="flex: 1; display: flex; flex-direction: column; justify-content: center; margin-bottom: 1px;">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer 영역 -->
		<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<!-- 부트스트랩 JS 추가 -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="js/apt/aptCompare.js"></script>
</body>

</html>