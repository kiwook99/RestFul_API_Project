from flask import Flask, request,Blueprint, jsonify
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup

# 애플리케이션 초기화
app = Flask(__name__, template_folder='templates')
# Cross-Origin:  웹 브라우저에서 실행 중인 스크립트가
# 한 출처(origin)에서 불러온 웹 페이지의 리소스를 다른 출처에서 불러올 수 있도록 허용하는 기술.
CORS(app)

# 페이징 함수
def get_paged_data(page, page_size, data):
    start_idx = (page - 1) * page_size
    end_idx = start_idx + page_size
    paged_data = data[start_idx:end_idx]


app = Blueprint('gw8', __name__, url_prefix='/gw8')
# 관악구 공영주차장 정보를 가져오는 라우트
@app.route('/searchparking', methods=['POST'])
def search_parking():
# 주차장 검색을 위한 라우트
    api = 'http://openapi.seoul.go.kr:8088/{key}/xml/GetParkInfo/1/362/%ea%b4%80%ec%95%85'
    apikey = '4f7554547074657338357545716671'

    search_text = request.json.get('search_text', '')

    url = api.format(key=apikey)
    res = req.urlopen(url)
    
    soup = BeautifulSoup(res, 'lxml')
    result_list = []

    # 검색된 주차장 정보를 담을 리스트
    search_results = []

    # 모든 <row> 태그에 대해 반복
    for row_element in soup.find_all('row'):    
        # 각각의 <row> 태그에 대한 데이터 추출
        row_data = {}
        for child_element in row_element.children:
            if child_element.name is not None:
                row_data[child_element.name] = child_element.text

        # 검색어와 주차장 정보 중에서 어떤 필드에서든 검색어가 포함되어 있으면 결과에 추가
        if any(search_text.lower() in value.lower() for value in row_data.values()):
            search_results.append(row_data)

    # 결과를 JSON 형태로 출력
    start_idx = (1 - 1) * len(search_results)
    end_idx = start_idx + len(search_results)
    paged_data = search_results[start_idx:end_idx]

    return jsonify(paged_data)
