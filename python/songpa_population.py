import base64
from io import BytesIO
import warnings
import matplotlib
import pandas as pd
import matplotlib.pyplot as plt
# import urllib.request as req
from flask import Flask, Blueprint, jsonify, send_file
from flask_cors import CORS

app = Flask(__name__)
app = Blueprint('api_population', __name__, url_prefix='/api_population')
            # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
            # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
            # 세번째 인자 : 해당 앱의 공통 url

CORS(app)


matplotlib.use('Agg')
warnings.filterwarnings("ignore", category=UserWarning, module="bs4")

local = 'static/data/population_1.xlsx'

localdata = pd.read_excel(local)
df = pd.DataFrame(localdata)


population = df['total']
year = df['year']
boy =  df['boy']
girl = df['girl']

# 글씨 깨짐(한글로 )
plt.rcParams['font.family'] ='Malgun Gothic'


# 총 인구를 선 그래프로 표시
plt.plot(year, population, 'o-', color='green', label='총 인구')

# 남자 인구를 막대 그래프로 표시
plt.bar(year - 0.2, boy, width=0.4, alpha=0.7, label='남자', color='blue')

# 여자 인구를 막대 그래프로 표시
plt.bar(year + 0.2, girl, width=0.4, alpha=0.7, label='여자', color='pink')



plt.xticks(year.astype(int))
# plt.xticks(year.astype(int) : x축의 눈금을 정수로 변환하여 소수점을 제거하는 역할


# 총 인구수 max 값
i = 1
population = population[i]
plt.text(year[i], population/1.090, f'{population:,}', ha='center', va='bottom', size=13, fontweight='bold', color='#2D2926')

# 남여 값 표시
for b in range(len(boy)):
    boys = boy[b]
    plt.text(year[b]-0.2, boys/2, f'{boys:,}', ha='center', va='center', size=5.5, fontweight='bold', color='white' )
    
for g in range(len(girl)):
    girls = girl[g]
    plt.text(year[g] + 0.2, girls/2, f'{girls:,}', ha='center', va='center', size=5.5, fontweight='bold', color="#6A7BA2")


# x, y축 제목
plt.xlabel('년도')
plt.ylabel('인구수(명)')

# 배경색
ax = plt.gca()
ax.set_facecolor('#FCF6F5')

# 범례
plt.legend(loc=(0.65, 1.05), ncols=3, fontsize=6)

#plt.title('Annual population of Songpa-gu', size= 30, fontweight='bold', pad=15)
plt.title('송파구 인구수', size= 15, fontweight='bold', pad=15)
#plt.show()

# 이미지 저장 후 보내는 방법(화질 bad)
#image_path = 'static/image/population.png' # 이미지 저장
#plt.savefig(image_path)
#plt.close()
#return send_file(image_path)

# 이미지를 인코딩한 후 보내는 방법(화질 good)
img = BytesIO()
plt.savefig(img, format='png')
img.seek(0)
plt.close()
# 이미지를 base64로 인코딩
img_str = base64.b64encode(img.read()).decode('utf-8')


@app.route("/population", methods=['GET'])
def population():
    return jsonify([img_str])


#if __name__ == "__main__":
#    app.run(host='0.0.0.0', port=5001, debug=True)

    '''
    img = BytesIO()
    plt.savefig(img, format='png')
    img.seek(0)
    plt.close()
    # 이미지를 base64로 인코딩
    img_str = base64.b64encode(img.read()).decode('utf-8')

    return jsonify([img_str])
    '''