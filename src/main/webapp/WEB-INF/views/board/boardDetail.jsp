<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner 게시글 상세보기</title>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- External CSS -->
    <link rel="stylesheet" href="styles.css">
    <link href="<c:url value='/css/board/boardDetail.css' />" rel="stylesheet" />
    <!-- <script src="/js/board/boardDetail.js"></script> -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
</head>
<script>
        $(document).ready(function() {
            $('#like-button').on('click', function() {
            	var boardId = $('#boardId').val();
                $.ajax({
                    url: '/board/detail/'+ boardId +"/" +'like',
                    type: 'POST',
                    success: function(response) {
                    	location.reload();
                    },
                    error: function(xhr, status, error) {
                        // Handle any errors here
                        console.log('Error:', error);
                        location.reload();
                    }
                });
            });
            	$('#postComment').on('click', function() {
                	var boardId = $('#boardId').val();
                	var param = {
                		"content": $('#commentInput').val(),
                		"boardId": $('#boardId').val()
                	}
                    $.ajax({
                        url: '/board/detail/'+ boardId +"/" +'comment',
                        type: 'POST',
                        contentType:'application/json',
                        data: JSON.stringify(param),
                        success: function(response) {
                            location.reload();
                        },
                        error: function(xhr, status, error) {
                            // Handle any errors here
                            console.log('Error:', error);
                            location.reload();
                        }
                    });
              });
  

        });
    </script>

<body class="board-body">
    		<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

	<input type="hidden" id="boardId" value="${boardId}" />
    <div class="boardcontainer">
        <div class="post">
            <div class="post-meta">
                <img src="https://i.imgur.com/6VBx3io.png" class="user-avatar" alt="user avatar">
                <div class="post-info">
                    <span class="author">${boardDetail.userId}</span>
                    <span class="post-date">${boardDetail.formattedCreatedAt}</span>
                </div>
            </div>
            <h2>${boardDetail.title}</h2>
            <hr>
            <p>${boardDetail.content}</p>
            
		    <!-- 추천 버튼과 수정, 삭제 링크를 포함하는 컨테이너 추가 시작 -->
		    <div class="actions-container">
		    <!-- 추천 버튼 추가 시작 -->
		        <div id="like-button" class="like-button">추천</div>
		    <!-- 추천 버튼 추가 끝 -->
		    <!-- 수정, 삭제 링크 추가 시작 -->
		        <div class="action-links">
                    <c:if test="${sessionScope.login.memId == boardDetail.userId}">
                        <a  class="edit-link" onclick="updateBoard()" >수정</a>
                        <a  class="delete-link" onclick="deleteBoard()">삭제</a>
                    </c:if>

		        </div>
		    </div>
		    <!-- 수정, 삭제 링크 추가 끝 -->
		    <!-- 공감 버튼과 수정, 삭제 링크를 포함하는 컨테이너 추가 끝 -->
        </div>

        <div class="post-interactions">
            <span id="likeCount"><span>[추천수</span> ${boardDetail.boardLikeCount} 개]</span>
        </div>
        
        <div class="comments">
            <h3>댓글 <span id="commentCount"></span></h3>
            <!-- Comments will be dynamically added here -->
        </div>
        
        <div class="comment">
        	<c:forEach var="item" items="${commentList}">
        		<div class="comments-meta">
                <img src="https://i.imgur.com/6VBx3io.png" class="user-avatar" alt="user avatar">
                <div class="post-info">
                    <span class="author">${item.userId}</span>
                    <span class="post-date">${item.createdAt}</span>
                </div>
	            </div>
	            <div class="actions-container">
			        <p>${item.content}</p>
			        <!--<button class="reply-button">답글</button>
		                <div class="reply-input" style="display: none;">
		                    <textarea placeholder="답글을 입력하세요..."></textarea>
		                    <button class="submit-reply">등록</button>
		                </div>
		            -->
			    </div>
			    
			    <div class="replies">
					<c:forEach var="coItem" items="${item.cocomentList}">
						<div class="comment">
		                    <div class="comments-meta">
		                        <img src="https://i.imgur.com/6VBx3io.png" class="user-avatar" alt="user avatar">
		                        <div class="post-info">
		                            <span class="author">${coItem.userId}</span>
		                            <span class="post-date">${coItem.createdAt}</span>
		                        </div>
		                    </div>
		                    <div class="actions-container">
						        <p>${coItem.content}</p>
						    </div>
                		</div>
					</c:forEach>
				</div>
				
			</c:forEach>
        </div>
<!-- 
        <div class="comment">
            <div class="comments-meta">
                <img src="https://i.imgur.com/6VBx3io.png" class="user-avatar" alt="user avatar">
                <div class="post-info">
                    <span class="author">익명1</span>
                    <span class="post-date">05/27 20:00</span>
                </div>
            </div>
            <div class="actions-container">
		        <p>저희도 전기세가 많이 나왔어요.</p>
		        <div class="action-links">
		            <a href="#" class="edit-link">수정</a>
		            <a href="#" class="delete-link">삭제</a>
		        </div>
		    </div>
            <div class="replies">
                <div class="comment">
                    <div class="comments-meta">
                        <img src="https://i.imgur.com/6VBx3io.png" class="user-avatar" alt="user avatar">
                        <div class="post-info">
                            <span class="author">익명2</span>
                            <span class="post-date">05/27 21:00</span>
                        </div>
                    </div>
                    <div class="actions-container">
				        <p>저희도요. 에어컨 때문인 것 같아요.</p>
				        <div class="action-links">
				            <a href="#" class="edit-link">수정</a>
				            <a href="#" class="delete-link">삭제</a>
				        </div>
				    </div>
                </div>
            </div>
        </div>

        <div class="comment">
            <div class="comments-meta">
                <img src="https://i.imgur.com/6VBx3io.png" class="user-avatar" alt="user avatar">
                <div class="post-info">
                    <span class="author">익명2</span>
                    <span class="post-date">05/27 22:00</span>
                </div>
            </div>
            <div class="actions-container">
		        <p>다들 많이 나왔네요. 절약해야겠어요.</p>
		        <div class="action-links">
		            <a href="#" class="edit-link">수정</a>
		            <a href="#" class="delete-link">삭제</a>
		        </div>
		    </div>
        </div>
         -->
        <div class="comment-form">
            <input type="text" id="commentInput" placeholder="댓글을 입력하세요">
            <button id="postComment" class="postComment"">댓글 작성</button>
        </div>
        
    </div>

    <!-- 글목록 버튼 추가 시작 -->
    <div class="button-container">
        <div></div> <!-- Left space for alignment -->
        <!-- <div class="list-button">글목록</div> --> 
        <button class="list-button" onclick="location.href='/board?page=1&size=5'">글목록</button >
    </div>
    <!-- 글목록 버튼 추가 끝 -->

    




    			<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	<script>
	const hiddenBoardId = document.getElementById('boardId').value;
   	function updateBoard(){
		location.href = `/board/update/\${hiddenBoardId}`;
	}
	function deleteBoard(){
		if (confirm('삭제 하시겠습니까?')) {
			location.href = `/board/delete/\${hiddenBoardId}`;
		} else {
			return false;
		}
		
	}
	</script>

</body>

</html>