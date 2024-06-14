document.addEventListener('DOMContentLoaded', function() {
    const currentUsageInput = document.getElementById('currentUsageInput');
    const targetUsageInput = document.getElementById('targetUsageInput');
    const currentBillInput = document.getElementById('currentBillInput');
    const targetBillInput = document.getElementById('targetBillInput');
    const summerCheck = document.getElementById('summerCheck');

    // 현재 월이 7월이나 8월이면 summerCheck를 체크 상태로 설정
    const currentMonth = new Date().getMonth() + 1; // getMonth()는 0부터 11까지의 값을 반환하므로 +1 필요
    if (currentMonth === 7 || currentMonth === 8) {
        summerCheck.checked = true;
    }

    // 입력 필드의 최대값을 강제하는 함수
    function enforceMaxValue(event) {
        const maxValue = 1000;
        if (parseInt(event.target.value) > maxValue) {
            event.target.value = maxValue; // 초과 값 입력 시 최대값으로 설정
        }
    }

    // 입력 필드에 이벤트 리스너 추가
    currentUsageInput.addEventListener('input', enforceMaxValue);
    targetUsageInput.addEventListener('input', enforceMaxValue);

    const calcButton = document.querySelector('.calc-button');
    const treeContainer = document.querySelector('#treeContainer');
    const coinContainer = document.querySelector('#coinContainer');
    const treeCountSpan = document.querySelector('#treeCount');
    const savingsAmount = document.querySelector('#savingsAmount');

    // AJAX 요청을 사용하여 서버에서 전기세 값을 가져오는 함수
    function fetchElectricityBill(usage, callback) {
        const endpoint = summerCheck.checked ? '/calculateSummerBill' : '/calculateBill';
        
        $.ajax({
            url: endpoint, // 체크박스 상태에 따라 엔드포인트 설정
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ elecUseage: usage }),
            success: function(data) {
                console.log('서버 응답 데이터:', data); // 서버 응답 데이터 로그
                if (Array.isArray(data) && data.length > 0) {
                    callback(data[0].totalBillAmount);
                } else {
                    console.error('Unexpected response format:', data);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching data: ', status, error);
            }
        });
    }

    // 계산 로직 수행 함수
    function performCalculation() {
        const currentUsage = parseInt(currentUsageInput.value, 10);
        const targetUsage = parseInt(targetUsageInput.value, 10);
        const usageDifference = currentUsage - targetUsage;

        fetchElectricityBill(currentUsage, function(currentBillAmount) {
            console.log('currentBillAmount:', currentBillAmount); // 디버깅을 위한 로그 추가
            currentBillInput.value = currentBillAmount;

            fetchElectricityBill(targetUsage, function(targetBillAmount) {
                console.log('targetBillAmount:', targetBillAmount); // 디버깅을 위한 로그 추가
                targetBillInput.value = targetBillAmount;

                const savings = currentBillAmount - targetBillAmount;
                savingsAmount.innerHTML = "<strong>" + `${savings.toLocaleString()}` + "</strong>"; // 절약 금액 포맷하여 표시

                const treesRequired = Math.max(0, Math.floor(usageDifference / 150));

                treeContainer.innerHTML = ''; // 이전 나무 이미지 제거
                coinContainer.innerHTML = ''; // 이전 코인 이미지 제거
                treeCountSpan.textContent = treesRequired;

                // 필요한 만큼 나무 SVG 추가
                for (let i = 0; i < treesRequired; i++) {
                    treeContainer.innerHTML += `<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="green" class="bi bi-tree-fill" viewBox="0 0 16 16">
                    <path d="M8.416.223a.5.5 0 0 0-.832 0l-3 4.5A.5.5 0 0 0 5 5.5h.098L3.076 8.735A.5.5 0 0 0 3.5 9.5h.191l-1.638 3.276a.5.5 0 0 0 .447.724H7V16h2v-2.5h4.5a.5.5 0 0 0 .447-.724L12.31 9.5h.191a.5.5 0 0 0 .424-.765L10.902 5.5H11a.5.5 0 0 0 .416-.777z" />
                </svg>`;
                }

                // 절약 금액에 따라 코인 SVG 추가
                if (savings >= 10000) {
                    for (let i = 0; i < Math.floor(savings / 10000); i++) {
                        coinContainer.innerHTML += `<svg xmlns="http://www.w3.org/2000/svg" width="70" height="70" fill="currentColor" class="bi bi-coin" viewBox="0 0 16 16" style="margin: 5px;">
                        <path d="M5.5 9.511c.076.954.83 1.697 2.182 1.785V12h.6v-.709c1.4-.098 2.218-.846 2.218-1.932 0-.987-.626-1.496-1.745-1.76l-.473-.112V5.57c.6.068.982.396 1.074.85h1.052c-.076-.919-.864-1.638-2.126-1.716V4h-.6v.719c-1.195.117-2.01.836-2.01 1.853 0 .9.606 1.472 1.613 1.707l.397.098v2.034c-.615-.093-1.022-.43-1.114-.9zm2.177-2.166c-.59-.137-.91-.416-.91-.836 0-.47.345-.822.915-.925v1.76h-.005zm.692 1.193c.717.166 1.048.435 1.048.91 0 .542-.412.914-1.135.982V8.518z"/>
                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                        <path d="M8 13.5a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11m0 .5A6 6 0 1 0 8 2a6 6 0 0 0 0 12"/>
                        </svg>`;
                    }
                } else if (savings >= 1000) {
                    for (let i = 0; i < Math.floor(savings / 1000); i++) {
                        coinContainer.innerHTML += `<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-coin" viewBox="0 0 16 16" style="margin: 5px;">
                        <path d="M5.5 9.511c.076.954.83 1.697 2.182 1.785V12h.6v-.709c1.4-.098 2.218-.846 2.218-1.932 0-.987-.626-1.496-1.745-1.76l-.473-.112V5.57c.6.068.982.396 1.074.85h1.052c-.076-.919-.864-1.638-2.126-1.716V4h-.6v.719c-1.195.117-2.01.836-2.01 1.853 0 .9.606 1.472 1.613 1.707l.397.098v2.034c-.615-.093-1.022-.43-1.114-.9zm2.177-2.166c-.59-.137-.91-.416-.91-.836 0-.47.345-.822.915-.925v1.76h-.005zm.692 1.193c.717.166 1.048.435 1.048.91 0 .542-.412.914-1.135.982V8.518z"/>
                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                        <path d="M8 13.5a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11m0 .5A6 6 0 1 0 8 2a6 6 0 0 0 0 12"/>
                        </svg>`;
                    }
                } else {
                    for (let i = 0; i < Math.floor(savings / 100); i++) {
                        coinContainer.innerHTML += `<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-coin" viewBox="0 0 16 16" style="margin: 5px;">
                        <path d="M5.5 9.511c.076.954.83 1.697 2.182 1.785V12h.6v-.709c1.4-.098 2.218-.846 2.218-1.932 0-.987-.626-1.496-1.745-1.76l-.473-.112V5.57c.6.068.982.396 1.074.85h1.052c-.076-.919-.864-1.638-2.126-1.716V4h-.6v.719c-1.195.117-2.01.836-2.01 1.853 0 .9.606 1.472 1.613 1.707l.397.098v2.034c-.615-.093-1.022-.43-1.114-.9zm2.177-2.166c-.59-.137-.91-.416-.91-.836 0-.47.345-.822.915-.925v1.76h-.005zm.692 1.193c.717.166 1.048.435 1.048.91 0 .542-.412.914-1.135.982V8.518z"/>
                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                        <path d="M8 13.5a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11m0 .5A6 6 0 1 0 8 2a6 6 0 0 0 0 12"/>
                        </svg>`;
                    }
                }
            });
        });
    }

    // 버튼 클릭 시 계산 수행
    calcButton.addEventListener('click', performCalculation);

    // 엔터 키 입력 시 계산 수행
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault(); // 엔터 키의 기본 동작 방지
            performCalculation();
        }
    });
});
