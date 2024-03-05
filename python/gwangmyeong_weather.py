from flask import Flask, request, Response, jsonify, send_file
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup

import os, requests
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc
import json

from bs4 import BeautifulSoup
from urllib import request as req

from flask import Flask, Blueprint
from flask_cors import CORS

# app = Flask(__name__, template_folder='templates')

app = Blueprint('gwangmyeong_weather', __name__, url_prefix='/gwangmyeong_weather')

CORS(app)



# 한글 폰트 설정
font_path = "C:/Windows/Fonts/malgun.ttf"  # 사용하는 환경에 맞게 경로를 설정해주세요
font_name = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font_name)


url = "https://www.weather.go.kr/w/rss/dfs/hr1-forecast.do?zone=4121055000"
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
    'wfKor': wfKor,
    'wfEn': wfEn,
    'pop': pop,
    'reh': reh
}

@app.route('/gwangmyeong_weather', methods=['GET']) 
def weather():   
    return data



#if __name__ == '__main__':
#    app.run(host='0.0.0.0', port=5001, debug=True)