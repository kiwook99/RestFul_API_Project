from flask import Flask, request, jsonify, Blueprint
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup

# 애플리케이션 초기화
app = Flask(__name__, template_folder='templates')
# Cross-Origin:  웹 브라우저에서 실행 중인 스크립트가
# 한 출처(origin)에서 불러온 웹 페이지의 리소스를 다른 출처에서 불러올 수 있도록 허용하는 기술.
CORS(app)

# 페이징 함수
    
app = Blueprint('gw7', __name__, url_prefix='/gw7')
# 관악구 공영주차장 정보를 가져오는 라우트
@app.route('/parking', methods=['GET'])
def parking():
    #api = 'http://openapi.seoul.go.kr:8088/{key}/xml/GetParkInfo/1/5/관악' 원래 api는 관악이라고 써야하지만 url에 한글이 들어가면 오류가 나서 퍼센트 인코딩으로 변환
    api = 'http://openapi.seoul.go.kr:8088/{key}/xml/GetParkInfo/1/362/%ea%b4%80%ec%95%85'
    apikey = '4f7554547074657338357545716671'

    page = int(request.args.get('page', 1))
    page_size = int(request.args.get('page_size', 20))


    url = api.format(key=apikey)
    res = req.urlopen(url)

    soup = BeautifulSoup(res, 'lxml')
    result_list = []

    # 모든 <row> 태그에 대해 반복
    for row_element in soup.find_all('row'):    
        # 각각의 <row> 태그에 대한 데이터 추출
        row_data = {}
        for child_element in row_element.children:
            if child_element.name is not None:
                row_data[child_element.name] = child_element.text
        result_list.append(row_data)

    # 결과를 JSON 형태로 출력
    start_idx = (page - 1) * page_size
    end_idx = start_idx + page_size
    paged_data = result_list[start_idx:end_idx]

    return jsonify(paged_data)