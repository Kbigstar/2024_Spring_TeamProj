var options = {
    series: [{
        name: '전력량',
        type: 'column',
        data: []
    }, {
        name: '탄소 배출량',
        type: 'line',
        data: []
    }],
    chart: {
        height: 430,
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
        text: '아파트 비교 그래프',
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
        categories: ['내아파트', '비교 아파트'],
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
            color: 'white'
        }, tickAmount: 4
    }, {
        opposite: true,
        axisTicks: {
            show: true,
        },
        axisBorder: {
            show: true,
            color: 'white'
        },
        labels: {
            style: {
                colors: '#00E396',
            }
        }
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
    colors: ['#48f8fe', '#0b7e20']
};

var chart = new ApexCharts(document.querySelector("#chart"), options);
chart.render();

$(document).ready(function() {
    var guSelectBox = $('#gu');
    var dongSelectBox = $('#dong');
    var apartBox;
    var aptCode = $('#code').val();

    onechoicefunc();

    $(document).on("change", "#gu", function() {
        var selectedGu = $(this).val();
        twochoicefunc(selectedGu);
    });

    $(document).on("change", "#dong", function() {
        var selectedDong = $(this).val();
        threechoicefunc(selectedDong);
    });

    $(document).on("change", "#apart", function() {
        apartBox = $(this).val();
    });

    $("#comparebtn").click(function() {
        comparefunc(aptCode, apartBox);
    });
});
//첫번쨰 셀렉트 박스
function onechoicefunc() {
    $.ajax({
        url: '/onechoice',
        type: 'GET',
        contentType: 'application/json',
        success: function(data) {
            var guSelectBox = $('#gu');
            data.forEach(function(option) {
                guSelectBox.append($('<option>', {
                    value: option.apartDistrict,
                    text: option.apartDistrict
                }));
            });
            var districtName = data[0].apartDistrict;
            twochoicefunc(districtName);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ', status, error);
        }
    });
}
//두번쨰 셀렉트 박스
function twochoicefunc(districtName) {
    $.ajax({
        url: '/twochoice',
        type: 'GET',
        data: {
            apartDistrict: districtName
        },
        success: function(data) {
            var dongSelectBox = $('#dong');
            dongSelectBox.empty().append('<option value="">--선택하세요--</option>');
            $.each(data, function(idx, option) {
                dongSelectBox.append('<option value="' + option.apartNeighborhood + '">' + option.apartNeighborhood + '</option>');
            });
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ', status, error);
        }
    });
}
//세번쨰 셀렉트 박스
function threechoicefunc(neighborhoodName) {
    $.ajax({
        url: '/threechoice',
        type: 'GET',
        data: {
            apartNeighborhood: neighborhoodName
        },
        success: function(data) {
            var apartSelectBox = $('#apart');
            apartSelectBox.empty().append('<option value="">--선택하세요--</option>');
            $.each(data, function(idx, option) {
                apartSelectBox.append('<option value="' + option.apartComplexcode + '">' + option.apartBuildingnm + '</option>');
            });
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ', status, error);
        }
    });
}
//단지코드 가져와서 비교하기 버튼
function comparefunc(aptCode, apartBox) {
    var usageData = [];
    var carbonData = [];

    $.ajax({
        url: '/compareApt',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ apartComplexcode: aptCode }),
        success: function(data) {
            if (data && data.length > 0) {
                usageData[0] = data[0].elecUsage || 0;
                carbonData[0] = Math.round(usageData[0] * 0.5); // 탄소 배출량 계산 (예: 1 kWh당 0.5 kg CO2)
            } else {
                usageData[0] = 0;
                carbonData[0] = 0;
            }

            $.ajax({
                url: '/compareApt',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ apartComplexcode: apartBox }),
                success: function(data) {
                    if (data && data.length > 0) {
                        usageData[1] = data[0].elecUsage || 0;
                        carbonData[1] = Math.round(usageData[1] * 0.4781); // 탄소 배출량 계산 (예: 1 kWh당 0.4781 kg CO2)
                    } else {
                        usageData[1] = 0;
                        carbonData[1] = 0;
                    }

                    options.series[0].data = usageData;
                    options.series[1].data = carbonData;
                    chart.updateOptions(options);
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching data: ', status, error);
                }
            });
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ', status, error);
        }
    });
	}