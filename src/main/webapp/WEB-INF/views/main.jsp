<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoPlanner</title>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=71bc3bb7345e0888cdcfc18cd68a2f38&libraries=services"></script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <link href="css/main.css" rel="stylesheet" />
</head>
<c:if test="${not empty msg}">
	        <script>
	 			alert("${msg}");       
	        </script>
        </c:if>
<body>
	<!-- nav 영역 -->
	<jsp:include page="/WEB-INF/inc/nav.jsp"></jsp:include>

    <div class="container-fluid p-0">
        
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="p-4 bg-light border rounded shadow-sm" style="height: 350px; ">
                        
                        <div id="map" style="color: black; z-index: 999; "></div>

                    </div>
                </div>
                <div class="col-md-8 mb-4">
                    <div class="p-4 bg-light border rounded shadow-sm" style="height: 350px; display: flex; margin-left: -10px;">
                    
                        <div id="treemap" style="flex: 2;"></div>
                        <div id="chart" style="flex: 1; display: flex; flex-direction: column; justify-content: center;">
                        </div>
                    </div>
                </div>




            <div class="row">
                <div class="col-12">
                    <div class="p-4 bg-light border rounded shadow-sm" style="height: 350px; width: 1295px;">
                        <div id="apexchart"></div>
			

                    </div>
                </div>
            </div>
        </div>
    </div>
	

	
</div>
	<!-- footer 영역 -->
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="js/main.js"></script>
</body>
</html>
