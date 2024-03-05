from flask import Flask, Blueprint
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup

# 애플리케이션 초기화
app = Flask(__name__, template_folder='templates')
# Cross-Origin:  웹 브라우저에서 실행 중인 스크립트가
# 한 출처(origin)에서 불러온 웹 페이지의 리소스를 다른 출처에서 불러올 수 있도록 허용하는 기술.
CORS(app)

# 날씨 정보를 가져오는 라우트

url = "https://www.weather.go.kr/w/rss/dfs/hr1-forecast.do?zone=1162058500"

res = req.urlopen(url)

# 파싱하기
soup = BeautifulSoup(res, 'xml')
temps = soup.find_all('temp')
wfKors = soup.find_all('wfKor')
wfEns = soup.find_all('wfEn')
pops = soup.find_all('pop')
rehs = soup.find_all('reh')

temp = temps[0].string
wfKor = wfKors[0].string
wfEn = wfEns[0].string.replace(" ", "").replace("/", "")
pop = pops[0].string
reh = rehs[0].string

data = {
    'temp': temp,
    'wfKor' : wfKor,
    'wfEn' : wfEn,
    'pop' : pop,
    'reh' : reh
}

app = Blueprint('gw1', __name__, url_prefix='/gw1')

@app.route('/weathers', methods=['GET'])
def weather():
    return data