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

<link href="resources/css/member/member.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">

<script src='https://code.jquery.com/jquery-3.7.1.js'></script>
<script src='resources/js/member/regist.js'></script>


</head>

<body>
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
<body>
	<navbar></navbar>

	<div class="container-fluid"
		style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 90vh;">
		<div></div>
		<div class="login_wrapper"
			style="margin-bottom: 80px; margin-top: 80px;">
			<div class="logo">
				<div style="font-size: 50px;">회원가입</div>
				<hr>
				<form class="login_form" style="margin-top: 40px;" novalidate
					onsubmit="return validateForm()"
					action="<c:url value = '/registDo'/>">
					<!-- 빨간색 표시 -->
					<table id="table">
						<tr>
							<td>
								<div class="input-group mb-3"
									style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
									<span class="input-group-text" style="background-color: green;"><i
										class="bi bi-lock" style="color: white;"></i></span> <input
										type="email" class="form-control"
										placeholder="이메일 형식으로 아이디 입력" required
										aria-label="Recipient's username"
										aria-describedby="button-addon2"
										style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"
										id="emailInput" name="memId" onblur="fn_id_check()">
									<div class="invalid-feedback" style="display: none;">이메일
										형식으로 아이디를 입력하세요.</div>
								</div>
							</td>
							<td>
								<div class="input-group mb-3"
									style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
									<span class="input-group-text" style="background-color: green;">
										<i class="bi bi-lock" style="color: white;"></i>
									</span> <input type="password" name="memPw" class="form-control"
										placeholder="비밀번호" required aria-label="Recipient's username"
										aria-describedby="button-addon2"
										style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"
										id="passwordInput">
									<div class="invalid-feedback">비밀번호를 입력하세요.</div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group mb-3"
									style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
									<span class="input-group-text" style="background-color: green;">
										<i class="bi bi-pen" style="color: white;"></i>
									</span> <input type="text" class="form-control" placeholder="이름"
										required aria-label="Recipient's username"
										aria-describedby="button-addon2"
										style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"
										id="nameInput" name="memNm">
									<div class="invalid-feedback">이름을 입력하세요.</div>
								</div>
							</td>
							<td>
								<div style="position: relative;">
									<div class="input-group mb-3"
										style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
										<span class="input-group-text"
											style="background-color: green;"> <i
											class="bi bi-search" style="color: white; cursor: pointer;"
											onclick="showAptModal()"></i></span> <input type="text"
											class="form-control" id="aptInput" name="memRes"
											placeholder="아파트명" required aria-label="Recipient's username"
											aria-describedby="button-addon2"
											style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"
											onfocus="showAptModal()" readonly>
										<!-- 아파트명 선택 버튼 -->
										<div class="invalid-feedback">아파트명을 선택하세요.</div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group mb-3"
									style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
									<span class="input-group-text" style="background-color: green;">
										<i class="bi bi-telephone" style="color: white;"></i>
									</span> <input type="tel" class="form-control"
										oninput="hypenTel(this)" maxlength="13" name="memPhone"
										placeholder="전화번호" required aria-label="Recipient's username"
										aria-describedby="button-addon2"
										style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"
										id="phoneInput" onblur="fn_phone_check()">
									<div class="invalid-feedback">전화번호를 입력하세요.</div>
								</div>
							</td>
							<td>
								<div class="input-group mb-3"
									style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
									<span class="input-group-text" style="background-color: green;">
										<i class="bi bi-building-fill" style="color: white;"></i>
									</span> <input type="text" name="apartComplexcode"
										class="form-control" placeholder="단지코드" required
										aria-label="Recipient's username"
										aria-describedby="button-addon2"
										style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"
										id="codeInput" readonly >
									<div class="invalid-feedback">단지코드를 입력하세요.</div>
								</div>
							</td>
						</tr>
					</table>

					<button id="login_btn" type="submit" style="margin-top: 30px;">가입</button>
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	
	<!-- Modal -->
	<div class="modal fade" id="aptModal" tabindex="-1"
		aria-labelledby="aptModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="aptModalLabel">아파트 선택</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h6><i class="bi bi-circle-fill" style="font-size: 12px;"></i> 대전 내 아파트명으로 입력해주세요.</h6>
					<div class="input-group mb-3" style="width: 350px;">
						<input type="text" id="aptSearch" class="form-control"
							placeholder="아파트 검색" aria-label="Recipient's username"
							aria-describedby="button-addon2">

						<button class="btn btn-outline-secondary" type="button"
							id="aptSearchBtn" style="background-color: green; color: white;">검색</button>
					</div>

					<ul id="aptResult"></ul>
				</div>
			</div>
		</div>
	</div>
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
</body>

</html>
