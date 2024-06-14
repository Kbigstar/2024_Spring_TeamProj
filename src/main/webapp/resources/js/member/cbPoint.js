let targetValue;
let targetValue2;
let targetValue3;

$(document).ready(function(){
    function updateValues() {
        targetValue = $("#inputobj").val();
        
        // 입력 값 검증
        if (targetValue <= 0 || targetValue > 100) {
            alert("목표 절약량이 0보다 크고 100 이하여야 합니다.");
            return; // 유효하지 않은 경우 함수 종료
        }
        
        let percentage = targetValue / 100;

        if (targetValue >= 5 && targetValue <= 9) {
            targetValue2 = 5000;
        } else if (targetValue >= 10 && targetValue <= 14) {
            targetValue2 = 10000; 
        } else if (targetValue > 14) {
            targetValue2 = 15000; 
        } else {
            targetValue2 = '-'; // targetValue가 5 미만인 경우 값을 비움
        }
        
        // targetValue3 계산 및 반올림
        targetValue3 = Math.round(elecUsage - (elecUsage * (targetValue / 100)));

        $("#inputobj2").val(targetValue2);
        $("#elecobj").val(targetValue3); // targetValue3 출력
    }

    $("#cbbtn").click(function(){
        updateValues();
    });

    $("#inputobj").keyup(function(event){
        if (event.key === "Enter") {
            updateValues();
        }
    });
});
