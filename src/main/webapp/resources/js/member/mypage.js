function validateForm() {
    var isValid = true;
    var emailInput = document.querySelector('input[type="email"]');
    var inputs = document.querySelectorAll('input[type="text"], input[type="password"], input[type="tel"]');

    inputs.forEach(function (input) {
        if (!input.value.trim()) {
            input.classList.add("is-invalid");
            input.nextElementSibling.style.display = "block";
            isValid = false;
        } else {
            input.classList.remove("is-invalid");
            input.nextElementSibling.style.display = "none";
        }
    });

    if (emailInput && !validateEmail(emailInput.value.trim())) {
        emailInput.classList.add("is-invalid");
        emailInput.nextElementSibling.style.display = "block";
        isValid = false;
    } else if (emailInput) {
        emailInput.classList.remove("is-invalid");
        emailInput.nextElementSibling.style.display = "none";
    }

    return isValid;
}

/* 이메일 형식 */
function validateEmail(email) {
    const re = /\S+@\S+\.\S+/;
    return re.test(email);
}

/* 전화번호 - 표시 */
function hypenTel(target){
    target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`)
};


// 모달에서 선택한 아파트명을 입력란에 설정하는 함수
function showAptModal() {
    $('#aptModal').modal('show');
}

function setAptName(aptName) {
    $('#aptInput').val(aptName);
    $('#aptModal').modal('hide');
}


var keywords = [];

var aptNm; // aptNm 변수를 전역 변수로 선언
document.addEventListener("DOMContentLoaded", function(){
    // keywordInput과 suggestionsList 요소가 HTML 문서 내에 있는지 확인
    var keywordInput = document.getElementById('aptSearch');
    var suggestionsList = document.getElementById('aptResult');

    // 검색 버튼에 클릭 이벤트 리스너 추가
    var searchBtn = document.getElementById('aptSearchBtn');
    if (searchBtn) {
        searchBtn.addEventListener('click', function() {
            var input = keywordInput.value.toLowerCase(); // 입력된 검색어를 소문자로
															// 변환하여 비교
            suggestionsList.innerHTML = ''; // 자동완성 제안 목록 초기화
            let data22 = $("#aptSearch").val();
            console.log(data22);
            fetchDistrictData(data22);
        });
    }
    
    // Enter 키를 눌렀을 때도 검색 실행
    keywordInput.addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            var input = keywordInput.value.toLowerCase(); // 입력된 검색어를 소문자로
															// 변환하여 비교
            suggestionsList.innerHTML = ''; // 자동완성 제안 목록 초기화
            let data22 = $("#aptSearch").val();
            console.log(data22);
            fetchDistrictData(data22);
        }
    });
});

// AJAX 요청 함수
function fetchDistrictData(apartment) {
    $.ajax({
        url: '/aptGetRes',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ apartBuildingnm: apartment }),
        success: function(data) {
            console.log("==================");
            console.log(data);
            
            // 입력과 일치하는 데이터를 가지고 제안 목록을 구성
            buildSuggestionsList(data);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ', status, error);
        }
    });
}

// 제안 목록을 구성하는 함수
function buildSuggestionsList(data) {
    var keywordInput = document.getElementById('aptSearch');
    var suggestionsList = document.getElementById('aptResult');
    var input = keywordInput.value.toLowerCase(); // 입력된 검색어를 소문자로 변환하여 비교
    
    // 입력과 일치하는 데이터만을 가지고 제안 목록을 구성
    data.forEach(function(item) {
        var keyword = item.apartProvince + " " + item.apartDistrict + " " + item.apartNeighborhood + " " + item.apartBuildingnm;
        if (keyword.includes(input)) {
            // 아파트명과 단지 코드를 객체로 묶어서 저장
            var suggestion = {
                aptName: keyword,
                aptCode: item.apartComplexcode
            };
            var li = document.createElement('li');
            li.textContent = suggestion.aptName; // 아파트명만 표시
            li.suggestion = suggestion; // 아파트명과 단지 코드를 li 요소의 프로퍼티로 저장
            li.addEventListener('click', function() {
                keywordInput.value = this.suggestion.aptName; // 클릭한 제안의 아파트명을
																// 입력 필드에 설정
                suggestionsList.innerHTML = ''; // 자동완성 제안 목록 숨기기
                console.log("선택한 아파트: " + this.suggestion.aptName); // 선택한 아파트명을
																	// 콘솔에 출력
                console.log("선택한 아파트의 단지 코드: " + this.suggestion.aptCode); // 선택한 아파트의 단지코드를 콘솔에 출력
                
                aptNm = this.suggestion.aptName; // aptNm 값을 설정
                $('#aptInput').val(aptNm); // aptInput input 요소에 aptNm 값을 설정
                $('#codeInput').val(this.suggestion.aptCode);              
                $('#codeInput2').val(this.suggestion.aptCode);              
                $('#aptModal').modal('hide');
            });
            suggestionsList.appendChild(li);
        }
    });
    

    
}


// 아이디 입력란에서 탭을 눌렀을 때 모달창 띄우기
document.getElementById('emailInput').addEventListener('keydown', function(event) {
    if (event.key === 'Tab') {
        $('#passwordChangeModal').modal('show');
    }
});

//비밀번호 입력란을 클릭했을 때 모달창 띄우기
document.getElementById('passwordInput').addEventListener('click', function() {
    $('#passwordChangeModal').modal('show');
});

// 비밀번호 확인 플래그 변수
var checkPw = false;

// 현재 비밀번호 확인 함수
function checkCurrentPassword(memId, newPw) {
     $.ajax({
        type: "POST",
        url: "/checkCurrentPassword", // 현재 비밀번호를 확인하는 서버 URL
        data: {
            memId: memId, // 회원 ID
            newPw: newPw // 새 비밀번호
        },
        success: function(data) {
            if (data) {
                // 비밀번호 확인 성공 시
                $("#newPassword").val(''); // 새 비밀번호 입력란 초기화
                $("#login_form").addClass('was-validated'); // 로그인 폼에 'was-validated' 클래스 추가
            }
        },
        error: function(xhr, status, error) {
            console.error('데이터 가져오는 중 오류 발생: ', status, error);
        }
     });
}	

// 새로운 비밀번호 확인 함수
function fn_newPw(obj) {
	var memId = $("#memId").val(); // 회원 ID 가져오기
	var newVal = $(obj).val(); // 새 비밀번호 값 가져오기
	checkCurrentPassword(memId, newVal); // 현재 비밀번호 확인 함수 호출
}


	