# -*- coding: utf-8 -*-
import pandas as pd
from flask import Flask, Blueprint, jsonify
from flask_cors import CORS

app=Flask(__name__)
app.debug=True

CORS(app)

app = Blueprint('in5', __name__, url_prefix='/in5')

# 한글 설정
# plt.rcParams['font.family'] = 'Malgun Gothic'

df = pd.read_excel('static/data/[오픈데이터]_공영주차장_정보.xlsx')
# print(df)

# name = df['name']
# # print(name)
# x = df['lat']
# # print(x)
# y = df['long']
# # print(y)
# 주차장 정보 추출
parking_info = df[['name', 'latx', 'longy']].to_dict(orient='records')

@app.route('/parking', methods=['GET'])
def parking():
    return jsonify(parking_info)