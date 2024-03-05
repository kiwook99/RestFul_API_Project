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
	    text-align: center;
	    margin: 0;
	  }
	
	  a {
	    text-decoration: none;
	    display: inline-block;
	    padding: 10px 20px;
	    margin: 10px;
	    color: #fff;
	    background-color: #3498db;
	    border-radius: 5px;
	    transition: background-color 0.3s;
	  }
	
	  a:hover {
	    background-color: #2980b9;
	  }
	
	  #schoolList {
	    width: 100%;
	    height: 200px;
	    background-color: #fff;
	    margin-top: 20px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	  }
	  
	  #searchInput {
	    width: 80%;
	    padding: 10px;
	    margin: 20px;
	    font-size: 16px;
	    box-sizing: border-box;
	  }
	</style>
</head>
<body>
	<a href="gwanak">뒤로가기</a>
	<input type="text" id="searchInput" placeholder="학교 검색...">
	<div id="schoolList"></div>
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		var currentPage = 1;
		var pageSize = 10;
		
	    function filterTable(searchText) {
	        // 검색 텍스트를 가져와서 테이블을 필터링
	        $('#schoolList div').each(function() {
	            var rowText = $(this).text().toLowerCase();
	            if (rowText.indexOf(searchText) > -1) {
	                $(this).show();  // 텍스트에 포함된 경우 행을 보이게 함
	            } else {
	                $(this).hide();  // 텍스트에 포함되지 않은 경우 행을 숨김
	            }
	        });
	    }
	
	    function inputTable() {
	        $('#searchInput').on('input', function() {
	            var searchText = $(this).val().toLowerCase();
	            filterTable(searchText);
	        });
	    }
	
	    function fetchDataAndSetHref(callback) {
	        $.ajax({
	            type: 'GET',
	            url: 'http://127.0.0.1:5001/gw3/schoolList',
	            dataType: 'JSON',
	            success: function(result) {
	                console.log("result = " + JSON.stringify(result));

	                $('#schoolList').append(result.data);
	                
	                if (typeof callback === 'function') {
	                    callback();
	                }
	            },
	            error: function(xtr, status, error) {
	                alert(xtr + ":" + status + ":" + error);
	            }
	        });
	    }
	
	    $(document).ready(function() {
	        fetchDataAndSetHref(function() {
	            inputTable();
	        });
	    });
	</script>
</body>
</html>
