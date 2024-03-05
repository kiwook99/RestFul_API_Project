<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
 <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zsrcsa9kp7"></script>
 <style>
        .container {
            display: flex;
        }

        #parkingList {
            flex: 1;
            margin-left: 60px; /* 조절 가능한 여백 */
        }

        #mapContainer {
               flex: 2;
            height: 900px; /* 조절 가능한 높이 */
            margin-right: 40px;
            margin-left: -70px;
        }

        #parkingListTable {
            margin-bottom: 10px; /* 조절 가능한 여백 */
        }
    </style>
</head>
<body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

    $(document).ready(function() {
        parking(); // test 함수 호출
    });

    function parking() {
        $.ajax({
            type: 'GET',
            url: 'http://127.0.0.1:5001/in5/parking',
            dataType: 'json',
            success: function (result) {
                console.log(result);  // 받은 데이터를 콘솔에 출력
                // JSON.stringify()를 사용하여 JSON 객체를 문자열로 변환
                var jsonString = JSON.stringify(result);
                // 테이블에 데이터를 추가하는 부분
                for (var i = 0; i < result.length; i++) {
                    var name = result[i].name;
                    var latx = result[i].latx;
                    var longy = result[i].longy;

                    // 새로운 행(tr)을 생성하여 데이터를 표시
                    var newRow = $('<tr>');
                    // 각 데이터를 새로운 셀(td)에 추가
                    newRow.append($('<td>').text(name));
                    newRow.append($('<td>').html('<a href="#" onclick="viewMap(\'' + name + '\', ' + latx + ', ' + longy + ')">지도보기</a>'));

                    // 생성한 행을 테이블에 추가
                    $('#parkingListTable').append(newRow);
                }

                // 검색창 추가
                var searchInput = $('<input type="text" id="searchInput" placeholder="주차장 검색...">');
                $('#parkingList').prepend(searchInput); // #parkingList div의 가장 앞에 추가

                // 검색 이벤트 핸들러 등록
                $('#searchInput').on('input', function() {
                    var searchText = $(this).val().toLowerCase();
                    filterTable(searchText);
                });
            },
            error: function (xhr, status, error) {
                alert(xhr + ':' + status + ':' + error);
            }
        });
    }

    function filterTable(searchText) {
        // 검색 텍스트를 가져와서 테이블을 필터링
        $('#parkingListTable tr').filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(searchText) > -1);
        });
    }

    function viewMap(name, latx, longy) {
        var mapContainer = $('<div id="map" style="width: 100%; height: 100%;"></div>');
        $('#mapContainer').empty().append(mapContainer);

        var map = new naver.maps.Map(mapContainer[0], {
            center: new naver.maps.LatLng(latx, longy),
            zoom: 18
        });

        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(latx, longy),
            map: map
        });

        var contentString = [
            '<div class="iw_inner">',
            '   <h3>' + name + '</h3>',
            '   </p>',
            '</div>'
        ].join('');

        var infowindow = new naver.maps.InfoWindow({
            content: contentString
        });

        naver.maps.Event.addListener(marker, "click", function(e) {
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
        });

        infowindow.open(map, marker);
    }
</script>

<div class="container">
    <div id="parkingList">
        <table border="1" id="parkingListTable">
            <thead>
            <tr>
                <th>공영주차장 목록</th>
                 <th>
                    <button onclick="window.location.href='incheon'">돌아가기</button>
                </th>
            </tr>
            </thead>
            <tbody>
            <!-- 데이터가 여기에 추가될 것입니다. -->
            </tbody>
        </table>
    </div>

    <div id="mapContainer"></div>
</div>

</body>
</html>