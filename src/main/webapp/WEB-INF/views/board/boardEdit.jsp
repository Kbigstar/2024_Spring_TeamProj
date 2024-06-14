<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner 게시글 수정</title>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- External CSS -->
    <link rel="stylesheet" href="styles.css">
    <link href="<c:url value='/css/board/boardEdit.css' />" rel="stylesheet" />
    <!-- <script src="/js/board/boardDetail.js"></script> -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
</head>
<script>
   
	let boardId;
	let cancleBtn;
	let updateBtn;
	let title;
	let content;
	let categoryId;
	let categorySelect;
	
    document.addEventListener('DOMContentLoaded',() => {
    	 listBtn = document.getElementById('listBtn');
    	    cancelBtn = document.getElementById('cancelBtn');
    	    updateBtn = document.getElementById('updateBtn');

    	    boardId = document.getElementById('boardId').value;
    	    title = document.getElementById('updateTitle').value;
    	    content = document.getElementById('updateContent').value;
    	    categorySelect = document.getElementById('categoryId');
    	    
    	    
        listBtn.addEventListener('click', goToList);
        cancelBtn.addEventListener('click', cancel);
        updateBtn.addEventListener('click', update);

      
    });
    function update(){
        let param = {
            title: document.getElementById('updateTitle').value,
            content: document.getElementById('updateContent').value,
            boardId,
            categoryId: categorySelect.options[categorySelect.selectedIndex].value
        }
		if (confirm('수정 하시겠습니까?')) {
			   $.ajax({
		            url: '/board/update',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify(param),
		            success: function(response) {

		                location.href = `/board/detail/\${boardId}`;
		            },
		            error: function(xhr, status, error) {
		                console.log('Error:', error);
		            }
		        });
    	} else {
    		return false;
    	}
    
    }
    const goToList = () => {
        location.href = `/board?page=1&size=5`;
    }
    const cancel = () => {
        location.href = `/board/detail/\${boardId}`;
    }

   

</script>

<body class="board-body">
<!-- nav 영역 -->
<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

<input type="hidden" id="boardId" value="${board.boardId}"/>
<div class="container mt-5 post-form-container">
        <h2 class="post-form-header">게시글 수정</h2>
        <form id="postForm" class="post-form" action="/board" method="post">
            <div class="mb-3 form-group">
                <label for="postTitle" class="form-label">제목</label>
                <input type="text" name="title" class="form-control" id="updateTitle" required value="${board.title}">
            </div>
            <div class="mb-3 form-group">
                <label for="postCategory" class="form-label">카테고리 선택</label>
                <select class="form-select" id="categoryId" name="categoryId" required>
                    <option value="" >카테고리 선택...</option>
                    <option value="1" ${board.boardMasterId == 1 ? 'selected' : ''}>자유게시판</option>
                    <option value="2" ${board.boardMasterId == 2 ? 'selected' : ''}>관리비</option>
                    <option value="3" ${board.boardMasterId == 3 ? 'selected' : ''}>절약 팁</option>
                    <option value="4" ${board.boardMasterId == 4 ? 'selected' : ''}>유머</option>
                    <option value="5" ${board.boardMasterId == 5 ? 'selected' : ''}>우리 아파트 장터</option>
                    <option value="6" ${board.boardMasterId == 6 ? 'selected' : ''}>주변 상권 이야기</option>
                    <option value="7" ${board.boardMasterId == 7 ? 'selected' : ''}>부동산 이야기</option>
                </select>
            </div>
            <div class="mb-3 form-group">
                <label for="postContent" class="form-label">내용</label>
                <textarea name="content" class="form-control" id="updateContent" rows="3" required>${board.content}</textarea>
            </div>
            <!--
            <div class="mb-3 form-group">
                <label for="postImage" class="form-label">이미지 첨부</label>
                <input type="file" class="form-control" id="postImage" accept="image/*">
            </div>
            -->
            <c:if test="${boardId} != null">
            <input type="hidden" name="boardId" value="${boardId}">
            </c:if>
        </form>
    </div>
<!-- 글목록 버튼 추가 시작 -->
<div class="button-container">
    <div></div> <!-- Left space for alignment -->
    <div class="list-button" id="listBtn">글목록</div>
    <div class="list-button" id="cancelBtn">취소</div>
    <div class="list-button" id="updateBtn">수정</div>
</div>
<!-- 글목록 버튼 추가 끝 -->

<!-- footer 영역 -->
<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

</body>

</html>