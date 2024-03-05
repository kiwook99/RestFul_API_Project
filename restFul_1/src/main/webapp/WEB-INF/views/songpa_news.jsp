<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>서울시 보도자료</title>
		
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
<!-- <script  src="http://code.jquery.com/jquery-latest.min.js"></script>  --> 
<script type="text/javascript">
  
var currentPage = 1;

    // flask_api_news.html
	// rows.link = api에서는 링크가 있으나 추출할때는 없음
    function news(){
        
    	console.log("news >>> : ");
        $.ajax({
            type : 'GET',                                  <!--GET / POST-->
       		url : "http://127.0.0.1:5001/api_news/news",   
            data: {page: currentPage },
            dataType : 'JSON',
            success : function(news_list){
            	console.log("news_list = ", news_list);

            	var newsList = $('#newsList');
            	
            	/*
            	var newsList = $('#newsList tbody')
            	
            	for (var i = 0; i < news_list.length; i++) {
                            var PUBDATE = news_list[i]['pubdate'];
                            var TITLE = news_list[i]['title'];
                            var CN = news_list[i]['cn'];
                            
                            var newRow = $('<tr>');

                            newRow.append($('<td width="150px">').text(PUBDATE.substr(0,4) + '년 ' + PUBDATE.substr(5,2) + '월 ' + PUBDATE.substr(8,2) + '일'));
                           
                            newRow.append($('<td width="250px">').text(TITLE));
                            newRow.append($('<td>').text(CN));
                            $('#newsList').append(newRow);
                            
                            
                                               
                        }          	
            	
            	*/
            	
        	        $.each(news_list, function(index, rows) {
        	        	
    	            	var rowHtml = '<tr>' +
    	            				  '<td width="150px">' + rows.pubdate.substr(0,4) + '년 ' + rows.pubdate.substr(5,2) + '월 ' + rows.pubdate.substr(8,2) + '일' + '</td>' +
    	            				  '<td width="250px">'+  rows.title  + '</td>' +				       		          
				       		          '<td>' + rows.cn + '</td>' +
				       		          '</tr>'; 
    	            				 
   	            				  
    	           		newsList.append(rowHtml);
    	           		
    	       		  
                          console.log(location.origin);                    
                	});
            	
            	
            	
            	
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
        $('#newsList').empty();
        console.log(currentPage);
        news();
    }



    function addPageButtons() {
        $('#buttonContainer').find('.pageButton').remove();
        $('#buttonContainer').prepend('<button class="pageButton" type="button" onclick="changePage(-1)">이전 페이지</button>');
        $('#buttonContainer').append('<button class="pageButton" type="button" onclick="changePage(1)">다음 페이지</button>');
    }
    
    $(document).ready(function(){
    	news();

    });    
		
</script>				
	</head>
	<body>
	<h1>서울시 보도자료</h1>
	<p><a href="songpa_api_all">뒤로가기</a><p>
	<hr>	
		<div>
			<form>
	    		<table border="1" id="newsList">
	    			<thead>
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
				<div id="buttonContainer"></div>
		</div>



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