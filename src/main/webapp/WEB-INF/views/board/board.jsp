<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EcoPlanner 게시판</title>
<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<link href="<c:url value='/css/board/board.css' />" rel="stylesheet" />

</head>
<body class="board-body">

	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

					<div style="margin-left: 120px;">
						<h1>${sessionScope.login.apartBuildingnm}</h1>
					</div>
	<div class="container-fluid p-0" style="height: 90vh;">
					
		<div class="container mt-1">
			<div class="row">
				<form action="<c:url value='/board'  />" method="get" name="search" id="searchForm">
				<input type="hidden" value="${boardVo.boardMasterId}" name="boardMasterId">
				<div class="toolbar">
					
					<div class="sort-bar">
						<select name="sort" id="sortMethod" class="form-select" aria-label="정렬 방법" style="width: 100px">
							<option value="lastest" ${boardVo.sort eq "lastest" ? "selected='selected'" : "" }>최신순</option>
							<option value="views" ${boardVo.sort eq "views" ? "selected='selected'" : "" }>조회순</option>
							<!--
							<option value="recommand">추천순</option>
							<option value="reply">댓글순</option>
							 -->
						</select>
					</div>
				
					<div class="search-bar">
						<input type="text" name="searchWord" placeholder="검색어를 입력해 주세요.">
						<button class="search-button" type="submit">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
				</form>
				<div class="category-bar">
					<ul>
						<li><a href="/board?boardMasterId=1">자유게시판</a></li>
						<li><a href="/board?boardMasterId=2">관리비</a></li>
						<li><a href="/board?boardMasterId=3">절약 팁</a></li>
						<li><a href="/board?boardMasterId=4">유머</a></li>
						<li><a href="/board?boardMasterId=5">우리 아파트 장터</a></li>
						<li><a href="/board?boardMasterId=6">주변 상권 이야기</a></li>
						<li><a href="/board?boardMasterId=7">부동산 이야기</a></li>
					</ul>
				</div>



				<div class="popular-post-list">

					<table class="post-list-table">
						<thead>
							<tr>
								<th class="number">번호</th>
								<th class="category">분류</th>
								<th class="title">제목</th>
								<th class="author">작성자</th>
								<th class="date">작성일</th>
								<th class="views">조회</th>
								<th class="recommendation">추천</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${popularBoardList}">
							<tr class="highlighted">
								<td><span class="tag-popular">인기</span></td>
								<td>${item.categoryName}</td>
								<td><a href="/board/detail/${item.boardId}">${item.title}</a></td>
								<td>${item.userId}</td>
								<td>${item.formattedCreatedAt}</td>
								<td>${item.viewCount}</td>
								<td>${item.boardLikeCount}</td>
							</tr>
							</c:forEach>
							<c:forEach var="item" items="${boardData.contents}" varStatus="status">
							<tr>
								<td>${item.dataId}</td>
								<td>${item.categoryName}</td>
								<td><a href="/board/detail/${item.boardId}">${item.title}</a></td>
								<td>${item.userId}</td>
								<td>${item.formattedCreatedAt}</td>
								<td>${item.viewCount}</td>
								<td>${item.boardLikeCount}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
				<div class="page-submit-wrapper">
				    <div class="pagination">
				        <c:if test="${boardData.curPage > 1}">
				            <a href="/board?page=${boardData.curPage - 1}&size=${boardData.pageSize}">이전</a>
				        </c:if>
				        <%-- 페이징 번호 출력 --%>
				        <c:forEach var="pageNum" begin="${boardData.startPage}" end="${boardData.endPage}">
					        <c:choose>
					        	<c:when test="${boardVo.boardMasterId == null}">
					        		<a href="/board?page=${pageNum}&size=${boardData.pageSize}" class="${pageNum eq boardData.curPage ? 'current-page' : ''}">${pageNum}</a>
					        	</c:when>
					        	<c:otherwise>
					        		<a href="/board?boardMasterId=${boardVo.boardMasterId}&page=${pageNum}&size=${boardData.pageSize}" class="${pageNum eq boardData.curPage ? 'current-page' : ''}">${pageNum}</a>
					        	</c:otherwise>
					        </c:choose>
				        </c:forEach>
				
				        <c:if test="${boardData.curPage < boardData.totalPage}">
				            <a href="/board?page=${boardData.curPage + 1}&size=${boardData.pageSize}">다음</a>
				        </c:if>
				    </div>
				
				    <!-- 게시글 작성 버튼 -->
				    <a href="<c:url value='/board/write'/>" class="btn btn-primary create-post-button">게시글 작성</a>
				</div>
                
                    
            </div>            
        </div>

	<!-- footer 영역 -->
	<script>
	const searchForm = document.getElementById('searchForm');
	const sortType = document.getElementById('sortMethod');

	let hiddenBoardId;


	document.addEventListener('DOMContentLoaded', () => {

		let boardId = document.getElementById('boardId');
		hiddenBoardId = boardId == null ? '' : boardId.value;
		
	})
	sortType.addEventListener("change",() => {
			searchForm.submit();
		})

	const updateBoard = () => {
		location.href = `/board/update/${hiddenBoardId}`;
	}
	const deleteBoard = () => {
		location.href = `/board/delete/${hiddenBoardId}`;
	}

	</script>	
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	<%--<script src="js/board/board.js"></script> --%>
</body>
</html>