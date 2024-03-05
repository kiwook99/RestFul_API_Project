<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body style="margin: 20px; font-family: Arial, sans-serif;">
	<div>
		<%@ include file="mainGwangMyeong.jsp" %>
	</div>
    <div class='main' style="display: flex;">

        <!-- 왼쪽 컨텐츠: 광명시 전기 충전소 -->
        <div style="border: 2px solid orange; border-radius: 10px; padding: 10px; margin-right: 20px;">
            <table border=1 style="border-collapse: collapse; width: 100%;">
                <tr style="background-color: orange; color: white; font-weight: bold; border-bottom: 2px solid white;">
                    <td>광명시 전기 충전소</td>
                </tr>
                <tr>
                    <td>
                        <div id="topis-container" style="padding: 10px; background-color: lightblue; border: 1px solid orange; border-radius: 5px;">
                            <!-- 내용 -->
                        </div>
                    </td>
                </tr>
                <tr style="background-color: orange; color: white; font-weight: bold;">
                    <td>광명시 학교 현황</td>
                </tr>
                <tr>
                    <td>
                        <canvas id="barChart" width="400" height="200" style="border: 1px solid orange; border-radius: 5px;"></canvas>
                    </td>
                </tr>
            </table>
        </div>
 <div class='weather' style="border: 2px solid dodgerblue; border-radius: 10px; padding: 10px;">
    <table>
    <tr>
    <td colspan='2'>
    <img id="wfEn" src="" alt="image loding..">
    </td>
    </tr>
        <tr>
            <td id ="wea" colspan='2' style="text-align: center;">광명시 날씨</td>
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
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
    function weatherImage() {
        $.ajax({
            type: 'GET',
            url: 'http://127.0.0.1:5001/gwangmyeong_weather/gwangmyeong_weather',
            dataType: 'JSON', 
            success: function (result) {

                console.log("result = " + result);
                console.log("result.wfEn = " + result.wfEn);

                var imgSrc = './resources/img/' + result.wfEn + '.png';
                $('#temp').html(result.temp + '℃');
                $('#wfKor').html(result.wfKor);
                $('#wfEn').attr('src', imgSrc);
                $('#pop').html(result.pop + '%');
                $('#reh').html(result.reh + '%');
                console.log(imgSrc);
            },
            error: function (xtr, status, error) {
                alert(xtr + ":" + status + ":" + error);
            }
        });
    }

    function getParkingData() {
        $.ajax({
            type: 'GET',
            url: 'http://127.0.0.1:5001/gwangmyeong_parking/gwangmyeong_parking',
            dataType: 'JSON',
            success: function (result) {
                var parkingContainer = $('#topis-container');

                // 각 충전소 정보를 돌면서 테이블에 추가
                $.each(result, function (index, chargingStation) {
                    var row = $('<div>').html(
                        '<strong>충전소명:</strong> ' + chargingStation['충전소명'] +
                        ', <strong>충전기 타입:</strong> ' + chargingStation['충전기 타입'] +
                        ', <strong>주소:</strong> ' + chargingStation['주소']
                    );
                    parkingContainer.append(row);
                });
            },
            error: function (xtr, status, error) {
                alert(xtr + ":" + status + ":" + error);
            }
        });
    }

    function createBarChart(data) {
        var ctx = document.getElementById('barChart').getContext('2d');

        var chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: data.labels,
                datasets: [{
                    label: '학교 개수',
                    data: data.counts,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        beginAtZero: true
                    },
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }
    
    function getSchoolData() {
        $.ajax({
            type: 'GET',
            url: 'http://127.0.0.1:5001/gwangmyeong_school/gwangmyeong_school',
            dataType: 'JSON',
            success: function (result) {
                var data = {
                    labels: [],
                    counts: []
                };

                // 학교 정보를 돌면서 데이터에 추가
                $.each(result.school_type_counts, function (schoolType, count) {
                    data.labels.push(schoolType);
                    data.counts.push(count);
                });

                // 데이터를 역순으로 정렬
                data.labels.reverse();
                data.counts.reverse();

                // 막대 그래프 생성 함수 호출
                createBarChart(data);
            },
            error: function (xtr, status, error) {
                alert(xtr + ":" + status + ":" + error);
            }
        });
    }

    $(document).ready(function () {
        weatherImage();
        getParkingData();
        getSchoolData();
    });
</script>
</body>