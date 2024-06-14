function uploadImage() {
    var fileInput = document.getElementById('imgfile');
    var file = fileInput.files[0];

    // 파일 입력값이 없을 경우 경고 메시지 출력
    if (!file) {
        alert('파일을 넣고 버튼을 눌러주세요!!!!!!!!!');
        return; // 파일이 없으면 함수 종료
    }

    var formData = new FormData();
    formData.append('file', file);

    // 모달 로딩 화면 표시
    $('#modalLoading').show();

    // 이미지 업로드 AJAX 요청
    $.ajax({
        url: 'http://192.168.0.16:5000/billUpload',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            // 응답 결과 처리
            console.log(response);
            $('#message').text('File uploaded successfully');
            $('#processed_text').text(response.processed_text);
            $('#filtered_texts').text(response.filtered_texts);

            // 'k'를 제거하고 숫자 값만 추출
            var filteredTextsArray = response.filtered_texts.split('\n');
            var numberStr = filteredTextsArray.map(function(text) {
                return text.replace(/[kK]/, '');
            }).join('');

            var number = parseInt(numberStr, 10);

            // 서버로 전송하여 DB 업데이트
            updateDb(number, memId);

            // 모달 로딩 화면 숨기기
            $('#modalLoading').hide();
        },
        error: function(xhr, status, error) {
            // 모달 로딩 화면 숨기기
            $('#modalLoading').hide();
            console.log("Error: ", xhr.responseText);
            alert('고지서 이미지를 다시 확인해주세요..');
        }
    });
}

function updateDb(elecUsage, memId) {
    $.ajax({
        url: '/updateElecUsage',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            elecUsage: elecUsage,
            memId: memId
        }),
        success: function() {
            // 성공적으로 DB 업데이트 후 /aptBill로 이동
            window.location.href = '/aptBill';
        },
        error: function() {
            // 모달 로딩 화면 숨기기
            $('#modalLoading').hide();
            alert('DB 업데이트 실패');
        }
    });
}

// 내아파트 그래프 옵션
var options = {
    series: [{
        name: '전력량',
        type: 'column',
        data: []
    }, {
        name: '전기세',
        type: 'line',
        data: []
    }],
    chart: {
        height: 400,
        type: 'line',
        stacked: false,
        toolbar: {
            show: false
        },
        zoom: {
            enabled: false
        },
        brush: {
            enabled: false
        },
        selection: {
            enabled: false
        }
    },
    title: {
        text: apartBuildingnm +'의 평균 전력량',
        align: 'center',
        margin: 10,
        style: {
            fontSize: '16px',
            fontWeight: 'bold',
            color: '#263238'
        }
    },
    stroke: {
        width: [0, 4]
    },
    xaxis: {
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        labels: {
            style: {
                colors: 'black'
            }
        }
    },
    yaxis: [{
        axisTicks: {
            show: true,
        },
        axisBorder: {
            show: true,
            color: 'black'
        }, tickAmount: 4
    }, {
        opposite: true,
        axisTicks: {
            show: true,
        },
        axisBorder: {
            show: true,
            color: 'black'
        },
        labels: {
            style: {
                colors: '#00E396',
            }
        },
    }],
    tooltip: {
        enabled: false
    },
    legend: {
        show: true
    },
    dataLabels: {
        enabled: true,
        enabledOnSeries: [0, 1],
        style: {
            fontSize: '12px',
            colors: ['#59a576']
        },
        background: {
            enabled: true,
            foreColor: '#ffffff',
            padding: 4
        }
    },
    grid: {
        borderColor: '#000000'
    },
    colors: ['#d1e7dd', '#0b7e20']
};

var chart = new ApexCharts(document.querySelector("#myaptchart"), options);
chart.render();

var content;
const text = document.querySelector(".text");
let i = 0;

function typing() {
    if (i < content.length) {
        let txt = content.charAt(i);
        if (txt === '\n') {
            text.innerHTML += '<br>';
        } else {
            text.innerHTML += txt;
        }
        i++;
    }
}
setInterval(typing, 100);

$(document).ready(function() {
    requestForecast(apartComplexcode);
    $("#billbtn").click(function() {
        uploadImage();
    });
    $(document).on("change", "#yearSelect", function() {
        var year = $(this).val();
        myaptData(year, apartComplexcode, function(error, response) {
            if (error) {
                console.error(error);
            } else {
                updateChart(response);
            }
        });
    });
});

// 내아파트 전력량 가져오기
function myaptData(year, apartComplexcode, callback) {
    $.ajax({
        url: '/myapt',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            enerDt: year,
            apartComplexcode: apartComplexcode
        }),
        success: function(response) {
            callback(null, response);
            console.log(response);
        },
        error: function(error) {
            callback(error);
        }
    });
}

// 차트 업데이트
function updateChart(data) {
    var usageData = data.map(function(item) { return item.elecUsage; });
    var costData = data.map(function(item) { return item.totalBillAmount; });
//  var categories = data.map(function(item) { return item.enerDt + '월'; });
     // 전력량 데이터가 모두 0인 경우 알림 창 표시
    if (usageData.every(function(value) { return value === 0; })) {
        alert('해당 연도의 전력량이 없습니다.');
    }

    options.series[0].data = usageData;
    options.series[1].data = costData;
//  options.xaxis.categories = categories;

    chart.updateOptions(options);
}


// 아파트 다음 달 예측량
function requestForecast(complexcode) {
    if (!complexcode) {
        alert('Please enter a complex code');
        return;
    }

    $.ajax({
        url: 'http://192.168.0.16:5556/codeForecast',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ complexcode: complexcode }),
        success: function(response) {
            console.log("Response:", response);

            // 현재 날짜를 기준으로 다음 달의 첫 번째 날을 계산
            const now = new Date();
            const currentYear = now.getFullYear();
            const currentMonth = now.getMonth(); // getMonth()는 0부터 시작하므로 그대로 사용

            // 다음 달의 첫 번째 날로 설정
            let nextMonthYear = currentYear;
            let nextMonth = currentMonth + 1;
            if (nextMonth > 11) { // 만약 12월이면, 다음 달은 1월로 설정하고 연도를 증가시킴
                nextMonth = 0;
                nextMonthYear++;
            }
            const nextMonthKey = `${nextMonthYear}-${(nextMonth + 1).toString().padStart(2, '0')}-01`;

            console.log("Next Month Key:", nextMonthKey);

            // 다음 달 데이터를 찾기
            const nextMonthData = response.find(item => {
                console.log("Comparing:", item.date, "with", nextMonthKey);
                return item.date === nextMonthKey;
            });

            if (nextMonthData) {
                const forecast = nextMonthData.forecast;
                const totalBillAmountFormatted = nextMonthData.total_bill_amount.toLocaleString();
                content = `${forecast} kWh\n ${totalBillAmountFormatted}원`;
                // 결과를 원하는 곳에 표시
                console.log(content);
            } else {
                console.log("No data available for the next month.");
            }
        },
        error: function(xhr, status, error) {
            alert('An error occurred: ' + error);
        }
    });
}
