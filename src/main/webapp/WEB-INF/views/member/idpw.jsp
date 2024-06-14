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
<!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<link href="resources/css/member/idpw.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
</head>
<body>
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
	<div class="container-fluid"
		style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 90vh;">
		<div class="login_wrapper"
			style="margin-bottom: 80px; margin-top: 80px;">
			<div class="logo">
				<div class="input-group mb-6"
					style="width: 300px; margin-left: 235px; margin-right: auto;">
					<div class="form-check">
						<input class="form-check-input" type="radio"
							name="flexRadioDefault" id="flexRadioDefault1"
							style="background-color: green;" checked> <label
							class="form-check-label" for="flexRadioDefault1">아이디</label>
					</div>
					<div class="form-check" style="margin-left: 130px;">
						<input class="form-check-input" type="radio"
							name="flexRadioDefault" id="flexRadioDefault2"
							style="background-color: green;"> <label
							class="form-check-label" for="flexRadioDefault2">비밀번호</label>
					</div>
				</div>

				<!-- 아이디 입력란 -->
				<hr>
				<div id="search">
					<form class="login_form" id="idSearchForm"
						style="margin-top: 40px;" action="<c:url value = '/sendSMS'/>">
						<div class="input-group mb-3"
							style="width: 300px; height: 50px; margin-top: 35px; margin-left: 230px; border-radius: 0;">
							<span class="input-group-text" style="background-color: green;"><i
								class="bi bi-pen" style="color: white;"></i></span> <input type="text"
								class="form-control" id="inputName_1" placeholder="이름" required
								aria-label="Recipient's username"
								aria-describedby="button-addon2"
								style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;">
						</div>
						<div class="input-group mb-3"
							style="width: 300px; height: 50px; margin-left: 230px; border-radius: 0;">
							<span class="input-group-text" style="background-color: green;"><i
								class="bi bi-telephone" style="color: white;"></i></span> <input
								type="text" class="form-control" id="inputPhone_1"
								placeholder="전화번호" required aria-label="Recipient's username"
								name="memPhone" aria-describedby="button-addon2"
								style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"
								oninput="hypenTel(this);">
						</div>
						<button id="find_username_btn" type="button">아이디찾기</button>
						<div id="id_value" style="text-align: center; margin-top: 20px;"></div>
					</form>
				</div>

				<!-- 비밀번호 입력란 -->
				<div id="search2" style="display: none;">
					<form class="login_form" id="pwSearchForm"
						action="<c:url value="/sendMailDo"  />" style="margin-top: 40px;">
						<div class="input-group mb-3"
							style="width: 300px; height: 50px; margin-left: 230px; border-radius: 0;">
							<span class="input-group-text" style="background-color: green;"><i
								class="bi bi-envelope" style="color: white;"></i></span> <input
								type="email" class="form-control" id="userEmail"
								placeholder="이메일" required aria-label="Recipient's username"
								aria-describedby="button-addon2"
								style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;">
						</div>
						<button type="button" id="btn_email" onclick="fn_email_check()">이메일
							확인</button>
						<button id="find_password_btn" type="submit"
							style="display: none;" style="margin-top: 50px;">비밀번호찾기</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 아이디 찾기모달 추가 -->
	<div class="modal fade" id="idAuthenticationModal" tabindex="-1"
		aria-labelledby="idAuthenticationModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="idAuthenticationModalLabel">아이디</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="authenticationForm">
						<div class="mb-3">
							<label for="verificationCode" class="form-label">인증 코드</label> <input
								type="text" class="form-control" id="verificationCode"
								name="certified" required>
						</div>
					</form>
					<div id="userIdDisplay" style="display: none;">
						<p>
							아이디: <span id="userId"></span>
						</p>
					</div>
					<div id="verificationError" style="color: red; display: none;">인증번호가
						올바르지 않습니다.</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="verifyButton">확인</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 새 비밀번호 모달 -->
	<div class="modal fade" id="newPasswordModal" tabindex="-1"
		aria-labelledby="newPasswordModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="newPasswordModalLabel">새 비밀번호 설정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- 새 비밀번호 설정 폼 -->
					<form id="newPasswordForm">
						<div class="mb-3">
							<label for="newPassword" class="form-label">새로운 비밀번호</label> <input
								type="password" class="form-control" id="newPassword" required>
						</div>
						<!-- 비밀번호 재확인 입력 -->
						<div class="mb-3">
							<label for="confirmedNewPassword" class="form-label">비밀번호
								재확인</label> <input type="password" class="form-control"
								id="confirmedNewPassword" required>
						</div>
						<button type="submit" class="btn btn-primary"
							id="confirmedNewPasswordBtn">확인</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 비밀번호 찾기 모달 -->
	<div class="modal fade" id="verificationModal" tabindex="-1"
		aria-labelledby="verificationModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="verificationModalLabel">인증번호 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="verificationForm">
						<div class="mb-3">
							<label for="verificationCode2" class="form-label">인증번호를
								입력해주세요</label> <input type="text" class="form-control"
								id="verificationCode2" required>
						</div>
						<button type="submit" class="btn btn-primary" id="pw_Search"
							style="float: right;">확인</button>
					</form>
				</div>
			</div>
		</div>
	</div>


	</div>
	</div>
	</div>
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	<!-- 부트스트랩 JS 추가 -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2/dist/umd/popper.min.js"></script>
	<script src="resources/js/member/idpw.js"></script>
</body>
</html>
