<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="org.apache.log4j.LogManager" %>

<%
    Logger logger = LogManager.getLogger("WeatherJSP");
    logger.info("WeatherJSP에서의 로그 메시지입니다.");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Show Weather</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <!-- Swiper CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    	
	<style type="text/css">
	
		body {background-color : aliceblue;}
		
		.swiper-container{
		top: 177px; 
		}
		
		.swiper-slide {
	    display: flex;
	    justify-content: center;
	    align-items: center;
		}
		
		.swiper-slide img {
	    width: 90%;
	    height: 100%;
	    object-fit: cover;
		}
		
		.a { text-align: right; }
    	
    	.weatherIcon a { text-decoration: none; color: inherit; }
    	
    	.weatherIcon { text-align: right; position: fixed; top: 0; right: 0; }
		
		.b {
		top: 200px;
    	position: absolute;
    	z-index: 1;
		}
		
		#b {
	    height: 100%; /* 이미지 컨테이너 전체 높이로 설정 */
		}
		

			
		.c {
		text-align: -webkit-center;
		}

        button {font-size: 25px;}
        
		#data {
		    text-align: center;
		    margin-top: 180px;
		    font-size: 30px;
		    background-color: #34495e; /* 배경 색상 변경 */
		    padding: 40px;
		}
		
		#data table {
		    margin: 0 auto;
		    color: #ecf0f1; /* 테이블 텍스트 색상 변경 */
		}
		
		.data-container {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    flex-wrap: wrap;
		    margin-top: 20px;
		}
		
		.data-item {
		    text-align: center;
		    margin: 5px 90px;
		    text-decoration: none;
		    color: #3498db; /* 링크 색상 변경 */
		    font-size: 24px;
		    font-weight: bold;
		    padding: 15px; /* 좀 더 패딩 추가 */
		    border: 2px solid #3498db; /* 테두리 색상 변경 */
		    border-radius: 8px;
		    transition: background-color 0.3s, color 0.3s;
		}
		.data-item:hover {
		    background-color: #7aa9ff;
		    color: #fff;
		}
		
		
    </style>
    
</head>
<body>
	<div>
		<%@ include file="mainIncheon.jsp" %>
	</div>
    <div>
        <table id="weatherIcon" class="weatherIcon">
            <tr>
                <td>
                    <a href="https://www.weather.go.kr/w/index.do#dong/2811058500/37.47405/126.63111/%EC%9D%B8%EC%B2%9C%EA%B4%91%EC%97%AD%EC%8B%9C%20%EC%A4%91%EA%B5%AC%20%EB%8F%99%EC%9D%B8%EC%B2%9C%EB%8F%99//">
                        <h3 id="a" class="a"></h3>
                    </a>
                </td>
            </tr>
        </table>
    </div>
    <div class="swiper-container">
        <div class="swiper-wrapper" id="b"></div>
        <!-- Swiper 페이징 추가 -->
        <div class="swiper-pagination"></div>
        <!-- Swiper 네비게이션 추가 -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>

	<div id="data">
	    <table>
	        <tr>
	            <td colspan=3>
	                <h2 id="c" class="c">주제별 데이터</h2>
	            </td>
	        </tr>
	        <tr>
	            <td>
	                <div class="data-container">
                    <div class="data-item">
                        <a href="incheon_parking">공영주차장 리스트</a>
                    </div>
                    <div class="data-item">
                        <a href="incheon_books">도서관/서점 리스트</a>
                    </div>
                    <div class="data-item">
                        <a href="incheon_bus">버스정류장 리스트</a>
                    </div>
                </div>
	            </td>
	        </tr>
	    </table>
	</div>
	
	<script type="text/javascript">
    
    	var swiper = null; // swiper 변수를 밖에서 선언하고 초기화
        
        $(document).ready(function() {
        	weathers();
        });
    	
        function weathers() {
            $.ajax({
                type: 'GET',
                url: 'http://127.0.0.1:5001/in1/weathers',
                dataType: 'json',
                success: function (result) {
                    var hour = result[0];
                    var temp = result[1];
                    var wfKor = result[2];
                    var pop = result[3];
                    var icon = result[4];
                	
                    // 아이콘이 설정되어 있다면 이미지 태그를 추가하고 스타일 조절
                    if (icon) {
                        htmlContent = "<img src='" + icon + "' alt='Weather Icon'>";
                    }

                    // 텍스트를 포함한 HTML 설정
                    htmlContent += "<br>[인천시 날씨]<br>온도: " + temp + "°C<br>날씨: " + wfKor + "<br>강수확률: " + pop + "%";

                    // HTML을 출력
                    $('#a').html(htmlContent);
                    //$('#a').html("[인천시 부평구 날씨]<br>시간: " + hour + "시<br>온도: " + temp + "°C<br>날씨: " + wfKor +"<br>강수확률: " + pop + "%");
                 	
                    // weathers() 함수 성공 후에 mans() 함수 호출
                    getAllImages();               
                },
                error: function (xhr, status, error) {
                    alert(xhr + ':' + status + ':' + error);
                }
            });
        }
       
        function getAllImages() {
            // 첫 번째 Ajax 요청 (mans 이미지)
            var mansRequest = $.ajax({
                type: 'GET',
                url: 'http://127.0.0.1:5001/in2/mans',
                dataType: 'json'
            });

            // 두 번째 Ajax 요청 (school 이미지)
            var schoolRequest = $.ajax({
                type: 'GET',
                url: 'http://127.0.0.1:5001/in3/school',
                dataType: 'json'
            });

            // 두 번째 Ajax 요청 (school 이미지)
            var carRequest = $.ajax({
                type: 'GET',
                url: 'http://127.0.0.1:5001/in4/car',
                dataType: 'json'
            });

            // 두 개의 Ajax 요청을 병렬로 처리
            $.when(mansRequest, schoolRequest,carRequest).done(function (mansResponse, schoolResponse,carResponse) {
                var mansImages = mansResponse[0];
                var schoolImages = schoolResponse[0];
                var carImages = carResponse[0];
                const chartContainer = $('#b'); // 변경된 ID

                // 이미 swiper가 초기화되어 있다면 다시 초기화하지 않음
                if (swiper === null) {
                    // Swiper 초기화
                    swiper = new Swiper('.swiper-container', {
                        slidesPerView: 1,
                        spaceBetween: 10,
                        loop: true, // 무한 루프 활성화
                        
                        navigation: {
                            nextEl: '.swiper-button-next',
                            prevEl: '.swiper-button-prev'
                        },
                        pagination: {
                            el: '.swiper-pagination',
                            clickable: true,
                        },
                    });
                }
             	// Swiper 업데이트 (페이징 등)
                swiper.update();
             	// 새로고침시 첫이미지 슬라이드로 이동
                swiper.slideTo(1);
                             	
                // Swiper에 'mans' 이미지 동적으로 추가
                mansImages.forEach(function (image) {
                    swiper.appendSlide('<div class="swiper-slide"><img src="data:image/png;base64,' + image + '"></div>');
                });

                // Swiper에 'school' 이미지 동적으로 추가
                schoolImages.forEach(function (image) {
                    swiper.appendSlide('<div class="swiper-slide"><img src="data:image/png;base64,' + image + '"></div>');
                });
                
             	// Swiper에 'car' 이미지 동적으로 추가
                carImages.forEach(function (image) {
                    swiper.appendSlide('<div class="swiper-slide"><img src="data:image/png;base64,' + image + '"></div>');
                });
             	// 주제별 데이터를 화면에 표시
                $('#data').show();
             	
            }).fail(function (xhr, status, error) {
                alert(xhr + ':' + status + ':' + error);
            });
        }
   	 </script>
   	 
</body>
</html>