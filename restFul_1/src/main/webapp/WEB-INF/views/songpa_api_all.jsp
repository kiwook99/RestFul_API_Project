<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 폰트 어썸 CDN -->
<script src="https://kit.fontawesome.com/2211a5118a.js" crossorigin="anonymous"></script>
<style type="text/css">

	body{
		background-color: rgb(230, 255, 242);
	}

	/* 스와이프 */
	 .swiper-container {
		height:620px;
		width: 100%;
	}
	
	.swiper-slide {
		text-align:center;
/* 		display:flex; /* 내용을 중앙정렬 하기위해 flex 사용 */ */
		align-items:center; /* 위아래 기준 중앙정렬 */
		justify-content:center; /* 좌우 기준 중앙정렬 */
	}
	
	.swiper-slide img {
		max-width:80%; /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
	}
	
	#pmAll a{
	  text-decoration-line: none;
	
	}
	
	#pmAll a:link {
		color: black;
		text-decoration: none;
	}
	

	#pmAll a:visited {
		color: black;
		text-decoration: none;
	}

	#pmAll a:hover {
		color: black;
		text-decoration: none;
	}	

	h1 {
		text-align: center;
	}
	
	h2 {
		text-align: center;
	}
	
	h3 {
		text-align: center;
	}
	
	table{
	
    	margin:auto; 
	}
	
	img {
		margin:auto;
		display: block;
	}
	
	.service a:link {
		color: black;
		text-decoration: none;
	}
	

	.service a:visited {
		color: black;
		text-decoration: none;
	}

	.service a:hover {
		color: black;
		text-decoration: none;
	}


.socials{
    margin: 16px 0 48px 0;
}


.socials a{
    text-decoration: none;
    color: black;
    border: 1.1px solid black;
    padding: 5px;
    border-radius: 50%;
}

.socials a i{
    font-size: 17.6px;
    width: 20px;
    transition: color .4s ease;
}

.socials a:hover i{
    color: aqua;
}




.footer-content{
    display: flex;	/*내부에서만 작동*/
    align-items: center; /*세로축 정렬*/
    justify-content: center;	/*가로축 정렬*/
    flex-direction: column; /*방향 지정*/
    text-align: center;
}

	
.footer-content h3{
    font-size: 33.6px;
    font-weight: 500;	/* 숫자가 올라갈수록 두꺼워짐*/
    text-transform: capitalize; /*첫글자를 대문자로*/
    line-height: 48px;
    color: black;
}	


</style>
</head>
<body>
	<div>
		<%@ include file="mainSongpa.jsp" %>
	</div>
	<div>
		
				<form>
					<table align="right">
								<tr>
								<td rowspan="2">
								<h1>송파구 정보 모음</h1>
								</td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								
								
									<td rowspan="2">
									<h1 id ="a"></h1>
									</td>
									<td>
									<p id="t" style="font-size: 20px; font-weight: bold;"></p>
									</td>
									<td>
									<p id="w"></p>
									</td>
								</tr>
								 <tr>	
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>	
								<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
														 			 		
									<td colspan="2">
									<p id="pmAll"></p>
									</td>								

								</tr>
					</table>
				</form>	
	</div>
	
	   
	   <div class="swiper-container">
		<hr>
		<h2> 송파구 각종 차트</h2>
		<hr>
		<br>	
       <div class="swiper-wrapper" id="chart"></div>	
       <!-- Swiper 페이징 추가 -->
       <div class="swiper-pagination"></div>
       		
       <!-- Swiper 네비게이션 추가 -->
       <div class="swiper-button-next"></div>
       <div class="swiper-button-prev"></div>

  	   </div> 

		
		
	<div>

		<div>
		<hr>
		<h2> 주요 서비스</h2>
		<hr>
		<br>
		<table>
			<tr>
				<td><a href="songpa_parking"><img src="./resources/img/songpa_car.png" width="100" height="100" alt="image"></a></td>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a href="songpa_news"><img src="./resources/img/songpa_news.png" width="100" height="100" alt="image"></a></td>
			</tr>
			<tr>
				<td><p class="service"><a href="songpa_parking" style="font-size: 20px;"> 송파구 불법주정차 CCTV위치  </a></p></td>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><p class="service"><a href="songpa_news" style="font-size: 20px;"> 서울시 보도자료 </a></p></td>
			</tr>
		</table>
		<hr>
		</div>
	 
	 
	 <form>
	 <!-- <a href="parking"> 서울시송파구불법주정차위반단속CCTV위치정보  </a>  -->
	 <!-- <a href="news"> 서울시 보도자료 </a>  --> 
	<h2>서울시 실시간 돌발 정보</h2>
	<hr>
		<br>
		
    		<table border="1" id="occurList">
    			<thead>
					<tr>
						<th> 발생 일자 </th>
						<th> 발생 시각 </th>
						<th> 돌발 내용 </th>
						<th> 종료 예정 일자 </th>
						<th> 종료 예정 시각 </th>					
					</tr>		    		
				</thead>
				<tbody>

				</tbody>
    		</table>	
		</form>
		<br><br><br><br><br>
		<!-- 
		<form>
    		<table border="1" id="newsList">
    			<thead>
    				<tr>
						<th colspan="3"> 서울시 보도자료 </th>
					</tr>
					<tr>
						<th> 등록일 </th>
						<th> 제목 </th>
						<th> 내용 </th>				
					</tr>		    		
				</thead>
				<tbody>

				</tbody>
    		</table>	
		</form>
		-->
	</div>	
<!-- 송파구 불법주정차 cctv api 인증키 :  	70726b596a70617234324a684e444c -->
<!-- http://openapi.seoul.go.kr:8088/70726b596a70617234324a684e444c/xml/TbOpendataFixedcctvSP/1/148/ -->
	



<!-- Swiper CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>    
<!-- <script  src="http://code.jquery.com/jquery-latest.min.js"></script>  --> 
<script type="text/javascript">
$(document).ready(function(){
	test();

});


	// flask_rss.html
	function test(){
	    var text_data = $('#item_id').val();
	        
	    $.ajax({
            type : 'GET',                                  <!--GET / POST-->
            url : "http://127.0.0.1:5001/api_weather/weather", 
            data : {
                    item_id:text_data                       <!--key : "value"-->
            }, 
            dataType : 'JSON',
            async    : false,
            success : function(weather){
                    //alert("weather = "+ weather);                    
                    
                 // ① 맑음, ② 구름 많음, ③ 흐림, ④ 비, ⑤ 비/눈
                    // ⑥ 눈, ⑦ 소나기, ⑧ 빗방울, ⑨ 빗방울/눈날림, ⑩ 눈날림
                         
                    var img= "";
                       for (var i = 0; i < weather.length; i++) {
                           var wkfor = weather[i].wkfor;
                           console.log(wkfor);
                         
                         if(wkfor == "맑음"){
                            img="https://www.weather.go.kr/home/images/icon/NW/NB01.png";
                         } else if(wkfor == "구름 많음") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB03.png";
                         }else if(wkfor == "흐림") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB04.png";
                         }else if(wkfor == "비") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB08.png";
                         }else if(wkfor == "비/눈") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB12.png";
                        }else if(wkfor == "눈") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB11.png"; 
                        }else if(wkfor == "소나기") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB07.png";
                        }else if(wkfor == "빗방울") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB20.png";
                       }else if(wkfor == "빗방울/눈날림") {s
                            img="https://www.weather.go.kr/home/images/icon/NW/NB22.png";
                       }else if(wkfor == "눈날림") {
                            img="https://www.weather.go.kr/home/images/icon/NW/NB11.png";
                       }
                       
                         // 결과를 표시할 HTML 문자열
                         var imgSrc = '<a href="https://www.weather.go.kr/w/index.do#dong/1171051000/37.535248/127.124245/%EC%84%9C%EC%9A%B8%ED%8A%B9%EB%B3%84%EC%8B%9C%20%EC%86%A1%ED%8C%8C%EA%B5%AC%20%ED%92%8D%EB%82%A91%EB%8F%99/SEL/%ED%92%8D%EB%82%A91%EB%8F%99">' + 
                         			  '<img src=' + img + '>' + '</a>';
                         
                         var temps = "온도: " + weather[i].temp + "°C";
                         var wkfors =  "&nbsp; 날씨: " + weather[i].wkfor;
                         
                         // var resultHtml = imgSrc + result
                         
                         // "시간: ", hour[i].text, "<br>온도: ", temp[i].text, "<br> 날씨: ", wkfor[i].text
                      
                         $('#a').html(imgSrc); // html 함수를 사용시, 새로운 내용으로 기존 내용이 완전히 대체됨
                         $('#t').html(temps);
                         $('#w').html(wkfors);

                    console.log(location.origin);                     
                    
                    // 미세먼지 함수 실행
                    air();
                                        
                       }                        
            },
            error : function(xtr,status,error){
                    alert(xtr +":"+status+":"+error);
                    console.log(location.origin);                     
            }
    });
}
	// flask_api_air.html
	function air(){
	    var text_data = $('#item_id').val();
	    
	    
	    $.ajax({
            type : 'GET',                                  <!--GET / POST-->
            url : "http://127.0.0.1:5001/api_air/air", 
            data : {
                    item_id:text_data                       <!--key : "value"-->
            },
            dataType : 'JSON',
            async    : false,
            success : function(result_air_quality){
                    //alert("result_air_quality = "+ result_air_quality);
                                        
					for(var i = 0; i < result_air_quality.length; i++){
						
						var PM10 = result_air_quality[i].pm10;
						var PM25 = result_air_quality[i].pm25;
												
						console.log(PM10);
						console.log(PM25);
						
					// 미세먼지 비교
						var PM10_1 = "";
	                    if(PM10 < 31){
 	                    	PM10_1 = "좋음";
	                    } else if(PM10 < 81) {
	                    	PM10_1 = "보통";
	                    }else if(PM10 < 151) {
	                    	PM10_1 = "나쁨";
	                    }else if(PM10 > 151) {
	                    	PM10_1 = "매우 나쁨";
	                    } else {
	                    	PM10_1 = "점검중";
                   		}

	                 // 초미세먼지 비교
	                    var PM25_1 = "";                     
	                    if(PM25 < 16){
	                    	PM25_1 = "좋음";
	                    } else if(PM25 < 36) {
	                    	PM25_1 = "보통";
	                    }else if(PM25 < 76) {
	                    	PM25_1 = "나쁨";
	                    }else if(PM25 > 76) {
	                    	PM25_1 = "매우 나쁨";
	                    } else {
	                    	PM25_1 = "점검중";
	                    }	                    
	                    
                    // 결과를 표시할 HTML 문자열
                    // https://cleanair.seoul.go.kr/main.htm?area=111273&type=pm25
	              	//var PM10_a = '<a href="https://cleanair.seoul.go.kr/main.htm?area=111273&type=pm25">' + "미세먼지: (" + PM10_1 + ")" + '</a>';
                    
                    //var PM25_a = "초미세먼지: (" + PM25_1 + ")";
                    
                    var pmAll = '<a href="https://cleanair.seoul.go.kr/main.htm?area=111273&type=pm25">' + "미세먼지: (" + PM10_1 + ")  " + "초미세먼지: (" + PM25_1 + ")" + '</a>';

                 
                    //$('#pm10').html(PM10_a); // html 함수를 사용시, 새로운 내용으로 기존 내용이 완전히 대체됨
                    //$('#pm25').html(PM25_a); // html 함수를 사용시, 새로운 내용으로 기존 내용이 완전히 대체됨
                    
                    $('#pmAll').html(pmAll);
                  
                    console.log(location.origin);                    

                    // 서울 실시간 돌발 상황 함수 실행
                    occur();
                    
                    // 차트 함수 실행
                    chart();
					}                                                                                       
            },
            error : function(xtr,status,error){
                    alert(xtr +":"+status+":"+error);
                    console.log(location.origin);                    
            }
    });
}	
	
	//스와이프 객체 선언
	var swiper = null; // swiper 변수를 밖에서 선언하고 초기화
// 여기부터 flask 수정하고 
    function chart() {
        // 첫 번째 Ajax 요청 (인구수 이미지)
        var populationReq = $.ajax({
            type: 'GET',
            url: 'http://127.0.0.1:5001/api_population/population',
            async    : false,
            dataType: 'json'
        });
        
        // 두 번째 Ajax 요청 (학교수 이미지)
        var schoolReq = $.ajax({
            type: 'GET',
            url: 'http://127.0.0.1:5001/api_school/school',
            dataType: 'json'
        });
        

        // 두 개의 Ajax 요청을 병렬 처리
        // when 함수는 해당 조건이 성공적으로 실행되었을 시, done()에 설정된 자바스크립트가 실행됨, ajax도 가능
        // done: 성공했을때만 실행, then: 성공과 실패 모두 사용
        $.when(populationReq, schoolReq).done(function (populationRes, schoolRes) {
        	
            var populationImages = populationRes[0];
            var schoolImages = schoolRes[0];

            const chartContainer = $('#chart'); // 변경된 ID
            
            // 이미 swiper가 초기화되어 있다면 다시 초기화하지 않음
            // === : 값과 변수의 유형까지 확인함
            if (swiper === null) {
                // Swiper 초기화
                swiper = new Swiper('.swiper-container', {
                    slidesPerView: 1, // 동시에 보여줄 슬라이드 갯수
                    spaceBetween: 10, // 슬라이드간 간격
                    loop: true, // 무한 반복 여부
                    
                    navigation: { // 네비게이션
                        nextEl: '.swiper-button-next', // 다음 버튼
                        prevEl: '.swiper-button-prev' // 이전 버튼
                    },
                    pagination: { // 페이징
                        el: '.swiper-pagination',
                        clickable: true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
                    },
                });
            }
         	// Swiper 업데이트 (페이징 등)
            swiper.update();
         	// 새로고침시 첫이미지 슬라이드로 이동
            swiper.slideTo(1);
                         	
            // Swiper에 'mans' 이미지 동적 추가
            // forEach : 배열 순회, appendSlide: 슬라이드 추가
            populationImages.forEach(function (image) {
                swiper.appendSlide('<div class="swiper-slide"><img src="data:image/png;base64,' + image + '"></div>');
            });
            // Swiper에 'school' 이미지 동적 추가
            schoolImages.forEach(function (image) {
                swiper.appendSlide('<div class="swiper-slide"><img src="data:image/png;base64,' + image + '"></div>');
            });

            //$('#data').show();
        }).fail(function (xhr, status, error) {
            alert(xhr + ':' + status + ':' + error);
        });
    }
	
	
    // flask_api_occur.html
    function occur(){
        
    	console.log("occur >>> : ");
        $.ajax({
            type : 'GET',                                  <!--GET / POST-->
       		url : "http://127.0.0.1:5001/api_occur/occur",  
            dataType : 'JSON',
            success : function(occur_list){
            	console.log("occur_list = " + occur_list);

            	var occurList = $('#occurList');
            	
            	
        	        $.each(occur_list, function(index, row) {
    	            	var rowHtml = '<tr>' +
    	            				  '<td width="150px">' + row.occr_date.substr(0,4) + '년 ' + row.occr_date.substr(4,2) + '월 ' + row.occr_date.substr(6,2) + '일' + '</td>' +
    	            				  '<td width="150px">' + row.occr_time.substr(0,2) + '시 ' + row.occr_time.substr(2,2) + '분' + '</td>' + 
    	            				  '<td>' + row.acc_info + '</td>' +
    	            				  '<td width="150px">' + row.exp_clr_date.substr(0,4) + '년 ' + row.exp_clr_date.substr(4,2) + '월 ' + row.exp_clr_date.substr(6,2) + '일' + '</td>' +    	            				  
    	            				  '<td width="150px">' + row.exp_clr_time.substr(0,2) + '시 ' + row.exp_clr_time.substr(2,2) + '분 ' + '</td>' +
    	            				  '</tr>';
         				  occurList.append(rowHtml);
         				  
                          console.log(location.origin);                    


                	});
                    // 보도자료 함수 실행
                    //news();
                    
    				},                                                                                       
            error : function(xtr,status,error){
                    alert(xtr +":"+status+":"+error);
                    console.log(location.origin);                    
            }	
    	});
    }
	
</script>



	<hr>
	<div class="footer-content">
			<table class="socials">
				<tr>
					<td colspan="7"><h3>kiwook</h3></td>
				</tr>
				<tr>
					<td><a href="songpa_instagram"><i class="fa-brands fa-instagram"></i></a></td>
					<td>&nbsp;&nbsp;</td>
					<td><a href="songpa_slack"><i class="fa-brands fa-slack"></i></a></td>
					<td>&nbsp;&nbsp;</td>
					<td><a href="songpa_notion"><i class="fa-solid fa-n"></i></a></td>
					<td>&nbsp;&nbsp;</td>
					<td><a href="songpa_github"><i class="fa-brands fa-github"></i></a></td>
				</tr>
			</table>
	</div>	


</body>
</html>