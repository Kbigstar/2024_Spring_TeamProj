$(document).ready(function() {
    let search_form = $("form[name='search']");
    let cur_page = search_form.find('input[name="curPage"]');
   

    // 페이지 로드 시 스크랩한 뉴스 체크박스 체크
    if (memId) {
        $.ajax({
            type: 'POST',
            url: '/scrapList',
            contentType: 'application/json',
            data: JSON.stringify({ memId: memId }),
            success: function(response) {
            	console.log(response)
            	response.forEach(function(news) {
            		console.log(news.newsNo)
                    $('.scrap-checkbox[data-news-id="' + news.newsNo + '"]').prop('checked', true);
                });
            },
            error: function(xhr, status, error) {
                console.error('스크랩 목록 가져오기 실패: ' + error);
            }
        });
    }

    $("#id_rowSizePerPage").change(function() {
        cur_page.val(1);
        search_form.find('input[name="rowSizePerPage"]').val($(this).val());
        search_form.submit();
    });
    
    $("#sortMethod").change(function(){
    	search_form.submit();
    });
    search_form.find("button[type='submit']").click(function(e) {
        e.preventDefault(); // 디폴트 행동 취소
        cur_page.val(1);
        search_form.submit();
    });

    $('ul.pagination li a[data-page]').click(function(e) {
        e.preventDefault();
        cur_page.val($(this).data('page'));
        search_form.submit();
    });

    $('.title a').click(function(e) {
        e.preventDefault(); // 디폴트 행동 취소

        var newsLink = $(this).attr('href'); // 클릭된 링크의 href 값을 가져옵니다.
        var newsNo = $(this).closest('tr').find('.number').text(); // 해당 뉴스의 번호를 가져옵니다.

        $.ajax({
            type: 'POST', // 요청 방식은 POST
            contentType: 'application/json',
            url: 'updateNewsViews', // 서버로 요청을 보낼 URL
            data: JSON.stringify({ newsNo: newsNo }), // 서버로 전송할 데이터
            success: function(response) {
                console.log('조회수 업데이트 성공');
                // 조회수 업데이트 후 새 창으로 링크 열기
                window.open(newsLink, '_blank');
            },
            error: function(xhr, status, error) {
                console.error('조회수 업데이트 실패: ' + error);
                // 조회수 업데이트 실패 시에도 새 창으로 링크 열기
                window.open(newsLink, '_blank');
            }
        });
    });

    $('.scrap-checkbox').on('change', function() {
        const isChecked = $(this).is(':checked');
        const confirmMessage = isChecked ? '정말 스크랩 하실건가요?' : '정말 취소하시겠습니까?';
        const confirmation = confirm(confirmMessage);
        if (!memId) {
            alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
            window.location.href = "/login"; // 로그인 페이지의 URL로 수정
            return;
        }
        if (!confirmation) {
            $(this).prop('checked', !isChecked);
            return;
        }

        const newsNo = $(this).closest('tr').find('.number').text();
        const url = isChecked ? 'scrapDo' : 'scrapDel';
        const method = 'POST';
        alert(newsNo);
        $.ajax({
            type: method,
            url: url,
            data: { newsNo: newsNo }, // 서버로 전송할 데이터
            success: function(response) {
                console.log(isChecked ? '스크랩 성공' : '스크랩 취소 성공');
            },
            error: function(xhr, status, error) {
                console.error((isChecked ? '스크랩 실패: ' : '스크랩 취소 실패: ') + error);
            }
        });
    });
});
function  fn_scrap(id){
	
	
	if($("#searchScrap").val() == ''){
		$("#searchScrap").val(id);
	}else{
		$("#searchScrap").val("");
	}
	
	
	$("form[name='search']").submit();
	
}

