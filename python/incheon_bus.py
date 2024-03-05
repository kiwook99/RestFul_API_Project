# -*- coding: utf-8 -*-
import pandas as pd
from flask import Flask, Blueprint, jsonify, request
from flask_cors import CORS


app = Flask(__name__)
app.debug = True

CORS(app)

app = Blueprint('in7', __name__, url_prefix='/in7')

# 한글 설정
# plt.rcParams['font.family'] = 'Malgun Gothic'

df = pd.read_excel('static/data/인천광역시_시내버스.xlsx')

# 한 페이지당 아이템 개수
ITEMS_PER_PAGE = 30

# NaN 값을 0으로 대체
df = df.fillna(0)

# 의료기관 정보 추출
bus_info = df[['정류소명', '정류소번호', '권역', '행정동명', '위도', '경도']].to_dict(orient='records')


@app.route('/bus', methods=['GET'])
def bus():
    # 현재 페이지 번호 가져오기
    page = int(request.args.get('page', 1))

    # 페이지에 해당하는 데이터 가져오기
    start_idx = (page - 1) * ITEMS_PER_PAGE
    end_idx = start_idx + ITEMS_PER_PAGE
    page_data = bus_info[start_idx:end_idx]

    return jsonify(page_data)