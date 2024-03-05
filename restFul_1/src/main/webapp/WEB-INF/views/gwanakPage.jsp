<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
	  body {
	   font-family: 'Malgun Gothic', sans-serif;
	    background-color: #ECEFF1;
	    margin: 0;
	    padding: 0;
	   justify-content: center;
	    height: 100vh;
	  }
	
	  div.weather {
	    width: 200px;
	    height: 350px;
	    background-color: #BBDEFB;
	    padding: 20px;
	    border-radius: 10px;
	    margin: 20px;
	    text-align: center;
	  }
	
	  table {
	    margin: 0 auto;
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 10px;
	  }
	
	  #wfEn {
	    max-width: 100%;
	    height: auto;
	    display: block;
	    margin: 0 auto;
	  }
	  #result-container {
	    width: 100%;
	    height: 100%;
	    box-sizing: border-box;
	    padding: 8px;
	    text-align: center;
	  }
	  .weather td {
	    padding: 8px;
	    text-align: left;
	  }
	  
	  #main {
	  	  display: flex;	  
	  }
	
	  .main {
		  width: 100%;
		  max-width: 1250px;
		  box-sizing: border-box;
		  padding: 20px;
		  border-radius: 10px;
	  }
	
	  .main table {
	    width: 100%;
	  	border-collapse: collapse;
	    margin-top: 10px;
	  }
	
	  .main td {
	    padding: 5px;
	    text-align: center;
	  }
	
	  .main img {
	    max-width: 100%;
	    height: auto;
	    display: block;
	    margin: 10px 0; /* 이미지 위 아래 여백 추가 */
	  }
	
	 .main a {
	    text-decoration: none;
	    display: inline-block;
	    padding: 10px 20px;
	    margin: 10px;
	    color: #fff;
	    background-color: #3498db;
	    border-radius: 5px;
	    transition: background-color 0.3s;
	    white-space: nowrap;
	  }
	</style>
</head>
	<body>
	<div id="file">
		<%@ include file="mainGwanak.jsp" %>
	</div>
	<div id="main">
	<div class='main'>
		<table border=1>
			<tr>
				<td>관악구 소식</td>
			</tr>
			<tr>
				<td><div id="result-container"></div></td>
			</tr>
			<tr>
				<td>실시간 서울 돌발 교통 정보</td>
			</tr>
			<tr>
				<td><div id="topis-container"></div></td>
			</tr>
			<tr>
				<td>관악구 통계</td>
			</tr>
			<tr>
				<td>인구변화 통계</td>
			</tr>
			<tr>
				<td><img src="data:image/png;base64,${imageData}" alt="Image" /></td>
			</tr>
			<tr>
				<td>교육기관 통계</td>
			</tr>
			<tr>
				<td><img src="http://192.168.0.4:5001/static/plot2.png"/></td>
			</tr>
			<tr>
				<td><a href="school">관악구 학교리스트</a></td>
			</tr>
			<tr>
				<td><a href="parking">관악구 공영주차장리스트</a></td>
			</tr>
		</table>
	</div>
	<div class='weather'>
		<table>
			<tr>
				<td colspan='2'><img id="wfEn" src="" alt="image loding.."></td>
			</tr>
			<tr>
				<td id ="wea" colspan='2' style="text-align: center;">관악구 날씨</td>
			</tr>
			<tr>
				<td id ="wfKor" colspan='2' style="text-align: center;"></td>
			</tr>
			<tr>
				<td>온도:</td>
				<td id ="temp"></td>
			</tr>
			<tr>
				<td>강수확률:</td>
				<td id ="pop"></td>
			</tr>
			<tr>
				<td>습도:</td>
				<td id ="reh"></td>
			</tr>
		</table>
	</div>
	</div>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function weatherImage() {
			$.ajax({
	            type : 'GET',
	            url : 'http://127.0.0.1:5001/gw1/weathers',
	            dataType : 'JSON',
	            success : function(result){
	            	
	            		console.log("result = "+ result);
	            		console.log("result.wfEn = "+ result.wfEn);
	            		var imgSrc = './resources/img/'+ result.wfEn + '.png';
	            		$('#temp').html(result.temp + '℃');
	                    $('#wfKor').html(result.wfKor);
	                    $('#wfEn').attr('src', imgSrc);
	                    $('#pop').html(result.pop + '%');
	                    $('#reh').html(result.reh + '%');
	                    console.log(imgSrc);
	            },
	            	error : function(xtr,status,error){
	                alert(xtr +":"+status+":"+error);
	           	}
			});
		}
		
		function gwanakNewsList() {
		   $.ajax({
		        type: 'GET',
		        url: 'http://127.0.0.1:5001/gw5/gwanakNewsList',
		        dataType: 'json',
		        success: function(data) {
		            // 받아온 JSON 데이터를 표시
		            var resultContainer = $('#result-container');
		            var menuHtml = '<tr><td>제목</td><td>날짜</td><td>링크</td></tr>';
		            
		            resultContainer.append(menuHtml);
		            
		            $.each(data, function(index, row) {
		                var rowHtml = '<tr style="border: 1px solid #ddd;">' +
					                    '<td>' + row.title + '</td>' +
					                    '<td>' + row.writeday + '</td>' +
					                    '<td><a href=' + row.expanded_url + '> 바로가기 </a></td>' +
					                    '</tr>';
		                resultContainer.append(rowHtml);
		            });
		        },
		        	error: function(xhr, status, error) {
		            console.error('Error fetching JSON data:', error);
		        }
		    });
		}
		
		function topis() {
			   $.ajax({
			        type: 'GET',
			        url: 'http://127.0.0.1:5001/gw6/topis',
			        dataType: 'json',
			        success: function(data) {
			        	console.log("data = "+ data);
			            // 받아온 JSON 데이터를 표시
			            var resultContainer = $('#topis-container');
			            var menuHtml = '<tr><td>돌발내용</td><td>발생일자</td><td style="padding: 8px; white-space: nowrap;">발생시간</td></tr>';
			            
			            resultContainer.append(menuHtml);
			            $.each(data, function(index, row) {
			            	var dt = row.occr_date;
			            	var ti = row.occr_time;
			            	var date = dt.slice(0,4) + '년' + dt.slice(4, 6) + '월' + dt.slice(6,8) + '일';
			            	var time = ti.slice(0,2) + '시' + ti.slice(2, 4) + '분' + ti.slice(4,6) + '초';
			            	
			                var rowHtml = '<tr style="border: 1px solid #ddd;"><td>' + row.acc_info +'</td>' +
			                			  '<td>'+ date + '</td>'+
			                			  '<td>' + time + '</td></tr>';
			                resultContainer.append(rowHtml);
			            });
			        },
			        	error: function(xhr, status, error) {
			            console.error('Error fetching JSON data:', error);
			        }
			    });
			}
	
		
		$(document).ready(function() {
			weatherImage();
			gwanakNewsList();
			topis();
		});
	</script>
</body>
</html>