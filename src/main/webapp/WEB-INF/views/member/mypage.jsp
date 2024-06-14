<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="resources/css/member/mypage.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <!-- nav 영역 -->
    <jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
    
    <c:if test="${not empty msg}">
        <script>
            alert("${msg}");
        </script>
    </c:if>
    
    <div class="container-fluid" style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 90vh;">
        <div></div>
        <div class="login_wrapper" style="margin-bottom: 80px; margin-top: 80px;">
            <div class="logo">
                <div style="font-size: 50px;">마이페이지</div>
                <hr>
                <form  class="login_form" style="margin-top: 40px;" novalidate onsubmit="return validateForm()" action="<c:url value='/updateDo'/>">
                    <table id="table">
                        <tr>
                            <td>
                                <div class="input-group mb-3" style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
                                    <span class="input-group-text" style="background-color: green;"><i class="bi bi-lock" style="color: white;"></i></span>
                                    <input type="email" class="form-control" placeholder="이메일 형식으로 아이디 입력" required aria-label="Recipient's username" aria-describedby="button-addon2" value="${sessionScope.login.memId}" style="border-top-right-radius: 5px; 
                                    border-bottom-right-radius: 5px;" id="emailInput"  disabled>
                                    <input type="hidden" id="memId" name="memId" value="${sessionScope.login.memId}">
                                </div>
                            </td>
                            <td>
                                <div class="input-group mb-3"
                                    style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
                                    <span class="input-group-text" style="background-color: green;">
                                        <i class="bi bi-lock" style="color: white; cursor: pointer;"
                                            data-bs-toggle="modal" data-bs-target="#passwordChangeModal"></i></span>
                                    <input type="password" class="form-control" placeholder="비밀번호" required
                                        aria-label="Recipient's username" aria-describedby="button-addon2"
                                        style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;" id="passwordInput" name="memPw" value="" readonly>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="input-group mb-3" style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
                                    <span class="input-group-text" style="background-color: green;">
                                        <i class="bi bi-pen" style="color: white;"></i>
                                    </span>
                                    <input type="text" class="form-control" placeholder="이름" required aria-label="Recipient's username" value="${sessionScope.login.memNm}" aria-describedby="button-addon2" style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;" id="nameInput" name="memNm">
                                </div>
                            </td>
                            <td>
                                <div style="position: relative;">
                                    <div class="input-group mb-3" style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
                                        <span class="input-group-text" style="background-color: green;">
                                            <i class="bi bi-search" style="color: white; cursor: pointer;" onclick="showAptModal()"></i>
                                        </span>
                                        <input type="text" class="form-control" id="aptInput" name="memRes" placeholder="아파트명" required aria-label="Recipient's username" value="${sessionScope.login.memRes}" aria-describedby="button-addon2" style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;" onfocus="showAptModal()" readonly>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="input-group mb-3" style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
                                    <span class="input-group-text" style="background-color: green;">
                                        <i class="bi bi-telephone" style="color: white;"></i>
                                    </span>
                                    <input type="tel" class="form-control" oninput="hypenTel(this)" maxlength="13" name="memPhone" placeholder="전화번호" required aria-label="Recipient's username" aria-describedby="button-addon2" value="${sessionScope.login.memPhone}" style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;" id="phoneInput" disabled>
                                    <input type="hidden" id="memPhone" name="memPhone" value="${sessionScope.login.memPhone}">
                                </div>
                            </td>
                            <td>
                                <div class="input-group mb-3" style="width: 300px; height: 50px; margin-top: 35px; margin-left: 50px; border-radius: 0;">
                                    <span class="input-group-text" style="background-color: green;">
                                        <i class="bi bi-building-fill" style="color: white;"></i>
                                    </span>
                                    <input type="text" class="form-control" placeholder="단지코드" required aria-label="Recipient's username" value="${sessionScope.login.apartComplexcode}" aria-describedby="button-addon2" id="codeInput" style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;"readonly disabled>
                                    <input type="hidden"  id="codeInput2"  name="apartComplexcode" value="${sessionScope.login.apartComplexcode}">
                                </div>
                            </td>
                        </tr>
                    </table>
                    <button id="login_btn" type="submit" style="margin-top: 30px;">수정하기</button>
                </form>
            </div>
        </div>
    </div>
	
	    <!-- 비밀번호 모달  -->
	    <div class="modal fade" id="passwordChangeModal" tabindex="-1" aria-labelledby="passwordChangeModalLabel" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h5 class="modal-title" id="passwordChangeModalLabel">비밀번호 변경</h5>
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div class="modal-body">
				    <form class="needs-validation" id="login_form" novalidate action="<c:url value='updatePw' />" method="post">
				        <div class="mb-3">
				            <label for="currentPassword" class="form-label">현재 비밀번호</label>
				            <input type="password" class="form-control" id="currentPassword" required name="currentPw">
				        </div>
				        <div class="mb-3">	
				            <label for="newPassword" class="form-label">새 비밀번호</label>
				            <input type="password" class="form-control" id="newPassword" required name="newPw" onblur="fn_newPw(this)" >
				        	<div class="invalid-feedback">기존 비밀번호와 달라야 합니다.</div>
				        </div>
				        <div class="mb-3">
				            <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
				            <input type="password" class="form-control" id="confirmPassword" required name="confirmPw">
				        </div>
				        <input type="hidden" class="form-control" id="memId" required name="memId" value="${login.memId}">
				        <button type="submit" id="check-btn" class="btn btn-primary" style="background-color: green; color: white; margin-left: 408Px">확인</button>
				    </form>
				</div>

            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- 부트스트랩 JS 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/member/mypage.js"></script>

    <!-- Modal -->
    <div class="modal fade" id="aptModal" tabindex="-1" aria-labelledby="aptModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="aptModalLabel">아파트 선택</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                	<h6> <i class="bi bi-circle-fill" style="font-size: 12px;"></i> 대전 내 아파트명으로 입력해주세요.</h6>
                    <div class="input-group mb-3" style="width: 350px;">
                        <input type="text" id="aptSearch" class="form-control" placeholder="아파트 검색" aria-label="Recipient's username" aria-describedby="button-addon2" >
                        <button class="btn btn-outline-secondary" type="button" id="aptSearchBtn" style="background-color: green; color: white;">검색</button>
                    </div>
                    <ul id="aptResult"></ul>
                </div>
            </div>
        </div>
    </div>
    <!-- footer 영역 -->
    <jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
    <script src='resources/js/member/mypage.js'></script>
    <script>
    $(document).ready(function() {
        // DOM이 완전히 로드되었을 때 실행
        const forms = document.querySelectorAll('.needs-validation');
        // 모든 폼 요소를 순회
        Array.from(forms).forEach(function(form) {
            // 각 폼에 'submit' 이벤트 리스너 추가
            form.addEventListener('submit', function(event) {
                // 폼이 유효하지 않을 경우
                if (!form.checkValidity()) {
                    // 폼 제출 방지
                    event.preventDefault();
                    event.stopPropagation();
                }
                // 폼에 'was-validated' 클래스 추가하여 검증 스타일 적용
                form.classList.add('was-validated');
            }, false);
        });
    });

    </script>
</body>
</html>
    
