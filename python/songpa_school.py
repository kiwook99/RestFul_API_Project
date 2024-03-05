import base64
from io import BytesIO
import warnings
import pandas as pd
import matplotlib.pyplot as plt
# import urllib.request as req
from flask import Flask, Blueprint, jsonify, send_file
from flask_cors import CORS

#app = Flask(__name__)
app = Blueprint('api_school', __name__, url_prefix='/api_school')
            # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
            # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
            # 세번째 인자 : 해당 앱의 공통 url

CORS(app)


@app.route("/school", methods=['GET'])
def school():

    warnings.filterwarnings("ignore", category=UserWarning, module="bs4")


    local = 'static/data/school_1.xlsx'

    localdata = pd.read_excel(local)
    df = pd.DataFrame(localdata)


    grade = df.groupby('학교종류명').size()
    found = df.groupby('설립구분').size()
    sex = df.groupby('남녀공학구분명').size()

    # 글씨 깨짐(한글로 )
    plt.rcParams['font.family'] ='Malgun Gothic'

    # 서브 플롯
    fig, axes = plt.subplots(nrows=1, ncols=3, figsize=(12, 5))  # 1 row, 2 columns

        # 학교종류를 선 그래프로 표시
    custom_order = ['초등학교', '평생학교 + 특수학교', '중학교', '고등학교']
    grade = grade.reindex(custom_order)
    w = {"edgecolor": "black", "linewidth":2, "width":0.5} # 테두리
    grade.plot.pie(autopct='%0.1f%%', wedgeprops=w, pctdistance=0.75, textprops={'fontsize': 10, 'fontweight': 'bold'}, ax=axes[0])
    axes[0].set_title('송파구 학교수', size=15, fontweight='bold', pad=15)

        # 설립구분를 막대 그래프로 표시

    found.plot(kind='bar', alpha=0.7, ax=axes[1], color="#F5C7B8")
    axes[1].set_title('설립구분별 학교수', size=15, fontweight='bold', pad=15)
    axes[1].set_xticklabels(axes[1].get_xticklabels(), rotation=360)  # x 축 레이블 회전

        # 설립구분 값 표시
    for f, founds in enumerate(found):                                                                               #cf8360
        axes[1].text(f, founds - 20.75, f'{founds:,}', ha='center', va='bottom', fontsize=18, fontweight='bold', color='#cf8360')



        # 남녀공학구분명를 막대 그래프로 표시
    sex.plot(kind='bar', alpha=0.7, ax=axes[2], color="#FEFEFE")
    axes[2].set_title('남녀공학별 학교수', size=15, fontweight='bold', pad=15)
    axes[2].set_xticklabels(axes[2].get_xticklabels(), rotation=360)  # x 축 레이블 회전

        # 설립구분 값 표시
    for s, sexs in enumerate(sex):
        axes[2].text(s, sexs - 20.75, f'{sexs:,}', ha='center', va='bottom', fontsize=15, fontweight='bold', color='#8AAAE5')


        # 배경색
    axes[1].set_facecolor('#cf8360')
    axes[2].set_facecolor('#8AAAE5')

    #plt.show()

    # 이미지를 인코딩한 후 보내는 방법(화질 good)
    img = BytesIO()
    plt.savefig(img, format='png')
    img.seek(0)
    plt.close()
    # 이미지를 base64로 인코딩
    img_str = base64.b64encode(img.read()).decode('utf-8')

    return jsonify([img_str])

#if __name__ == "__main__":
#    app.run(host='0.0.0.0', port=5001, debug=True)