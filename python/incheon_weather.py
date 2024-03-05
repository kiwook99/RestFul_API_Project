# -*- coding: utf-8 -*-
from bs4 import BeautifulSoup
from urllib import request as req
from flask import Flask, jsonify,Blueprint
from flask_cors import CORS

app = Flask(__name__)
app.debug = True
app.config['JSON_AS_ASCII'] = False

CORS(app)

"""
CORS : Cross Origin Resources Sharing
---------------------------------------------
자바스크립트(같은 도메인에서만 사용가능)를 사용한 api 등의 
리소스 호출시 동일 출처(같은 호스트네임)가 아니더라도 정상적으로 사용 

자바스크립트 : 동일출처정책(Same-Origin Policy) 외부서버에서 온 요청을 차단
"""

API="https://www.weather.go.kr/w/rss/dfs/hr1-forecast.do?zone=2823754000"
res = req.urlopen(API)

soup = BeautifulSoup(res, 'xml')

hour = soup.select('body data:first-child>hour')
temp = soup.select('body data:first-child>temp')
wfKor = soup.select('body data:first-child>wfKor')
pop = soup.select('body data:first-child>pop')

for i in range(len(hour)):

    hour = hour[i].text
    temp = temp[i].text
    wfKor = wfKor[i].text
    pop = pop[i].text

    if(wfKor == "맑음"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB01.png";
    elif(wfKor == "구름 많음"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB03.png";
    elif(wfKor == "흐림"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB04.png";
    elif(wfKor == "비"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB08.png";
    elif(wfKor == "비/눈"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB13.png";
    elif(wfKor == "눈"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB11.png";
    elif(wfKor == "소나기"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB07.png";
    elif(wfKor == "빗방울"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB20.png";
    elif(wfKor == "빗방울/눈날림"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB22.png";
    elif(wfKor == "눈날림"):
        icon = "https://www.weather.go.kr/home/images/icon/NW/NB21.png";


app = Blueprint('in1', __name__, url_prefix='/in1')

@app.route('/weathers', methods=['GET'])
def weather():
    return jsonify([hour,temp,wfKor,pop,icon])

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5001)