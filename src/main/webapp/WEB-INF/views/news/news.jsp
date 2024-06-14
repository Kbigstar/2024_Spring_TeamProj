<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>EcoPlanner</title>
<script> var memId = "${sessionScope.login.memId}";  </script>
<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<!-- External CSS -->
<link href="css/news/news.css" rel="stylesheet" />

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=71bc3bb7345e0888cdcfc18cd68a2f38&libraries=services"></script>

</head>

<body>

	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

	<div class="container-fluid p-0" style="margin-top: 50px">

		<div class="container mt-1" style="min-height: 800px">
			<div class="row">

				<form action="<c:url value='/news'  />" method="post" name="search">
				<div class="toolbar">
					<div class="sort-bar">
						<select name="sort" id="sortMethod" class="form-select" aria-label="정렬 방법" style="width: 100px">
						
							<option value="news_no"    ${searchVO.sort eq "news_no" ? "selected='selected'" : "" }>최신순</option>
							<option value="news_views" ${searchVO.sort eq "news_views" ? "selected='selected'" : "" }>조회순</option>
						</select>
					</div>
					 <c:if test="${sessionScope.login !=null }">
						<input type="hidden" name="searchScrap" id="searchScrap" value="${searchVO.searchScrap}"> 
						<input type="checkbox" name="checkbtn" onclick="fn_scrap('${sessionScope.login.memId}')" id="searchScrapMethod"  class="btn-check"  ${searchVO.checkbtn==true ? "checked" : ""}  autocomplete="off" >
						<label class="btn btn-outline-primary" for="searchScrapMethod" style="margin-left: 10px">스크랩</label>
					</c:if>
					<!-- 검색바 -->
					<div class="search-bar">
						<input name="searchWord" class="form-control shadow-none search"
							type="search" placeholder="검색어" aria-label="search"
							value="${searchVO.searchWord }" />
						<button class="search-button btn btn-primary" type="submit">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
				<input type="hidden" name="curPage" value="${searchVO.curPage}"/>
				<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}"/>
				</form>
				<div class="popular-post-list">

					<table class="post-list-table">
						<thead>
							<tr>
								<th class="number">번호</th>
								<th class="title">제목</th>
								<th class="date">작성일</th>
								<th class="views">조회수</th>
								<th class="scrap">스크랩</th>
							</tr>
						</thead>
						<tbody id="newsTableBody">
							<c:choose>
								<c:when test="${empty newsList}">
									<tr>
										<td colspan="5" class="text-center">게시글이 없습니다</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${newsList}" var="news">
										<tr>
											<td class="number">${news.newsNo}</td>
											<td class="title"><a href="${news.newsLink}"
												target="_blank">${news.newsTitle}</a></td>
											<td class="date">${news.newsDt}</td>
											<td class="views">${news.newsViews}</td>
											<td class="scrap ">
												<div
													class="form-check form-switch d-flex justify-content-center">
													<input class="form-check-input mx-auto scrap-checkbox"
														type="checkbox" role="switch" id="flexSwitchCheckDefault_${news.newsNo}"
														data-news-id="${news.newsNo}">
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>

				</div>

			</div>

			<!-- START : 페이지네이션  -->
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center">
					<!-- 이전 페이지 -->
					<c:if test="${searchVO.firstPage != 1}">
						<li class="page-item"><a class="page-link"
							href="newsList?curPage=${searchVO.firstPage - 1}"
							data-page="${searchVO.firstPage - 1}" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<!-- 이전 페이지 -->
					<!-- paging -->
					<c:forEach begin="${searchVO.firstPage}" end="${searchVO.lastPage}"
						var="i">
						<c:if test="${searchVO.curPage == i}">
							<li class="page-item active"><a class="page-link" href="#"
								data-page="${i}">${i}</a></li>
						</c:if>
						<c:if test="${searchVO.curPage != i}">
							<li class="page-item"><a class="page-link"
								href="newsList?curPage=${i}" data-page="${i}">${i}</a></li>
						</c:if>
					</c:forEach>
					<!-- paging -->
					<!-- 다음 페이지 -->
					<c:if test="${searchVO.lastPage != searchVO.totalPageCount}">
						<li class="page-item"><a class="page-link"
							href="newsList?curPage=${searchVO.lastPage + 1}"
							data-page="${searchVO.lastPage + 1}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
					<!-- 다음 페이지 -->
				</ul>
			</nav>
			<!-- END : 페이지네이션  -->

		</div>
	</div>

	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
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
	<script src="js/news/news.js"></script>
	
</body>

</html>
