<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner</title>
    <script> 
    var memId = "${sessionScope.login.memId}"; 
    var apartBuildingnm = "${sessionScope.login.apartBuildingnm}";
    var apartComplexcode ="${sessionScope.login.apartComplexcode}";
    console.log("회원의 단지코드 : "  + apartComplexcode);
    console.log("회원의 아파트이름: "  + apartBuildingnm);
    </script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <link href="css/apt/apt.css" rel="stylesheet" />
    <style>
        /* 로딩 화면 스타일 */
        #loading {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            overflow: show;
            margin: auto;
            top: 0;
            left: 0;
            background: rgba(255, 255, 255, 0.7);
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        #loading .spinner-border {
            width: 3rem;
            height: 3rem;
        }
    </style>
   
</head>

<body>
    <!-- nav 영역 -->
    <jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>
    
    <div class="container-fluid p-0">
        <div class="container mt-5">
            <div class="row">
   
                <div class="col-md-7 mb-4">
                    <div class="p-4 bg-light border rounded shadow-sm" style="height: 500px;">
                        <select class="form-select" aria-label="Default select example" id="yearSelect">
                            <option selected value="2023">선택년도</option>
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                            <option value="2020">2020</option>
                            <option value="2019">2019</option>
                            <option value="2018">2018</option>
                        </select>
                        <div id="myaptchart" style="flex: 1; display: flex; flex-direction: column; justify-content: center; margin-bottom: 1px;"></div>
                        <div class="text-lg-end text-center"></div>
                    </div>
                </div>
                <div class="col-md-5 mb-4">
                    <div class="p-5 bg-light border rounded shadow-sm" style="height: 500px;">
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                            내 고지서 입력하기
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="staticBackdropLabel">고지서 입력창</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- 로딩 화면 -->
                                        <div id="modalLoading" style="display:none; text-align: center;">
                                            <div class="spinner-border text-primary" role="status">
                                                <span class="visually-hidden">Loading...</span>
                                            </div>
                                            <span>이미지 업로드 및 인식 중입니다...</span>
                                        </div>
                                        <form id="uploadForm" enctype="multipart/form-data">
                                            <input type="file" accept="image/jpeg,.txt" id="imgfile" name="file"/>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
                                        <button type="button" class="btn btn-primary" onclick="uploadImage()">입력하기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="p-4 border border-success rounded-5 shadow-lg p-3 mb-5 bg-body-tertiary" style="height: 300px; margin-top: 50px;">
                            <div class="apt_text fw-bold d-flex align-items-center justify-content-center">
                                <img src="resources/assets/img/ee.png" class="rounded float-start elect" style="height: 50px; margin-right: 10px;">
                                <span style="font-size: 25px">다음달 세대별 예측 전력량</span>
                            </div>
                            <div class="text_box" data-trigger>
                                <span class="text"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- footer 영역 -->
    <jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="js/apt/apt.js"></script>
    <script>
    $(document).ready(function() {
        const defaultYear = 2023;
        requestForecast(apartComplexcode);
        myaptData(defaultYear, apartComplexcode, function(error, response) {
            if (error) {
                console.error(error);
            } else {
                updateChart(response);
            }
        });
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

        // 전력량 데이터가 모두 0인 경우 알림 창 표시
        if (usageData.every(function(value) { return value === 0; })) {
            alert('해당 연도의 전력량이 없습니다.');
        }

        options.series[0].data = usageData;
        options.series[1].data = costData;

        chart.updateOptions(options);
    }
    </script>
</body>

</html>
