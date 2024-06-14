<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		footer::before {
		    content: "";
		    display: block;
		    height: 1px;
		    margin-top: -17px;
		    margin-bottom: 20px;
		    background-color: #000000;
		    width: 100%;
		}
	
		footer {
		    border-top: 1px solid #000000; /* 검은색으로 변경 */
		    background-color: #b9dfc8;
		    padding: 1rem 0;
		    margin: 5rem 0;
		    margin-bottom: 0;
		}
		
		
		.footer-message{
		    font-weight: bold;
		    font-size:0.1rem;
		    color:#ffffff;
		    margin-bottom:0.3rem;
		    margin:0 0 0 0.6rem;
		}
		.footer-contact{
		    font-size:0.9rem;
		    color:#545e6f;
		    margin:0.6rem;
		}
		.footer-copyright{
		    font-size:0.9rem;
		    color:#545e6f;
		    margin:0.6rem;
		}
			
	</style>
</head>
<body>
	    <footer class="footer text-center border rounded ">
        <div class="container">
            <div class="row">
     <!-- Footer Location-->
     <div class="col-lg-4 mb-5 mb-lg-0">
        <h4 class="text-uppercase mb-4">미래융합 교육원</h4><hr>
        
        <p class="lead mb-0">
			<strong>찾아 오시는길</strong> 
			<br>
			<strong>대전광역시 서구 계룡로491번길 86</strong>
        </p>
    </div>
    <!-- Footer Social Icons-->
    <div class="col-lg-4 mb-5 mb-lg-0" >
        <h4 class="text-uppercase mb-4">Eco Planner</h4>

    </div>
    <!-- Footer About Text-->
    <div class="col-lg-4">
        <h4 class="text-uppercase mb-4">팀원</h4><hr>
        <p class="lead mb-0">
			<strong>권보성 김동우</strong>
			<br>
			<strong>김대영 김유정</strong>
        </p>
    </div>
</div>
</div>

</footer>
</body>
</html>