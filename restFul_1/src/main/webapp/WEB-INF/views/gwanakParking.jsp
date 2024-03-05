<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
  	body {
      font-family: 'Malgun Gothic', sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }
    
    .container {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
      max-width: 1200px;
      margin: 20px auto;
      background-color: #fff;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    
    #list_parking {
      flex: 1;
      margin-right: 20px;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    
    #searchInput {
      width: 70%;
      padding: 10px;
      font-size: 16px;
      box-sizing: border-box;
    }
    
    button {
      padding: 9px 9px;
      font-size: 16px;
      background-color: #3498db;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
  </style>
</head>
<body>
<a href="gwanak">뒤로가기</a>
<div class="container" style="display: flex;">
    <div id= list_praking>
    <input type="text" id="searchInput" placeholder="주차장 검색...">
    <button onclick="searchParking()">검색</button>
        <table border="1" id="parkingList">
            <thead>
            <tr>
                <th>공영주차장 목록</th>
                <th>주소</th>
                <th>유무료 구분</th>
                <th>야간 무료개방 여부</th>
                <th>주말 유무료 구분</th>
                <th>지도보기</th>
            </tr>
            </thead>
            <tbody>
            <!-- 데이터가 여기에 추가될 것입니다. -->
            </tbody>
        </table>
        <div id="pagination">
                    <!-- 페이징 버튼이 여기에 추가될 것입니다. -->
        </div>
    </div>
    <div id="mapContainer" style="width:500px;height:400px;">
    	<p>api에서 제공하는 좌표가 누락된 경우에는 지도가 나오지 않을수 있습니다</p>
    </div>
</div>
<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=a9ebba1056f14cfd5ef8692b0b89f172"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	var page_size = 20;
	var list_total_count = 362;
	
    function searchParking() {
        var searchText = $('#searchInput').val();

        $.ajax({
            type: 'POST',
            url: 'http://127.0.0.1:5001/gw8/searchparking',
            contentType: 'application/json;charset=UTF-8',
            data: JSON.stringify({ search_text: searchText }),
            success: function (response) {
                // 검색 결과를 처리
                console.log(response);
                // 검색 결과를 표시할 함수 호출
                displaySearchResults(response);
            },
            error: function (error) {
                console.error('Error during search:', error);
            }
        });
    }
    
    // 검색 결과를 표시하는 함수
    function displaySearchResults(results) {
        var parkingList = $('#parkingList');
        parkingList.empty();

        $.each(results, function (index, row) {
            var rowHtml = '<tr>' +
                '<td>' + row.parking_name + '</td>' +
                '<td>' + row.addr + '</td>' +
                '<td>' + row.pay_nm + '</td>' +
                '<td>' + row.night_free_open_nm + '</td>' +
                '<td>' + row.saturday_pay_nm + '</td>' +
                '<td><a href="#" onclick="viewMap(\'' + row.lat + '\',' + row.lng + ')">지도보기</a></td>' +
                '</tr>';
            parkingList.append(rowHtml);
        });

	        // 페이징 처리
	        generatePagination(list_total_count, page_size);
    }
	
	//카카오 지도 api
	function viewMap(x, y) {
		console.log("x:" + x + "y:" + y);
	var mapContainer = document.getElementById('mapContainer'), // 지도를 표시할 div 
	   mapOption = {
	       center: new kakao.maps.LatLng(x , y), // 지도의 중심좌표
	       level: 4, // 지도의 확대 레벨
	       mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
	   }; 
	
	      var map = new kakao.maps.Map(mapContainer, mapOption); 
	  }
	  
	function fetchDataAndSetHref(page, pageSize) {
	     $.ajax({
	         type: 'GET',
	         url: 'http://127.0.0.1:5001/gw7/parking',
	         data: { page: page, page_size: pageSize },
	         dataType: 'JSON',
	         success: function (data) {
	         console.log("result = " + JSON.stringify(data)); 
	         var parkingList = $('#parkingList');
             parkingList.empty();
             
	         $.each(data, function(index, row) {
	         	var rowHtml = '<tr>' +
	         				  '<td>' + row.parking_name + '</td>' +
	         				  '<td>' + row.addr + '</td>' +
	         				  '<td>' + row.pay_nm + '</td>'+
	         				  '<td>' + row.night_free_open_nm + '</td>' +
	         				  '<td>' + row.saturday_pay_nm + '</td>' +
	         				  '<td><a href="#" onclick="viewMap(\'' + row.lat + '\',' + row.lng + ')">지도보기</a></td>' +
	         				  '</tr>';
	         	parkingList.append(rowHtml);
	         });
			     // 페이징 처리
			 	 generatePagination(list_total_count, page_size);
		     },
			     error: function (xtr, status, error) {
			     alert(xtr + ":" + status + ":" + error);
		    }
		});
	}
	    
	   function generatePagination(list_total_count, page_size) {
	        var totalPage = Math.ceil(list_total_count / page_size);
	        var pagination = $('#pagination');
            pagination.empty();
            console.log("totalData = "+ list_total_count +"page_size"+page_size);
	        for (var i = 1; i <= totalPage; i++) {
	            var pageButton = '<button onclick="changePage(' + i +', ' + page_size + ')">' + i + '</button>';
	            pagination.append(pageButton);
	        }
	    }

	    function changePage(page, page_size) {
	        fetchDataAndSetHref(page, page_size);
	    }
	
	$(document).ready(function () {
	    fetchDataAndSetHref(1, page_size); // 데이터를 가져오고 href 설정
	});
</script>
</body>
</html>