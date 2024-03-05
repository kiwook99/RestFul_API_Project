# -*- coding: utf-8 -*-
import pandas as pd
from flask import Flask, Blueprint, jsonify
from flask_cors import CORS

app=Flask(__name__)
app.debug=True

CORS(app)

app = Blueprint('in6', __name__, url_prefix='/in6')

# 한글 설정
# plt.rcParams['font.family'] = 'Malgun Gothic'

df = pd.read_excel('static/data/도서관및서점정보.xlsx')
# print(df)

# name = df['name']
# # print(name)
# x = df['lat']
# # print(x)
# y = df['long']
# # print(y)
# 주차장 정보 추출
books_info = df[['precinct', 'name', 'addr', 'x','y']].to_dict(orient='records')

@app.route('/books', methods=['GET'])
def parking():
    return jsonify(books_info)