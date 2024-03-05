<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
      

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	    <style>
			body{
				background-color: rgb(230, 255, 242);
			}
		    	
    		a {
    			text-align: center;
    		}
    		
    		 p {
    			text-align: center;
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
 
   			h1 {
				text-align: center;
			}
			p {
				text-align: right;

			}
			#button {
				margin: auto;

			}
		</style>
<!-- 폰트 어썸 CDN -->
<script src="https://kit.fontawesome.com/2211a5118a.js" crossorigin="anonymous"></script>		
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>    
<script type="text/javascript">


var currentPage = 1;

function parking(){
    
	console.log("parking >>> : ");
    $.ajax({
        type : 'GET',                                  <!--GET / POST-->
        url : "http://127.0.0.1:5001/api_parking/parking",  
        data: {page: currentPage },
        dataType : 'JSON',
        success : function(parking){
        	console.log("result = " + parking);

        	var parkingList = $('#parkingList tbody')
        	
        	for (var i = 0; i < parking.length; i++) {
                        var adres = parking[i]['adres'];
                        var reglt_spot_nm = parking[i]['reglt_spot_nm'];
                        var x = parking[i]['latitude'];
                        var y = parking[i]['longitude'];
                        
                        var newRow = $('<tr>');

                        newRow.append($('<td>').text(adres));
                        newRow.append($('<td>').html('<a href="#" onclick="viewMap(\'' + x + '\',' + y + ')">지도보기</a>'));
                        $('#parkingList').append(newRow);
                        
                        
                                           
                    }
        	 
        	
        		/*
    	        $.each(parking, function(index, row) {
    	        	console.log("latitude:" + row.latitude + "longitude:" + row.longitude);
	            	var rowHtml = '<tr>' +
	            				  '<td>' + row.adres + '</td>' +
	            				  '<td>' + row.reglt_spot_nm + '</td>' +    //   x                     y
	            				  '<td><a href="#" onclick="viewMap(\'' + row.latitude + '\',' + row.longitude + ')">지도보기</a></td>' +
	            				  '</tr>';
	            	parkingList.append(rowHtml);
	            	
    	        });
	            	*/
            	
            // 페이지 버튼 추가
            addPageButtons();
            
				},                                                                                       
        error : function(xtr,status,error){
                alert(xtr +":"+status+":"+error);
                console.log(location.origin);                    
        }	
	});
}




// 페이지 변경 함수
function changePage(direction) {
    currentPage += direction;
    if (currentPage < 1) {
        currentPage = 1;
    }
    $('#parkingList').empty();
    parking();
}



function addPageButtons() {
    $('#buttonContainer').find('.pageButton').remove();
    $('#buttonContainer').prepend('<button class="pageButton" type="button" onclick="changePage(-1)">이전 페이지</button>');
    $('#buttonContainer').append('<button class="pageButton" type="button" onclick="changePage(1)">다음 페이지</button>');
}



$(document).ready(function(){
	parking();
	console.log("ready >>> : ");
});

</script>
	</head>
	<body>
	<h1>서울시 송파구 불법주정차 위반단속 CCTV 위치정보</h1>
	<p><a href="songpa_api_all">뒤로가기</a><p>
	<hr>
	<div class="box1" style="display : flex;">
	<div>
		<table border="1" id="parkingList">
			<thead>
				<tr>
					<th>CCTV 지번주소 </th>
					<th>단속지점명 </th>
				</tr>
			</thead>
			<tbody>
			

			</tbody>
		</table>
		<br>
        <div id="buttonContainer"></div>
	</div>	

		<div class="map_wrap">
			
			<table id="button">
			<tr>
				<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
				<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
				<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
				<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
				<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
				<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
				<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td>
			<a>
			<button onclick="setOverlayMapTypeId('traffic')">교통정보 보기</button> 
			<button onclick="setOverlayMapTypeId('roadview')">로드뷰 도로정보 보기</button> 
			<button onclick="setOverlayMapTypeId('terrain')">지형정보 보기</button>
			<button onclick="setOverlayMapTypeId('use_district')">지적편집도 보기</button>
			</a>
			</td> 
			</tr>
			</table>
			<br><br>
			<table>
			<tr>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td>
		    <div id="mapWrapper" style="width:1100px;height:450px;float:left">

		        <div id="map" style="width:100%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
	    	</div>
	    	</td>
	    	</tr>
			
			<tr>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p></td>
			<td>
	    	<div id="rvWrapper" style="width:100%;height:450px;float:left">
	    	    <div id="roadview" style="width:100%;height:100%"></div> <!-- 로드뷰를 표시할 div 입니다 -->
	    	</div>
	    	</td>
	    	</tr>
	    	</table>
		</div>

	</div>		
		
		


<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=8c7eef76db7690068e94ecb96c61ea6c&libraries=services" ></script>

		<script>
		
		var map; // 지역 변수 선언으로 setOverlayMapTypeId 함수에서 map을 가져 올 수 있음
		var mapCenter;
		var rvContainer;
		var rv;
		var rvClient;
		
		function viewMap(x, y){
			console.log("x:" + x + "y:" + y);
			var mapContainer = document.getElementById('map') // 지도를 표시할 div
			
				mapCenter = new kakao.maps.LatLng(x , y), // 지도의 가운데 좌표

		    mapOption = { 
		        center: new kakao.maps.LatLng(x, y), // 좌표
		        level: 3, // 지도의 확대 레벨
		        
		        //mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류

		    };
			
			map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(x, y); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);


			
		}
		

		// 지도에 추가된 지도타입정보를 가지고 있을 변수입니다
		var currentTypeId;	


		//버튼이 클릭되면 호출되는 함수입니다
		function setOverlayMapTypeId(maptype) {	
			console.log("setOverlayMapTypeId >>> : ")
			
			
			
			var changeMaptype;
			
		// maptype에 따라 지도에 추가할 지도타입을 결정합니다
		if (maptype === 'traffic') {            
			
		   // 교통정보 지도타입
		   changeMaptype = kakao.maps.MapTypeId.TRAFFIC;     
		    
		   
		} else if (maptype === 'roadview') {        
		   
		   // 로드뷰 도로정보 지도타입
		   changeMaptype = kakao.maps.MapTypeId.ROADVIEW; 
		   

		    rvContainer = document.getElementById('roadview'); //로드뷰를 표시할 div
		    rv = new kakao.maps.Roadview(rvContainer); //로드뷰 객체
		    rvClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체

		   toggleRoadview(mapCenter);

		   // 마커 이미지를 생성합니다.
		   var markImage = new kakao.maps.MarkerImage(
		       'https://t1.daumcdn.net/localimg/localimages/07/2018/pc/roadview_minimap_wk_2018.png',
		       new kakao.maps.Size(26, 46),
		       {
		           // 스프라이트 이미지를 사용합니다.
		           // 스프라이트 이미지 전체의 크기를 지정하고
		           spriteSize: new kakao.maps.Size(1666, 168),
		           // 사용하고 싶은 영역의 좌상단 좌표를 입력합니다.
		           // background-position으로 지정하는 값이며 부호는 반대입니다.
		           spriteOrigin: new kakao.maps.Point(705, 114),
		           offset: new kakao.maps.Point(13, 46)
		       }
		   );

		   // 드래그가 가능한 마커를 생성합니다.
		   var rvMarker = new kakao.maps.Marker({
		       image : markImage,
		       position: mapCenter,
		       draggable: true,
		       map: map
		   });

		   //마커에 dragend 이벤트를 할당합니다
		   kakao.maps.event.addListener(rvMarker, 'dragend', function(mouseEvent) {
		       var position = rvMarker.getPosition(); //현재 마커가 놓인 자리의 좌표
		       toggleRoadview(position); //로드뷰를 토글합니다
		   });

		   //지도에 클릭 이벤트를 할당합니다
		   kakao.maps.event.addListener(map, 'click', function(mouseEvent){
		       
		       // 현재 클릭한 부분의 좌표를 리턴 
		       var position = mouseEvent.latLng; 

		       rvMarker.setPosition(position);
		       toggleRoadview(position); //로드뷰를 토글합니다
		   });
		   
		   

		} else if (maptype === 'terrain') {
		   
		   // 지형정보 지도타입
		   changeMaptype = kakao.maps.MapTypeId.TERRAIN;    

		} else if (maptype === 'use_district') {
		   
		   // 지적편집도 지도타입
		   changeMaptype = kakao.maps.MapTypeId.USE_DISTRICT;           
		}

		// 이미 등록된 지도 타입이 있으면 제거합니다
		if (currentTypeId) {
		   map.removeOverlayMapTypeId(currentTypeId);    
		}

		// maptype에 해당하는 지도타입을 지도에 추가합니다
		map.addOverlayMapTypeId(changeMaptype);

		// 지도에 추가된 타입정보를 갱신합니다
		currentTypeId = changeMaptype;        
		}
		
		
		
		//로드뷰 toggle함수
		function toggleRoadview(position){

		    //전달받은 좌표(position)에 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄웁니다
		    rvClient.getNearestPanoId(position, 50, function(panoId) {
		        if (panoId === null) {
		            rvContainer.style.display = 'none'; //로드뷰를 넣은 컨테이너를 숨깁니다
		            //mapWrapper.style.width = '100%';
		            map.relayout();
		        } else {
		            //mapWrapper.style.width = '50%';
		            map.relayout(); //지도를 감싸고 있는 영역이 변경됨에 따라, 지도를 재배열합니다
		            rvContainer.style.display = 'block'; //로드뷰를 넣은 컨테이너를 보이게합니다
		            rv.setPanoId(panoId, position); //panoId를 통한 로드뷰 실행
		            rv.relayout(); //로드뷰를 감싸고 있는 영역이 변경됨에 따라, 로드뷰를 재배열합니다
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