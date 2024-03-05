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

app = Blueprint('gwangmyeong_school', __name__, url_prefix='/gwangmyeong_school')

CORS(app)



# 한글 폰트 설정
font_path = "C:/Windows/Fonts/malgun.ttf"  # 사용하는 환경에 맞게 경로를 설정해주세요
font_name = font_manager.FontProperties(fname=font_path).get_name()
rc('font', family=font_name)


# 엑셀 파일 및 시트 이름 지정
file_path = 'static/data/gmschool.xls'
sheet_name = '초중고등학교 현황'

# 엑셀 파일의 지정된 시트 읽기
df = pd.read_excel(file_path, sheet_name=sheet_name)

# 학교구분명 열에서 각 학교 유형의 개수 추출
school_type_counts = df['학교구분명'].value_counts()

# 결과를 JSON 형식으로 반환
result = {
    'school_type_counts': school_type_counts.to_dict()
}

@app.route('/gwangmyeong_school', methods=['GET'])
def get_school_data():
    return jsonify(result)

#if __name__ == '__main__':
#    app.run(host='0.0.0.0', port=5001, debug=True)