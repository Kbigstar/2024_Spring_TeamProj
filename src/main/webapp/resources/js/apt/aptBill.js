function fetchElectricityBill(elecUsage) {
	$.ajax({
		url : '/calculateBill', // 서버의 URL을 정확하게 입력
		type : 'POST',
		contentType : 'application/json',
		data : JSON.stringify({
			elecUseage : elecUsage
		}),
		success : function(response) {
			// 서버에서 응답 받은 데이터를 변수에 저장
			console.log("응답: ", response);

			// 응답 데이터가 배열로 반환됨
			if (response.length > 0
					&& response[0].totalBillAmount !== undefined) {
				var elecBill = response[0].totalBillAmount;

				// 숫자를 로케일에 맞게 형식화
				var formattedElecBill = elecBill.toLocaleString('ko-KR');

				// 페이지에 전기세 업데이트
				var elecBillElement = $('#userElecBill');
				if (elecBillElement.length > 0) {
					elecBillElement.text(formattedElecBill + ' 원');
				}
			} else {
				console.log("응답 데이터가 비어 있습니다.");
			}
		},
		error : function(err) {
			console.error("Error fetching electricity bill:", err);
		}
	});
}

function fetchAptElecUsage(apartComplexcode, elecUsage) {
    if (!apartComplexcode) {
        console.error("complexcode is null or undefined");
        return;
    }

    $.ajax({
        url: '/aptAvgElecUsage',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            apartComplexcode: apartComplexcode
        }),
        success: function(response) {
            console.log("AptElecUsage response: ", response);
            // 응답 데이터를 HTML에 삽입
            if (response) {
                $('#aptBuildingName').text(response.apartBuildingnm + ' 아파트');
                $('#aptElecUsage').text(response.elecUsage + ' kWh');
                $('#aptTotalBill').text(response.totalBillAmount.toLocaleString('ko-KR') + ' 원');
                
                // 전력 사용량 비교
                var percentageDifference = ((elecUsage - response.elecUsage) / response.elecUsage) * 100;
                var roundedDifference = Math.round(Math.abs(percentageDifference)); // 소수점 첫째 자리에서 반올림하고 정수형으로 변환
                var comparisonText = roundedDifference + '% ';
                comparisonText += (percentageDifference > 0) ? '높습니다.' : '낮습니다.';
                console.log(comparisonText);
                $('#comparisonText').html('<strong>' + comparisonText + '</strong>');

                
                // 차트에 데이터 업데이트
                updateChart(elecUsage, response.elecUsage);
            } else {
                console.log("응답 데이터가 비어 있습니다.");
            }
        },
        error: function(err) {
            console.error("Error fetching AptElecUsage: ", err);
        }
    });
}


function updateChart(userElecUsage, avgElecUsage) {
	
	var options = {
			series : [ {
				name : '내 전력량',
				data : [ userElecUsage ]
			}, {
				name : '아파트 평균',
				data : [ avgElecUsage ]
			} ],
			chart : {
				type : 'bar',
				height : 380,
				toolbar : {
					show : false
				// 차트 툴바 비활성화
				},
			},
			plotOptions : {
				bar : {
					horizontal : false,
					columnWidth : '55%',
					endingShape : 'rounded'
				},
			},
			dataLabels : {
				enabled : true, // 데이터 라벨 활성화
				position : 'top', // 데이터 라벨 위치를 막대 상단에 설정
				offsetY : 100, // 데이터 라벨의 y축 위치 조정 (막대 상단에서 약간 위로)
				style : {
					colors : [ '#304758' ], // 데이터 라벨의 색상 설정
					fontSize : '14px', // 데이터 라벨의 글꼴 크기 설정
					fontWeight : 'bold' // 데이터 라벨의 글꼴 두께 설정
				},
				formatter : function(val) { // 데이터 라벨 포맷터 함수
					return val + " kWh"; // 데이터 라벨에 단위 추가
				}
			},
			stroke : {
				show : true,
				width : 2,
				colors : [ 'transparent' ]
			},
			title : {
				text : '내 고지서 분석',
				align : 'center',
				margin : 0,
				style : {
					fontSize : '24px',
					fontWeight : 'normal',
					color : '#263238'
				}
			},
			xaxis : {
				categories : [ '5월' ]
			},
			fill : {
				opacity : 1
			},
			colors : [ '#48f8fe', '#92e88c' ], // "내 전력량"은 파란색, "아파트 평균"은
												// 녹색으로 설정
			tooltip : {
				y : {
					formatter : function(val) {
						return val + " kWh"
					}
				}
			}
		};

		// 차트 생성
		var chart = new ApexCharts(document.querySelector("#exampleChart"),
				options);
		chart.render();
}
$(document).ready(
		function() {
			// 전역 변수 elecUsage 값을 확인
			console.log("전력량: " + elecUsage);

			// AJAX 요청 함수 호출
			fetchElectricityBill(elecUsage);
			fetchAptElecUsage(apartComplexcode, elecUsage);

});
