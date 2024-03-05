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

app = Blueprint('in2', __name__, url_prefix='/in2')

# 한글 설정
plt.rcParams['font.family'] = 'Malgun Gothic'

df = pd.read_excel('static/data/인구추이_1.xlsx', index_col='연도')

# 그래프를 설정
bar_width = 0.3  # 각 막대의 너비를 설정
bar_gap = 0.1    # 막대 사이의 간격을 설정
index = range(len(df.index))  # x 축 인덱스를 설정

# 그림의 크기를 설정
plt.figure(figsize=(19, 4), facecolor='aliceblue')

# 배경색 추가
plt.axhspan(0, df['총인구(명)'].max()*1.2, facecolor='#d7f9f9', alpha=0.5)

    # x축 눈금 위치 계산
bar_centers = [i + (len(df.columns)-3) * (bar_width + bar_gap) / 2 for i in index]

for i, category in enumerate(df.columns):
    if category == '총인구(명)':
        # 총인구은 라인 그래프로 표시
        plt.plot(index, df[category], marker='o', label=category, color='black')  # black 색상으로 설정
        # 총인구에 대한 y 축 포맷 설정
        plt.ticklabel_format(axis='y', style='plain')  # 지수 표현 방지
    else:
        # 내국인과 외국인은 각각 다른 색으로 막대 그래프로 겹쳐서 표시
        if category == '내국인계(명)':
            color = '#20a2e3'
            plt.bar(index, df[category]*0.95, width=bar_width, label=category, align='center', color=color,  bottom=0)
        elif category == '외국인계(명)':
            color = '#12c996'
            plt.bar(index, df[category] *4, width=bar_width, label=category, align='center', color=color,  bottom=0)
        else:
            color = 'gray'
            plt.bar(index, df[category]*8/9, width=bar_width, label=category, align='center', color=color,  bottom=0)
        
    # 각 그래프에 대한 주석 텍스트 추가
for x, y_total, y_korean, y_foreign in zip(index, df['총인구(명)'], df['내국인계(명)'], df['외국인계(명)']):
    # 총인구(명) 주석
    plt.text(x, y_total*1.05, '{:,.0f}'.format(y_total), ha='center', va='center', fontsize=12)
    # 내국인계(명) 주석
    plt.text(x, y_korean/2, '{:,.0f}'.format(y_korean), ha='center', va='center', fontsize=12)
    # 외국인계(명) 주석
    plt.text(x, y_foreign*1.5, '{:,.0f}'.format(y_foreign), ha='center', va='center', fontsize=12)


# y축 범위 설정
plt.ylim(0, df['총인구(명)'].max() * 1.2)  # 최대값의 1.2배까지 표시

plt.title('인천광역시 인구현황(명)', fontsize=18)
plt.xticks(bar_centers, df.index)  # x 축 눈금 레이블을 설정
# 범례를 그래프 밖으로 이동
plt.legend(loc='upper center', bbox_to_anchor=(-0.07, 0.65), fancybox=True, shadow=True)
# y축 눈금 표시 비활성화
plt.yticks([])

# 그래프를 이미지로 변환
img = BytesIO()
plt.savefig(img, format='png')
img.seek(0)
plt.close()

# 이미지를 base64로 인코딩
img_str = base64.b64encode(img.read()).decode('utf-8')

@app.route('/mans', methods=['GET'])
def man():
    return jsonify([img_str])