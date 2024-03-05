# -*- coding: utf-8 -*-
import pandas as pd
import matplotlib.pyplot as plt
from io import BytesIO
import base64
from flask import Flask, Blueprint, jsonify
from flask_cors import CORS


app=Flask(__name__)
app.debug=True

CORS(app)

app = Blueprint('in4', __name__, url_prefix='/in4')

# 한글 설정
plt.rcParams['font.family'] = 'Malgun Gothic'

df = pd.read_excel('static/data/자동차등록.xlsx', index_col='연도')

# 그래프를 설정
bar_width = 0.3  # 각 막대의 너비를 설정
bar_gap = 0.1    # 막대 사이의 간격을 설정
index = range(len(df.index))  # x 축 인덱스를 설정

# 그림의 크기를 설정
plt.figure(figsize=(19, 4), facecolor='aliceblue')

# 배경색 추가
plt.axhspan(0, df['1인당 자동차 등록대수(대)'].max()*1.2, facecolor='#edf6e8', alpha=0.5)

    # x축 눈금 위치 계산
bar_centers = [i + (len(df.columns)-1) * (bar_width + bar_gap) / 2 for i in index]

for i, category in enumerate(df.columns):
    if category == '1인당 자동차 등록대수(대)':
        color = '#12c996'
        plt.bar(index, df[category], width=bar_width, label=category, align='center', color=color,  bottom=0)
    else:
        color = 'gray'
        plt.bar(index, df[category], width=bar_width, label=category, align='center', color=color,  bottom=0)
        
    # 각 그래프에 대한 주석 텍스트 추가
for x, y_total in zip(index, df['1인당 자동차 등록대수(대)']):
    # 등록대수(대) 주석
    plt.text(x, y_total*0.5, '{:,.2f}'.format(y_total), ha='center', va='center', fontsize=12)



# y축 범위 설정
plt.ylim(0, df['1인당 자동차 등록대수(대)'].max()*1.2)  # 최대값의 1.2배까지 표시

plt.title('인천광역시 1인당 자동차 등록대수(대)', fontsize=18)
plt.xticks(bar_centers, df.index)  # x 축 눈금 레이블을 설정
# 범례를 그래프 밖으로 이동
plt.legend(loc='upper center', bbox_to_anchor=(-0.085, 0.65), fancybox=True, shadow=True)
# y축 눈금 표시 비활성화
plt.yticks([])

# 그래프를 이미지로 변환
img = BytesIO()
plt.savefig(img, format='png')
img.seek(0) 
plt.close()

# 이미지를 base64로 인코딩
img_str = base64.b64encode(img.read()).decode('utf-8')


@app.route('/car', methods=['GET'])
def car():
    return jsonify([img_str])