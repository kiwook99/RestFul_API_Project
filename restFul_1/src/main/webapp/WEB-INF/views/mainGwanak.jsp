<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
        #mdindiv {
            text-align: center;
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 220px;
        }

        h1 {
            color: #333;
        }
        
        #logo {
        	display: flex;
        }
        
        #logo img {
        	margin-right: 20px;
        	width: 90px;
			height: 90px;
        }

        #menu {
            border-bottom: 2px solid #000;
   			padding-bottom: 5px;
            list-style-type: none;
            padding: 0;
            display: flex;
        }

        #menu li {
            margin-right: 10px;
            background-color: #eee;
            padding: 10px;
            border-radius: 5px;
        }
        
        #menu a {
		  	text-decoration: none;
		  	color: #333;
		}
		
    </style>
</head>
<body>
<div id=mdindiv>
    <div id="logo">
	    <div><img src="./resources/img/gwanak.jpg"/></div>
	    <h1>API 활용 프로젝트</h1>
    </div>
    <ul id="menu">
        <li><a href="incheon">인천시</a></li>
        <li><a href="Anyang">안양시</a></li>
        <li><a href="gwanak">관악구</a></li>
        <li><a href="songpa_api_all">송파구</a></li>
        <li><a href="Gwangmyeong">광명시</a></li>
    </ul>
</div>
</body>
</html>