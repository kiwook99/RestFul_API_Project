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

# 학교 목록 정보를 가져오는 라우트
api = 'http://openapi.seoul.go.kr:8088/{key}/xml/neisSchoolInfo_ga/1/260/'
apikey = '4f7554547074657338357545716671'

url = api.format(key=apikey)
res = req.urlopen(url)

soup = BeautifulSoup(res, 'lxml')
output = ""
for i, location in enumerate(soup.select("row")):
    if i % 2 == 0: # 1행에 2개씩 출력
        output += "<div class='location-row'>"

    output += "<div id={} class='location-item' style='width: 48%;background: #eee;padding-left: 30px;'>".format(location.select_one("SCHUL_NM").string)
    output += "<h3>{}</h3>".format(location.select_one("SCHUL_NM").string)
    output += "<h4>{}</h4>".format(location.select_one("FOND_SC_NM").string)
    output += "<h4>{}</h4>".format(location.select_one("ORG_RDNMA").string)
    output += "<h4>{}</h4>".format(location.select_one("HMPG_ADRES").string)
    output += "<h4>{}</h4>".format(location.select_one("ORG_FAXNO").string)
    output += "<a href='https://map.kakao.com/link/search/{}' target='_blank'>지도보기</a>".format(location.select_one("ORG_RDNMA").string)
    output += "</div>"

    if i % 2 == 1 or i == len(soup.select("row")) - 1:
        output += "</div>"

# CSS 스타일 추가
output += "<style>"
output += ".location-row { display: flex; justify-content: space-between; margin-bottom: 20px; }"
output += ".location-item { box-sizing: border-box; }"
output += "</style>"

json_str = json.dumps({'data': output}, ensure_ascii=False)

app = Blueprint('gw3', __name__, url_prefix='/gw3')

@app.route('/schoolList', methods=['GET'])
def schoolList():
    return json_str
