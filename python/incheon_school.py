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

app = Blueprint('in3', __name__, url_prefix='/in3')

# 한글 설정
plt.rcParams['font.family'] = 'Malgun Gothic'

df = pd.read_excel('static/data/학교및학생수.xlsx', index_col='연도')

# 그래프를 설정
bar_width = 0.3  # 각 막대의 너비를 설정
bar_gap = 0.1    # 막대 사이의 간격을 설정
index = range(len(df.index))  # x 축 인덱스를 설정

# 그림의 크기를 설정
plt.figure(figsize=(19, 4), facecolor='aliceblue')

# 배경색 추가
plt.axhspan(0, df['학교수(교)'].max(), facecolor='#c3dcf3', alpha=0.5)

    # x축 눈금 위치 계산
bar_centers = [i + (len(df.columns)-2) * (bar_width + bar_gap) / 2 for i in index]

for i, category in enumerate(df.columns):
    if category == '학교수(교)':
        # 학교수은 라인 그래프로 표시
        plt.plot(index, df[category]*0.88, marker='o', label=category, color='black')  # black 색상으로 설정
        # 학교수에 대한 y 축 포맷 설정
        plt.ticklabel_format(axis='y', style='plain')  # 지수 표현 방지
    else:
        # 학생수 막대 그래프로  표시
        if category == '학생수(명)':
            color = '#20a2e3'
            plt.bar(index, df[category]/500, width=bar_width, label=category, align='center', color=color,  bottom=0)
        else:
            color = 'gray'
            plt.bar(index, df[category]*8/9, width=bar_width, label=category, align='center', color=color,  bottom=0)
        
    # 각 그래프에 대한 주석 텍스트 추가
for x, y_total, y_korean in zip(index, df['학교수(교)'], df['학생수(명)']):
    # 학교수(교) 주석
    plt.text(x, y_total*0.93, '{:,.0f}'.format(y_total), ha='center', va='center', fontsize=12)
    # 학생수(명) 주석
    plt.text(x, y_korean/1000, '{:,.0f}'.format(y_korean), ha='center', va='center', fontsize=12)


# y축 범위 설정
plt.ylim(0, df['학교수(교)'].max())  # 최대값의 1.2배까지 표시

plt.title('인천광역시 학교 및 학생 수(교,명)', fontsize=18)
plt.xticks(bar_centers, df.index)  # x 축 눈금 레이블을 설정
# 범례를 그래프 밖으로 이동
plt.legend(loc='upper center', bbox_to_anchor=(-0.07, 0.65), fancybox=True, shadow=True)
# y축 눈금 표시 비활성화
plt.yticks([])
# plt.show()

# 그래프를 이미지로 변환
img = BytesIO()
plt.savefig(img, format='png')
img.seek(0) 
plt.close()

# 이미지를 base64로 인코딩
img_str = base64.b64encode(img.read()).decode('utf-8')

@app.route('/school', methods=['GET'])
def school():
    return jsonify([img_str])