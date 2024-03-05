<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>안양시 정보</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	//문서가 준비되면 실행
	$(document).ready(function() {
	    // 날씨 데이터 가져오기
	    getWeather();
	    // 흡연 구역 정보 가져오기
	    getSmokingZone();
	});
	
	// 날씨 정보를 가져오는 함수
	function getWeather() {
	    $.ajax({
	        type: 'GET',
	        url: 'http://127.0.0.1:5001/weather_api/weather',
	        dataType: 'json',
	        success: function(result) {
	            console.log(result); // 받은 데이터를 콘솔에 출력
	
	            // JSON.stringify()를 사용하여 JSON 객체를 문자열로 변환
	            //var jsonString = JSON.stringify(result);
	           
	            // 변환된 문자열을 HTML에 삽입
	            var hour = result[0];
	            var temp = result[1];
	            var wfKor = result[2];
	            $('#a').html("[안양시 동안구 날씨]<br>시간 :" + hour + "시<br>온도 :" + wfKor + "°C<br>날씨 :" + temp);
	
	            // 그래프 가져오기
	            getGraph();
	        },
	        error: function(xhr, status, error) {
	            alert(xhr + ':' + status + ':' + error);
	        }
	    });
	}
	
	// 그래프를 가져오는 함수
	function getGraph() {
	    var graphRequest = $.ajax({
	        type: 'GET',
	        url: 'http://127.0.0.1:5001/population_api/population', // 그래프 데이터를 가져오는 URL
	        dataType: 'json',
	        success: function(data) {
	            // 성공적으로 데이터를 받아왔을 때 실행할 코드
	            var image = data[0];
	            // 생성한 <img> 엘리먼트를 id가 'graph'인 엘리먼트에 추가
	            $('#graph-container').html("").append('<img src="data:image/png;base64,' + image + '">');
	        },
	        error: function(xhr, status, error) {
	            // 에러가 발생했을 때 실행할 코드
	            alert(xhr + ':' + status + ':' + error);
	        }
	    });
	}
	
	// 흡연 구역 정보를 가져오는 함수
	function getSmokingZone() {
	    $.ajax({
	        type: 'GET',
	        url: 'http://127.0.0.1:5001/smokingzone_api/smokingzone',
	        dataType: 'json',
	        success: function(result) {
	            console.log(result); // 받은 데이터를 콘솔에 출력
	            console.log(JSON.stringify(result));
	           
	            // result를 이용하여 필요한 처리를 수행합니다.
	            var smokingZoneHtml = '<h2>흡연 장소 정보</h2><ul>';
	
	            // result.data에 있는 흡연 구역 정보를 반복하여 HTML에 추가
	            for (var i = 0; i < result.data.length; i++) {
	                var item = result.data[i];
	                smokingZoneHtml += '<li>' + item['흡연구역명'] + ' - ' + item['소재지도로명주소'] + '</li>';
	            }
	
	            smokingZoneHtml += '</ul>';
	            $('#smoking-container').append(smokingZoneHtml);
	        },
	        error: function(xhr, status, error) {
	            alert(xhr + ':' + status + ':' + error);
	        }
	    });
	}
</script>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center; /* 화면 가운데 정렬을 위해 추가 */
            justify-content: flex-start;
            min-height: 100vh; /* 최소 높이를 화면 높이로 설정 */
            background-color: #F2F2F2;
        }
        .info-container {
            border: 2px solid #4CAF50;
            border-radius: 50%;
            padding: 20px;
            text-align: center;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px;
            align-self: flex-end; /* 오른쪽 상단에 위치하도록 추가 */
        }
        h1,h2 {
            font-size: 1.2em;
            margin-bottom: 10px;
            color: #4CAF50;
        }
        #container {
            display: flex;
            justify-content: space-between; /* 지도와 흡연장 정보를 컨테이너 양쪽에 배치 */
        }
        #smoking-container {
            width: 45%; /* 지도와 간격 조정을 위해 너비를 줄임 */
            padding: 20px;
            box-sizing: border-box;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        #map {
            width: 600px; /* 지도와 간격 조정을 위해 너비를 줄임 */
            height: 350px;
            padding: 20px;
            box-sizing: border-box;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
	<div>
		<%@ include file="mainAnyang.jsp" %>
	</div>
	<div class="info-container">
		<h1 id="a" class="a" th:text=${weatherData}></h1>
	</div>
<div>
	<div id="graph-container">
        <!-- 그래프를 표시할 공간 -->
    </div>
	<div id="container">
	
	 <div id="smoking-container">
        <!-- 흡연장 정보를 표시할 공간 -->
    </div>
	
    <div id="map"></div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8165064eb54e71f98379cef15f1af4d8"></script>
	<script>
	    // 지도를 표시할 div와 옵션 설정
	    var mapContainer = document.getElementById('map'),
	        mapOption = {
	            center: new kakao.maps.LatLng(37.391228, 126.953646), // 지도의 중심좌표
	            level: 6 // 지도의 확대 레벨
	        };
	
	    // 카카오맵을 생성
	    var map = new kakao.maps.Map(mapContainer, mapOption);
	
	    // 마커를 표시할 위치와 title 객체 배열
		var positions = [
	    {
	        title: '안양역 흡연부스',
	        latlng: new kakao.maps.LatLng(37.401276, 126.923019)
	    },
	    {
	        title: '평촌역 2번출구',
	        latlng: new kakao.maps.LatLng(37.394430, 126.963568)
	    },
	    {
	        title: '농수산물 도매시장',
	        latlng: new kakao.maps.LatLng(37.382482, 126.969702)
	    },
	    {
	        title: 'KT동안지사',
	        latlng: new kakao.maps.LatLng(37.393393, 126.954176)
	    },
	    {
	        title: '안양종합운동장',
	        latlng: new kakao.maps.LatLng(37.405292, 126.946511)
	    },
	    {
	        title: '범계역 2번출구',
	        latlng: new kakao.maps.LatLng(37.390195, 126.951846)
	    },
	    {
	        title: '범계역 8번출구',
	        latlng: new kakao.maps.LatLng(37.389821, 126.949683)
	    },
	    {
	        title: '금강스마트빌딩',
	        latlng: new kakao.maps.LatLng(37.396304, 126.964061)
	    }
	];
	   
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		   
		for (var i = 0; i < positions.length; i ++) {
		   
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35);
		   
		    // 마커 이미지를 생성합니다
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		   
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지
		    });
		}
</script>
</div>
</body>
</html>