var receivedVerificationCode; // 인증번호를 저장할 변수 선언
var receivedVerificationCode2; // 이메일 인증
var userEmail;// 이메일

function validateForm() {
	const usernameInput = document.getElementById('username');
	const passwordInput = document.getElementById('password');
	const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

	let isValid = true;

	if (!emailRegex.test(usernameInput.value.trim())) {
		usernameInput.classList.add('is-invalid');
		document.getElementById('usernameError').style.display = 'block';
		isValid = false;
	} else {
		usernameInput.classList.remove('is-invalid');
		document.getElementById('usernameError').style.display = 'none';
	}

	if (passwordInput.value.trim() === '') {
		passwordInput.classList.add('is-invalid');
		document.getElementById('passwordError').style.display = 'block';
		isValid = false;
	} else {
		passwordInput.classList.remove('is-invalid');
		document.getElementById('passwordError').style.display = 'none';
	}

	return isValid;
}

/* 전화번호 - 표시 */
function hypenTel(target) {
	target.value = target.value.replace(/[^0-9]/g, '') // 숫자가 아닌 문자는 제거
	.replace(/(\d{11})\d+$/, '$1') // 최대 11자리까지만 허용
	.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`); // 형식에 맞게 하이픈 추가
}

function validateForm1() {
	var username = document.getElementById('username1').value;
	var password = document.getElementById('password1').value;
	var isValid = true;

	if (!username) {
		document.getElementById('usernameError1').style.display = 'block';
		isValid = false;
	} else {
		document.getElementById('usernameError1').style.display = 'none';
	}

	if (!password) {
		document.getElementById('passwordError1').style.display = 'block';
		isValid = false;
	} else {
		document.getElementById('passwordError1').style.display = 'none';
	}

	return isValid;
}

$(document).ready(function() {
	// 페이지가 로드될 때 아이디 입력 화면을 보이도록 설정
	$("#search").show();
	$("#search2").hide();

	// 라디오 버튼 클릭 이벤트 설정
	$(".form-check-input").click(function() {
		if ($(this).attr("id") == "flexRadioDefault1") {
			console.log("아이디");
			$("#search").show();
			$("#search2").hide();
		} else if ($(this).attr("id") == "flexRadioDefault2") {
			console.log("비밀번호");
			$("#search").hide();
			$("#search2").show();
		}
	});
	// 버튼 클릭
	$('input').keydown(function() {
		if (event.keyCode === 13) {
			event.preventDefault();
		}
	});
});

// 아이디 찾기 모달
$(document).ready(function() {

	// 확인 버튼 클릭 시 인증 처리
	$('#verifyButton').click(function() {
		var verificationCode = $('#verificationCode').val();
		// 사용자가 입력한 인증번호와 서버에서 전송된 인증번호를 비교하여 인증 처리
		if (verificationCode == receivedVerificationCode) {
			console.log("인증 성공");
			// 성공한 경우
			alert("인증에 성공했습니다.");
			// 서버로 전화번호를 전송하여 아이디 요청
			$.ajax({
				url : '/idfindDo',
				type : 'POST',
				data : {
					memPhone : $("#inputPhone_1").val(),
					memNm : $("#inputName_1").val()
				},
				success : function(data) {
					console.log("아이디: ", data);

					// 받은 아이디를 모달에 표시
					$('#userId').text(data.memId);
					$('#userIdDisplay').show();
				},
				error : function(xhr, status, error) {
					console.error('Error fetching data: ', status, error);
				}
			});
		} else {
			console.log("인증 실패");
			// 실패한 경우
			alert("인증에 실패했습니다.");
		}
	});

	$("#find_username_btn").click(function() {
		memPhone = $("#inputPhone_1").val(); // 전역 변수로 memPhone 저장
		console.log(memPhone);

		// 서버로 전화번호를 전송하여 인증번호 요청
		$.ajax({
			url : '/sendSMS',
			type : 'GET',
			data : {
				memPhone : memPhone
			},
			success : function(data) {
				console.log("==================");
				console.log("인증번호: ", data);

				// 서버에서 받은 인증번호를 변수에 저장
				receivedVerificationCode = data
				console.log(receivedVerificationCode)

				// 모달 열기
				$('#idAuthenticationModal').modal('show');
			},
			error : function(xhr, status, error) {
				console.error('Error fetching data: ', status, error);
			}
		});
	});
});

var verificationModal;

// 비밀번호 찾기 모달
document.getElementById('pwSearchForm').addEventListener(
		'submit',
		function(event) {
			event.preventDefault();
			var email = document.getElementById('userEmail').value;
			if (email) {
				verificationModal = new bootstrap.Modal(document
						.getElementById('verificationModal'));
				verificationModal.show();
			}
			// 비밀번호 모달창 닫기
			$('#verificationModal .btn-close').on('click', function() {
				verificationModal.hide(); // 비밀번호 모달 닫기
			});
		});

// "확인" 버튼 클릭 시 새 비밀번호 모달 열기
document.getElementById('pw_Search').addEventListener(
	    'click',
	    function(event) {
	        event.preventDefault();
	        verificationModal.hide(); // 전역 변수로 이미 정의된 verificationModal을 사용하여 hide() 호출
	        var verificationCode = document.getElementById('verificationCode2').value;
	        // 여기서는 인증 코드를 확인하고 새 비밀번호 모달을 열도록 로직을 추가합니다.
	        if (verificationCode == receivedVerificationCode2) {
	            // 인증 코드가 일치하는 경우 새 비밀번호 모달을 엽니다.
	            var newPasswordModal = new bootstrap.Modal(document.getElementById('newPasswordModal'));
	            newPasswordModal.show();
	            // 새 비밀번호 모달에 닫기 버튼 클릭 이벤트 추가
	            $('#newPasswordModal .btn-close').on('click', function() {
	                newPasswordModal.hide(); // 새 비밀번호 모달 닫기
	            });
	        } else {
	            // 인증 코드가 일치하지 않는 경우에 대한 처리
	            alert("인증에 실패했습니다. 올바른 인증번호를 입력해주세요.");
	        }
	    });

// "새 비밀번호" 모달에서 확인 버튼 클릭 시 수행할 작업
document.getElementById('confirmedNewPasswordBtn').addEventListener(
		'click',
		function(event) {
			event.preventDefault();
			// 새 비밀번호 설정 등의 작업을 여기에 추가합니다.
			var newPassword = document.getElementById('newPassword').value;
			var confirmedNewPassword = document
					.getElementById('confirmedNewPassword').value;
			if (newPassword === confirmedNewPassword) {
				$.ajax({
					url : '/updateSearchPw', // 이메일을 검증할 서버의 URL
					type : 'POST', // POST 요청 사용
					contentType : 'application/json',
					data : JSON.stringify({
						memId : userEmail,
						memPw : newPassword
					}),
					success : function(response) {
						if (response) {
							// 서버로부터 받은 응답이 존재하는 경우 (인증번호를 받은 경우)
							alert("새로운 비밀번호가 설정되었습니다.");
							window.location.href = '/login';
						} else {
							// 비밀번호가 일치하지 않는 경우에 대한 처리
							alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
						}
					}
				});
			}
		});

// 이메일 인증번호 전송
document.getElementById('pwSearchForm').addEventListener(
		'submit',
		function(event) {
			event.preventDefault();
			var email = document.getElementById('userEmail').value;
			if (email) {
				// AJAX를 사용하여 서버로 이메일을 전송
				$.ajax({
					url : '/sendMailDo', // 이메일을 검증할 서버의 URL
					type : 'POST', // POST 요청 사용
					contentType : 'application/json',
					data : JSON.stringify({
						email : email
					}), // 전송할 데이터: 이메일
					success : function(response) {
						console.log(response);
						if (response) {
							// 서버로부터 받은 응답이 존재하는 경우 (인증번호를 받은 경우)
							alert('인증번호가 이메일로 전송되었습니다.');
							receivedVerificationCode2 = response;
							// 여기에 인증번호를 처리하는 코드 작성
						} else {
							// 서버로부터 응답이 없는 경우 (유효하지 않은 이메일인 경우)
							alert('유효하지 않은 이메일입니다.');
						}
					},
					error : function(xhr, status, error) {
						console.error('이메일 유효성 검사 요청 전송 중 오류 발생: ', status,
								error);
						// 에러 처리 등의 로직 추가
					}
				});
			} else {
				alert('이메일을 입력하세요.');
			}
		});
// 중복 이메일
function fn_email_check() {
	// 중복 이메일 체크를 위해 입력된 아이디 가져오기
	var memEmail = $('#userEmail').val();

	// 이메일 중복 체크 AJAX 요청
	$.ajax({
		url : "/emailCheck", // 중복 이메일 체크를 처리할 URL
		type : 'POST',
		contentType : 'application/json',
		data : JSON.stringify({
			memId : memEmail
		// 입력된 아이디를 전송
		}),
		success : function(res) {
			console.log(res);
			// 서버로부터 받은 응답에 따라 처리
			if (res === "null") {
				// 중복된 전화번호인 경우 처리
				alert("가입이 되지 않은 이메일입니다. 다른 이메일를 입력해주세요.");
				$('#userEmail').val("");
				// $('#userEmail').focus();
			} else {
				$('#userEmail').attr("disabled", "disabled");
				$("#btn_email").hide();
				$("#find_password_btn").show();
				alert("가입된 이메일입니다. 비밀번호 찾기를 눌러주세요");
				userEmail = $('#userEmail').val();
				console.log(userEmail);
			}
		},
		error : function(e) {
			console.log(e);
			alert("이메일 확인 중 오류가 발생했습니다. 다시 시도해 주세요.");
		}
	});

}

// 인증 확인
$(document).ready(function() {
	$('#pw_Search').click(function() {
		var verificationCode2 = $('#verificationCode2').val();
		// 사용자가 입력한 인증번호와 서버에서 전송된 인증번호를 비교하여 인증 처리
		if (verificationCode2 == receivedVerificationCode2) {
			console.log("인증 성공");
			// 성공한 경우
			alert("인증에 성공했습니다.");

			// 새 비밀번호 설정 모달 열기 등 추가 작업 수행
			// 예: $('#newPasswordModal').modal('show');
		} else {
			// 인증 실패 시 처리
			alert("인증에 실패했습니다.");
		}
	});
});
