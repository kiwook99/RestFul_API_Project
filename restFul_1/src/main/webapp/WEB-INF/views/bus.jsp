<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Insert title here</title>
 <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zsrcsa9kp7&submodules=panorama"></script>
    <style>
        .container {
            display: flex;
        }

        #busList {
            flex: 1;
            margin-left: 5px; /* 조절 가능한 여백 */
        }

        #mapContainer {
            flex: 2;
            height: 900px; /* 조절 가능한 높이 */
            margin-right: 30px;
            margin-left: 20px;
        }

        #busListTable {
            margin-bottom: 10px; /* 조절 가능한 여백 */
        }

        #buttonContainer {
            margin-top: 10px; /* 페이지 버튼과 테이블 사이 여백 조절 가능 */
        }
        
       
    </style>
</head>

<body>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">
        var currentPage = 1;
        var $busList = $('#busList');
        var searchInputAdded = false;
        var initialLocation = null; // 초기 지도 위치

        $(document).ready(function () {
            // 데이터 로딩
            bus();
        });

        function bus() {
            $.ajax({
                type: 'GET',
                url: 'http://127.0.0.1:5001/in7/bus',
                data: { page: currentPage },
                dataType: 'json',
                success: function (result) {
                    var jsonString = JSON.stringify(result);
                    var tbody = $('#busListTable tbody').empty();

                    for (var i = 0; i < result.length; i++) {
                        var name = result[i]['정류소명'];
                        var number = result[i]['정류소번호'];
                        var addr = result[i]['권역'];
                        var addr2 = result[i]['행정동명'];
                        var y = result[i]['위도'];
                        var x = result[i]['경도'];

                        var newRow = $('<tr>');
                        newRow.append($('<td>').text('(' + addr + '/' + addr2 + ')' + ' 정류소명: ' + name));
                        newRow.append($('<td>').html('<a href="#" onclick="viewMap(\'' + name + '\', \'' + number + '\', \'' + addr2 + '\',' + x + ',' + y + ')">지도보기</a>'));

                        $('#busListTable').append(newRow);
                    }

                    // 검색창 추가
                    if (!searchInputAdded) {
                        var searchInput = $('<input type="text" id="searchInput" placeholder="도서관 검색...">');
                        $('#busList').prepend(searchInput);
                        searchInputAdded = true;
                    }

                    // 검색 이벤트 핸들러 등록
                    $('#searchInput').on('input', function () {
                        var searchText = $(this).val().toLowerCase();
                        filterTable(searchText);
                    });

                    // 페이지 버튼 추가
                    addPageButtons();

                    // 지도 초기화 (페이지 로드할 때는 초기화하지 않음)
                    if (map === null && pano === null) {
                        initMap(result);
                    }
                },
                error: function (xhr, status, error) {
                    alert(xhr + ':' + status + ':' + error);
                }
            });
        }

        function initMap(result) {
            var mapContainer = $('<div id="map" style="width: 100%; height: 50%;"></div>');
            $('#mapContainer').empty().append(mapContainer);

            var center = getAverageLocation(result);
            initialLocation = center; // 초기 지도 위치 설정

            map = new naver.maps.Map(mapContainer[0], {
                center: center,
                zoom: 13
            });

            for (var i = 0; i < result.length; i++) {
                var name = result[i]['정류소명'];
                var y = result[i]['위도'];
                var x = result[i]['경도'];

                var marker = new naver.maps.Marker({
                    position: new naver.maps.LatLng(x, y),
                    map: map
                });
            }
        }

        function getAverageLocation(result) {
            var totalX = 0;
            var totalY = 0;

            for (var i = 0; i < result.length; i++) {
                totalX += result[i]['경도'];
                totalY += result[i]['위도'];
            }

            var averageX = totalX / result.length;
            var averageY = totalY / result.length;

            return new naver.maps.LatLng(averageY, averageX);
        }

        // 페이지 변경 함수
        function changePage(direction) {
            currentPage += direction;

            if (currentPage < 1) {
                currentPage = 1;
            }

            $('#busListTable').empty();
            bus();
        }

        function addPageButtons() {
            $('#buttonContainer').find('.pageButton').remove();

            $('#buttonContainer').prepend('<button class="pageButton" type="button" onclick="changePage(-1)">이전 페이지</button>');
            $('#buttonContainer').append('<button class="pageButton" type="button" onclick="changePage(1)">다음 페이지</button>');
        }

        function filterTable(searchText) {
            $('#busListTable tbody tr').filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(searchText) > -1);
            });
        }

        function viewMap(name, number, addr2, x, y) {
            var mapContainer = $('<div id="map" style="width: 100%; height: 50%;"></div>');
            var panoContainer = $('<div id="pano" style="width: 100%; height: 50%;"></div>');

            $('#mapContainer').empty().append(mapContainer).append(panoContainer);

            // 클릭 시에만 지도 및 파노라마 초기화
            map = new naver.maps.Map(mapContainer[0], {
                center: initialLocation, // 초기 지도 위치로 설정
                zoom: 18
            });

            var marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(x, y),
                map: map
            });

            pano = new naver.maps.Panorama("pano", {
                position: new naver.maps.LatLng(x, y),
                pov: {
                    pan: -133,
                    tilt: 0,
                    fov: 100
                }
            });

            naver.maps.Event.addListener(pano, 'pano_changed', function () {
                var latlng = pano.getPosition();

                if (!latlng.equals(map.getCenter())) {
                    map.setCenter(latlng);
                }
            });

            var streetLayer = new naver.maps.StreetLayer();
            naver.maps.Event.once(map, 'init', function () {
                streetLayer.setMap(map);
            });

            var btn = $('#street');
            btn.on("click", function (e) {
                e.preventDefault();

                if (streetLayer.getMap()) {
                    streetLayer.setMap(null);
                } else {
                    streetLayer.setMap(map);
                }
            });

            naver.maps.Event.addListener(map, 'streetLayer_changed', function (streetLayer) {
                if (streetLayer) {
                    btn.addClass('control-on');
                } else {
                    btn.removeClass('control-on');
                }
            });

            naver.maps.Event.addListener(map, 'click', function (e) {
                if (streetLayer.getMap()) {
                    var latlng = e.coord;
                    pano.setPosition(latlng);
                }
            });

            var contentString = [
                '<div class="iw_inner">',
                '   <h4>' + name + '(' + number + ')' + '</h4>',
                '   <h4>' + addr2 + '</h4>',
                '</div>'
            ].join('');

            var infowindow = new naver.maps.InfoWindow({
                content: contentString
            });

            naver.maps.Event.addListener(marker, "click", function (e) {
                if (infowindow.getMap()) {
                    infowindow.close();
                } else {
                    infowindow.open(map, marker);
                }
            });

            infowindow.open(map, marker, pano);
        }
    </script>
    <div class="container">
        <div id="busList">
            <table border="1" id="busListTable">
                <thead>
                    <tr>
                        <th>버스정류장 목록</th>
                        <th>
                            <button onclick="window.location.href='incheon'">돌아가기</button>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 데이터가 여기에 추가될 것입니다. -->
                </tbody>
            </table>
            <div id="buttonContainer"></div>
        </div>
        <div id="mapContainer"></div>
        <div id="pano"></div>
    </div>
</body>
</html>