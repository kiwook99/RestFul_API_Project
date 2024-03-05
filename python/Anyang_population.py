import pandas as pd
import matplotlib.pyplot as plt
from flask_cors import CORS
from flask import Blueprint, jsonify ,Flask
import base64
import matplotlib
from io import BytesIO

app = Flask(__name__)
app = Blueprint('population_api', __name__, url_prefix='/population_api')
                    # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
                    # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
                    # 세번째 인자 : 해당 앱의 공통 url

CORS(app)
@app.route('/population', methods=['GET'])
def draw_graph():
    df = pd.read_excel('static/data/population.xlsx')

    df['year'] = df['연도']
    df['year'] = df['year'].astype(int)                  
    population = df['총 거주자수']
    df['male'] = df['남자 인구수'].astype(int)
    df['female'] = df['여자 인구수'].astype(int)

    matplotlib.use('Agg')
    # 글씨 깨짐(한글)
    plt.rcParams['font.family'] ='Malgun Gothic'


    plt.figure(figsize=(12, 6))


    # 총 거주자수는 점 그래프로
    plt.plot(df['year'], population, marker='o', label='총 거주자수')

    # 남자, 여자 인구수는 막대 그래프로
    plt.bar(df['year'] - 0.2, df['male'], width=0.4, label='남자 인구수', alpha=0.7, color='navy')

    plt.bar(df['year'] + 0.2, df['female'], width=0.4, label='여자 인구수', alpha=0.7, color='red')

    plt.xticks(df['year'].astype(int))
    # plt.xticks(year.astype(int) : x축의 눈금을 정수로 변환하여 소수점을 제거하는 역할

    plt.title('안양시 거주자 그래프\n(연도별 총 거주자수, 남자 인구수, 여자 인구수)')
    plt.xlabel('연도')
    plt.ylabel('인구수')
    plt.xticks(df['year'])  # 연도 명시
    plt.legend()
    plt.grid(True)

    # 이미지를 인코딩한 후 보내는 방법(화질 good)
    img = BytesIO()
    plt.savefig(img, format='png')
    img.seek(0)
    plt.close()

    # 이미지를 base64로 인코딩
    img_str = base64.b64encode(img.read()).decode('utf-8')


    # 그래프 그리기
    # @app.route('/population', methods=['GET'])
    # def draw_graph():
    return jsonify([img_str])

# if __name__ == "__main__":
#     app.run(port=5002, debug=True)