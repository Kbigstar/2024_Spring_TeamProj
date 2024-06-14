<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
body {
	padding-top: 100px; /* 네비게이션 바의 높이와 조금 더 추가된 공간을 고려 */
	background-color: #f3fff2;
}

.navbar {
	background-color: #fff;
	height: 80px;
	margin: 20px;
	border-radius: 16px;
	padding: 0.5rem;
	box-shadow: 2px 2px 2px 2px gray;
}

.navbar-brand {
	font-weight: 500;
	color: #009970;
	font-size: 24px;
	transition: 0.3s color;
}

.login-button {
	background-color: #009970;
	color: #fff;
	font-size: 14px;
	padding: 8px 20px;
	border-radius: 50px;
	text-decoration: none;
	transition: 0.3s background-color;
}

.login-button:hover {
	background-color: #00b383;
}

.navbar-toggler {
	border: none;
	font-size: 1.25rem;
}

.navbar-toggler:focus, .btn-close:focus {
	box-shadow: none;
	outline: none;
}

.nav-link {
	color: #666777;
	font-weight: 500;
}

.nav-link:hover, .nav-link.active {
	color: #000;
}

@media ( min-width : 991px) {
	.nav-link {
		position: relative; /* 추가 */
	}
	.nav-link::before {
		content: "";
		position: absolute;
		bottom: -10px;
		left: 50%;
		transform: translateX(-50%);
		width: 0;
		height: 2px;
		background-color: #009970;
		visibility: hidden;
		transition: 0.3s ease-in-out;
	}
	.nav-link:hover::before, .nav-link.active::before {
		width: 100%;
		visibility: visible;
	}
}
</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand me-auto" href="<c:url value="/" />">EcoPlanner</a>
			<div class="offcanvas offcanvas-end" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">EcoPlanner</h5>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
						aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul class="navbar-nav justify-content-center flex-grow-1 pe-3">
						<li class="nav-item"><a class="nav-link mx-lg-2"
							aria-current="page" href="<c:url value="/" />">Home</a></li>
						<li class="nav-item"><a class="nav-link mx-lg-2"
							href="<c:url value="/apt" />">내 아파트</a>
						<li class="nav-item"><a class="nav-link mx-lg-2"
							href="<c:url value="/aptCompare" />">아파트 별 비교</a>
						<li class="nav-item"><a class="nav-link mx-lg-2"
							href="<c:url value="/aptBill" />">고지서</a>
						<li class="nav-item"><a class="nav-link mx-lg-2"
							href="<c:url value="/aptPlan" />">목표치</a>
						<li class="nav-item"><a class="nav-link mx-lg-2"
							href="<c:url value="/board?page=1&size=5" />">아파트 귓속말</a>
						<li class="nav-item"><a class="nav-link mx-lg-2"
							href="<c:url value="/cbPoint" />">탄소 포인트</a>
						<li class="nav-item"><a class="nav-link mx-lg-2"
							href="<c:url value="/news" />">에너지 뉴스</a></li>
						<c:if test="${sessionScope.login != null }">
							<li class="nav-item"><a class="nav-link mx-lg-2"
								href="<c:url value="/mypage" />">MyPage</a>
							<li class="nav-item">
						</c:if>

					</ul>
				</div>
			</div>
			<c:if test="${sessionScope.login == null }">
				<a href="<c:url value = '/login'/>" class="login-button">Login</a>
			</c:if>
			<c:if test="${sessionScope.login != null }">
				<a href="<c:url value='/logoutDo'/>" class="login-button"
					id="logoutLink">${sessionScope.login.memNm}님</a>
				<script type="text/javascript">
					document.addEventListener('DOMContentLoaded', function() {
						var logoutLink = document.getElementById('logoutLink');
						logoutLink.addEventListener('click', function(event) {
							var confirmed = confirm('로그아웃 하시겠습니까?');
							if (!confirmed) {
								event.preventDefault(); // 사용자가 "취소"를 클릭하면 로그아웃을 취소합니다.
							}
						});
					});
				</script>
			</c:if>

			<button class="navbar-toggler " type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>
	<!-- End Navbar-->

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<!-- 부트스트랩 JS 추가 -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<script>
		$(document).ready(
				function() {
					// 현재 페이지의 전체 URL 가져오기
					var currentUrl = window.location.pathname; // 현재 페이지의 경로만 필요

					// 특정 페이지들을 확인하는 배열
					var specialPages = [ '/login', '/regist' ];

					// 모든 네비게이션 링크를 순회하며 현재 URL과 링크의 href 속성 비교
					$('nav a').each(
							function() {
								var $this = $(this);
								var href = new URL($this.prop('href'),
										window.location.href).pathname; // 절대 경로로 변환

								// 특정 페이지에 있을 때 홈 링크에 active 클래스 추가
								if (specialPages.includes(currentUrl)) {
									if (href === '/') {
										$this.addClass('active');
									} else {
										$this.removeClass('active');
									}
								} else {
									// 링크의 href가 현재 URL과 정확히 일치하면 'active' 클래스 추가
									if (href === currentUrl) {
										$this.addClass('active');
									} else {
										$this.removeClass('active');
									}
								}
							});
				});
	</script>

</body>
</html>