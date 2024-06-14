<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<script>
var elecUsage ="${sessionScope.login.elecUsage}";
console.log("회원의 사용전력량 : "  + elecUsage);
</script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js">
	
	</script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <link href="css/member/cbPoint.css" rel="stylesheet" />
   <!--  <style>
    
    	.label{
    		z-index : -10;
    	}
    </style> -->
</head>
<style>

</style>

<body>
    <!-- nav 영역 -->
    <jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

    <div class="container-fluid p-0">
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="p-4 bg-light border rounded shadow-sm" style="height: 95%;">
                        <div class="text-lg-end text-center">
                            <div class="fs-1 fw-bold d-flex align-items-center justify-content-center" style="margin-top: -25px;">carbon point</div>
                            <div class="mb-3 row">
                                <label for="inputobj" class="col-sm-5 col-form-label">목표 절약량</label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" id="inputobj">
                                </div>
                                <span class="col-sm-1">%</span>
                            </div>
                            <div class="mb-3 row">
                                <label for="inputobj" class="col-sm-5 col-form-label">전력량</label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" id="elecobj" value="${sessionScope.login.elecUsage}">
                                </div>
                                <span class="col-sm-1">kwh</span>
                            </div>
                            <div class="mb-3 row">
                                <label for="inputobj" class="col-sm-5 col-form-label">예상 탄소 포인트</label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" id="inputobj2">
                                </div>
                                <span class="col-sm-1">p</span>
                            </div>
                            <button type="button" class="btn btn-success btn-lg calc-button" id="cbbtn">포인트 계산하기</button>
                        </div>
                        <table class="table table-bordered" style="margin-top: 3%;">
                            <thead>
                                <tr>
                                    <th scope="col">감축률</th>
                                    <th scope="col">전기</th>
                                    <th scope="col">상수도</th>
                                    <th scope="col">도시가스</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">5%~9%</th>
                                    <td>5000p</td>
                                    <td>750p</td>
                                    <td>3000p</td>
                                </tr>
                                <tr>
                                    <th scope="row">10%~14%</th>
                                    <td>10000p</td>
                                    <td>1500p</td>
                                    <td>6000p</td>
                                </tr>
                                <tr>
                                    <th scope="row">15% 이상</th>
                                    <td>15000p</td>
                                    <td>2000p</td>
                                    <td>8000p</td>
                                </tr>
                            </tbody>
                        </table>
                        <p class="small-txt">※ 감축률 5% 이상인 참여자에게 지급 </p>
                    </div>
                </div>
                <div class="col-md-8 mb-4">
                    <div class="p-5 bg-light border rounded shadow-sm" style="height: 95%;">
                        <div class="p-4 border border-success rounded-5 shadow-lg p-3 mb-5 bg-body-tertiary" style="height: 100%; width:105%; margin-left:-2%">
                            <div class="text1 fw-bold">인센티브 종류</div>
                            <div class="incentive-type row row-cols-2 row-cols-sm-3 row-cols-md-4 g-2 mt-3">
                                <div class="col">
                                    <div class="item">
                                        <img src="resources/assets/img/me12_bl70_01.png" alt="현금" title="현금">
                                        <p class="bold">현금</p>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="item">
                                        <img src="resources/assets/img/me12_bl70_02.png" alt="상품권" title="상품권">
                                        <p class="bold">상품권</p>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="item">
                                        <img src="resources/assets/img/me12_bl70_03.png" alt="종량제 봉투" title="종량제 봉투">
                                        <p class="bold">종량제 봉투</p>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="item">
                                        <img src="resources/assets/img/me12_bl70_04.png" alt="지방세 납부" title="지방세 납부">
                                        <p class="bold">지방세 납부</p>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="item">
                                        <img src="resources/assets/img/me12_bl70_05.png" alt="기부" title="기부">
                                        <p class="bold">기부</p>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="item">
                                        <img src="resources/assets/img/me12_bl70_06.png" alt="교통카드" title="교통카드">
                                        <p class="bold">교통카드</p>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="item">
                                        <img src="resources/assets/img/me12_bl70_07.png" alt="상장" title="상장">
                                        <p class="bold">상장</p>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="item" style="width: 100%">
                                        <img src="resources/assets/img/me12_bl70_08.png" alt="공공시설이용 바우처" title="공공시설이용 바우처">
                                        <p class="bold">공공시설      <br>이용 바우처</p>
                                    </div>
                                </div>
                            </div>
                            <p class="small-txt" style="margin-top: 10%;">※ 해당 지방자치단체에서 시행하는 인센티브 제공 유형을 확인한 후 한가지만 선택 가능
                                <br> ※ 지자체 예산 사정에 따라 1Point 당 최대 2원 이내로 지급.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="contents-wrap" id="content-top">
                <!-- 내용 -->
                <!-- 저탄소생활 실천방법 탭  end -->
                <!-- 가정에서  begin -->
                <div class="bg-box">
                    <p>녹색습관</p>
                    <p><span>집에서부터</span> 시작하세요!!</p>
                </div>
                <div class="wisdom-list">
                    <ul>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no1.png" alt="첫째" title="첫째">
                                <span style="color: green;">여름엔 26℃ 이상, 겨울엔 20℃ 이하로 유지하기.</span>
                            </h3>
                            <p>냉난방 온도를 1℃ 조정할 경우 연간 110kg CO₂를 줄일 수 있으며, <span>냉난방 비용을 34,000원 </span>줄일 수 있습니다.</p>
                            <p>계절에 맞는 적정 실내 온도를 유지합니다.</p>
                        </li>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no2.png" alt="둘째" title="둘째">
                                <span style="color: green;">절전형 전등으로 교체하기.</span>
                            </h3>
                            <p>백열등(60W)을 형광등(24W)으로 교체 시 연간 17kg의 CO₂를 줄일 수 있습니다.</p>
                            <p>절전형 형광등은 백열등과 비교해 <span style="color: red;">수명이 약 8배 길며,</span> 전력소비가 적습니다.</p>
                        </li>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no3.png" alt="셋째" title="셋째">
                                <span style="color: green;">가전제품 플러그를 뽑아 두기.</span>
                            </h3>
                            <p>대기전력은 에너지 사용 기기 전체 이용 전력의 약 10%를 차지합니다.</p>
                            <p>멀티탭은 잘 보이는 곳에 두어 손쉽게 대기전력을 차단할 수 있도록 합니다.</p>
                        </li>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no4.png" alt="넷째" title="넷째">
                                <span style="color: green;">걷기&nbsp;&gt;&nbsp;자전거 타기&nbsp;&gt;&nbsp;대중교통 이용을 생활화하기.</span>
                            </h3>
                            <p>승용차 이용을 <span style="color: red;">일주일에 하루만 줄여도 </span>연간 445kg의 CO₂를 줄일 수 있습니다.</p>
                        </li>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no5.png" alt="다섯째" title="다섯째">
                                <span style="color: green;">장바구니를 애용하기.</span>
                            </h3>
                            <p><span style="color: red;">1회용 비닐봉지</span>(연간 160억개)가 분해되는 데<span style="color: red;">100년 이상 </span>걸립니다.</p>
                            <p>가정 쓰레기를 철저히 분리만 하여도 연간 188kg의 CO₂를 줄일 수 있습니다.</p>
                        </li>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no6.png" alt="여섯째" title="여섯째">
                                <span style="color: green;">친환경 상품을 구매하기.</span>
                            </h3>
                            <p>친환경 상품 사용으로 가구당 연간 350kg의 CO₂를 줄일 수 있습니다.</p>
                            <p>환경마크 제품, 에너지 효율이 높은 제품을 구매합니다.</p>
                        </li>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no7.png" alt="일곱째" title="일곱째">
                                <span style="color: green;">샤워 시간은 줄이고, 빨래는 모아서 하기.</span>
                            </h3>
                            <p><span style="color: red;">샤워 시간을 1분 줄이면 </span>가구당 연간 4.3kg의 CO₂를 줄일 수 있습니다.</p>
                            <p><span style="color: red;">빨래를 모아서</span> 하면 가구당 연간 14kg의 CO₂를 줄일 수 있습니다.</p>
                            <p><span style="color: red;">설거지통을 이용</span>(10분)하면 약 80리터의 물을 절약할 수 있습니다.</p>
                        </li>
                        <li>
                            <h3 class="wis-tit">
                                <img src="resources/assets/img/img_gr_no8.png" alt="여덟째" title="여덟째">
                                <span style="color: green;">음식은 적다고 느낄 만큼만 조리하기.</span>
                            </h3>
                            <p>연간 버려지는 음식물 쓰레기를 <span style="color: red;">돈으로 환산하면 15조원</span>이 넘습니다.</p>
                            <p>몸에도 좋고 온실가스도 덜 발생시키는 제철 식료품, 지역 농산물을 먹습니다.</p>
                        </li>
                    </ul>
                </div>

                <div class="bottom-img"><img src="resources/assets/img/me22_bg_bottom.png" alt="저탄소생활 실천방법" title="저탄소생활 실천방법"></div>
                <!-- 가정에서 end -->
            </div>
        </div>
    </div>

    <!-- footer 영역 -->
    <jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
    <script src="/js/member/cbPoint.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- 부트스트랩 JS 추가 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>