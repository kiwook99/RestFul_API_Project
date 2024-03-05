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

app = Blueprint('gwangmyeong_parking', __name__, url_prefix='/gwangmyeong_parking')

CORS(app)



# 한글 폰트 설정
font_path = "C:/Windows/Fonts/malgun.ttf"  # 사용하는 환경에 맞게 경로를 설정해주세요
font_name = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font_name)


url = 'https://data.gm.go.kr/openapi/Elctychrgstatn'
response = requests.get(url, verify=False)

# BeautifulSoup을 사용하여 HTML 파싱
soup = BeautifulSoup(response.text, 'html.parser')

# CHRGSTATN_NM, CHARGER_TYPE_NM, REFINE_LOTNO_ADDR 추출
chrgstatn_nm_list = soup.select('CHRGSTATN_NM')
charger_type_nm_list = soup.select('CHARGER_TYPE_NM')
refine_lotno_addr_list = soup.select('REFINE_LOTNO_ADDR')

charging_stations = []

for chrgstatn_nm, charger_type_nm, refine_lotno_addr in zip(chrgstatn_nm_list, charger_type_nm_list, refine_lotno_addr_list):
    charging_station = {
        '충전소명': chrgstatn_nm.text,
        '충전기 타입': charger_type_nm.text,
        '주소': refine_lotno_addr.text
    }
    charging_stations.append(charging_station)

@app.route('/gwangmyeong_parking', methods=['GET'])
def get_charging_stations():
    return charging_stations


#if __name__ == '__main__':
#    app.run(host='0.0.0.0', port=5001, debug=True)