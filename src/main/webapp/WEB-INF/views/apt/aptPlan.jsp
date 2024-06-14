<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EcoPlanner</title>
<link href="css/apt/aptPlan.css" rel="stylesheet" />
</head>
<body class="apt-plan">
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

	<div class="container"
		style="height: 720px; margin-top: 60px; text-align: center; border: 1px solid #ccc; border-radius: 25px; box-shadow: 1px 2px 2px 2px gray;">
		<div style="margin-bottom: 50px; margin-top: 30px;">
			<span style="font-size: 30px; font-weight: bold;">목표치 계산기</span><br>
			<br>
			<hr>
		</div>
		<div class="row" style="margin-top: 70px;">
			<!-- Current Usage -->
			<div
				class="col-md-3 d-flex flex-column align-items-center justify-content-center text-center">
				<div class="p-3 bg-light border rounded shadow-sm"
					style="width: 300px; height: 400px; margin-left: 30px;">
					<h4>현재 사용량</h4>
					<hr>
					<div
						style="font-size: 24px; margin-top: 40px; display: flex; align-items: center; justify-content: center;">
						전력량: <input type="number" class="form-control"
							id="currentUsageInput" style="width: 100px; margin-left: 10px;"
							max="1000" value="${sessionScope.login.elecUsage}"> <strong>kWh</strong>
					</div>
					<div
						style="font-size: 24px; margin-top: 40px; display: flex; align-items: center; justify-content: center;">
						전기세: <input type="number" class="form-control"
							id="currentBillInput" style="width: 100px; margin-left: 10px; font-weight: bold;"
							readonly disabled> <strong>원</strong>
					</div>
					<div
						class="form-check d-flex justify-content-center align-items-center"
						style="margin-top: 20px;">
						<input class="form-check-input" type="checkbox" value=""
							id="summerCheck"
							style="border: 1px solid black; margin-right: 5px;"> <label
							class="form-check-label" for="summerCheck"> <span
							style="font-weight: bold; font-size: 21px;">여름</span>
						</label>
					</div>

				</div>
			</div>
			<!-- Target Usage -->
			<div
				class="col-md-3 d-flex flex-column align-items-center justify-content-center text-center">
				<div class="p-3 bg-light border rounded shadow-sm"
					style="width: 300px; height: 400px;">
					<h4>목표치</h4>
					<hr>
					<div
						style="font-size: 24px; margin-top: 40px; display: flex; align-items: center; justify-content: center;">
						전력량: <input type="number" class="form-control"
							id="targetUsageInput" style="width: 100px; margin-left: 10px; "
							max="1000"> <strong>kWh</strong>
					</div>
					<div
						style="font-size: 24px; margin-top: 40px; display: flex; align-items: center; justify-content: center;">
						전기세: <input type="number" class="form-control"
							id="targetBillInput" style="width: 100px; margin-left: 10px; font-weight: bold;"
							readonly disabled> <strong>원</strong>
					</div>
					<button type="button" class="btn btn-outline-success calc-button"
						style="margin-top: 30px; width: 200px; font-weight: bold;">
						계산하기
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
							fill="currentColor" class="bi bi-calculator-fill"
							viewBox="0 0 16 16">
                            <path
								d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2zm2 .5v2a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5v-2a.5.5 0 0 0-.5-.5h-7a.5.5 0 0 0-.5.5m0 4v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5zM4.5 9a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5M4 12.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M7.5 6a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM7 9.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m.5 2.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM10 6.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m.5 2.5a.5.5 0 0 0-.5.5v4a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-4a.5.5 0 0 0-.5-.5z" />
                        </svg>
					</button>
				</div>
			</div>
			<!-- Results Display -->
			<div
				class="col-md-6 d-flex flex-column align-items-center justify-content-center text-center">
				<div class="card text-bg-light mb-3"
					style="width: 100%; height: 100%;">
					<div class="card-header"
						style="font-size: 18px; font-weight: bold; background-color: #198754; color: #FFF;">
						전기세 <span id="savingsAmount">0</span>원 을 절약 할 수 있어요!
					</div>
					<div class="card-body"
						style="margin-top: 20px; height: 120px; overflow: auto;">
						<div id="coinContainer" class="coin-container"></div>
					</div>
				</div>
				<div class="card text-bg-light mb-3"
					style="width: 100%; height: 100%;">
					<div class="card-header"
						style="font-size: 18px; font-weight: bold; background-color: #198754; color: #FFF;">
						나무를 <span id="treeCount">0</span>그루 만큼 심을 수 있어요!
					</div>
					<div class="card-body"
						style="margin-top: 20px; height: 120px; overflow: auto;">
						<div id="treeContainer" class="tree-container"></div>
					</div>
				</div>
			</div>
		</div>
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
	<script src="js/apt/aptPlan.js"></script>

	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

</body>
</html>
