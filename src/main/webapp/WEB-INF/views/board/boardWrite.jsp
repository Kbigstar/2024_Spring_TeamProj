<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner 게시글 작성</title>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- External CSS -->
    <link rel="stylesheet" href="styles.css">
    <link href="<c:url value='/css/board/boardWrite.css' />" rel="stylesheet" />

        
</head>

<body>
    		<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>




        <!-- 게시글 작성 폼 -->

    <div class="container mt-5 post-form-container">
        <h2 class="post-form-header">게시글 작성</h2>
        <form id="postForm" class="post-form" action="/board" method="post">
            <div class="mb-3 form-group">
                <label for="postTitle" class="form-label">제목</label>
                <input type="text" name="title" class="form-control" id="title" required>
            </div>
            <div class="mb-3 form-group">
                <label for="postCategory" class="form-label">카테고리 선택</label>
                <select class="form-select" id="categoryId" name="categoryId" required>
                    <option value="">카테고리 선택...</option>
                    <option value="1">자유게시판</option>
                    <option value="2">관리비</option>
                    <option value="3">절약 팁</option>
                    <option value="4">유머</option>
                    <option value="5">우리 아파트 장터</option>
                    <option value="6">주변 상권 이야기</option>
                    <option value="7">부동산 이야기</option>
                </select>
            </div>
            <div class="mb-3 form-group">
                <label for="postContent" class="form-label">내용</label>
                <textarea name="content" class="form-control" id="content" rows="3" required></textarea>
            </div>
            <!--
            <div class="mb-3 form-group">
                <label for="postImage" class="form-label">이미지 첨부</label>
                <input type="file" class="form-control" id="postImage" accept="image/*">
            </div>
            -->
 
            <button type="submit" class="btn btn-primary post-submit-button">게시글 작성</button>
        </form>
    </div>
    




    			<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

</body>

</html>