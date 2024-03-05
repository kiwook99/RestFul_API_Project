from flask import Flask, Blueprint
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup
import json

# 애플리케이션 초기화
app = Flask(__name__, template_folder='templates')
# Cross-Origin:  웹 브라우저에서 실행 중인 스크립트가
# 한 출처(origin)에서 불러온 웹 페이지의 리소스를 다른 출처에서 불러올 수 있도록 허용하는 기술.
CORS(app)

# 실시간 서울 돌발 교통 정보를 가져오는 라우트
api = 'http://openapi.seoul.go.kr:8088/{key}/xml/AccInfo/1/5/'
apikey = '4f7554547074657338357545716671'

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
result_json = json.dumps(result_list, indent=2, ensure_ascii=False)

app = Blueprint('gw6', __name__, url_prefix='/gw6')

@app.route('/topis', methods=['GET'])
def topis():
    return result_json