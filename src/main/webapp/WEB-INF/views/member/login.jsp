<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner</title>
     <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="resources/css/member/member.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src='resources/js/member/login.js'></script>
</head>
<body>
    <c:if test="${not empty msg}">
        <script>
            alert("${msg}");
        </script>
    </c:if>
    <!-- nav 영역 -->
    <jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
    <div class="container-fluid"
        style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 90vh;">
        <div class="login_wrapper" style="margin-bottom: 80px; margin-top: 80px;">
            <div class="logo">
                <div style="font-size: 50px;">로그인</div>
                <hr>
                <form class="login_form" style="margin-top: 40px;" action="<c:url value='/loginDo'/>" method="post">
                    <div class="input-group mb-3"
                        style="width: 300px; height: 50px; margin-top: 35px; margin-left: 230px; border-radius: 0;">
                        <span class="input-group-text" style="background-color: green;"><i
                                class="bi bi-person" style="color: white;"></i></span>
                        <input value="${cookie.rememberId != null ? cookie.rememberId.value : ''}" type="email" class="form-control" id="username"  name="memId" placeholder="아이디" required
                            aria-label="Recipient's username" aria-describedby="button-addon2"
                            style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;">
                        <div class="invalid-feedback" id="usernameError" style="display: none;">
                            	이메일 형식으로 입력해주세요.
                        </div>
                    </div>
                    <div class="input-group mb-3"
                        style="width: 300px; height: 50px;  margin-left: 230px; border-radius: 0;">
                        <span class="input-group-text" style="background-color: green;"><i
                                class="bi bi-lock" style="color: white;"></i></span>
                        <input type="password" class="form-control" id="password" name="memPw" placeholder="비밀번호" required
                            aria-label="Recipient's username" aria-describedby="button-addon2"
                            style="border-top-right-radius: 5px; border-bottom-right-radius: 5px;">
                        <div class="invalid-feedback" id="passwordError" style="display: none;">
                            	비밀번호를 입력해주세요.
                        </div>
                    </div>
                    <div style="margin-top: 5px;">
                        <label><input id="keep" type="checkbox" name="remember"
                                style="margin-top: -0.5px;" ${cookie.rememberId != null ? "checked" : ""} ><span>아이디 저장</span></label>
                    </div>
                    <button id="login_btn" type="submit" onclick="return validateForm()">로그인</button>
                </form>
                <div style="display: flex; justify-content: space-between; width: 300px; margin: 0 auto;">
                    <a class="ac" href="<c:url value='regist'/>">회원가입</a>
                    <a class="ac" href="<c:url value='idpw'/>">아이디 / 비밀번호 찾기</a>
                </div>
            </div>
        </div>
    </div>
    <!-- footer 영역 -->
    <jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

<!--     Bootstrap JS
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5zs9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2/dist/umd/popper.min.js"></script>
 -->    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="resources/js/member/login.js"></script>
</body>
</html>
