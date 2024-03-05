from flask import Flask, send_file, Blueprint
from flask_cors import CORS
from urllib import request as req
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib


# 애플리케이션 초기화
app = Flask(__name__, template_folder='templates')
# Cross-Origin:  웹 브라우저에서 실행 중인 스크립트가
# 한 출처(origin)에서 불러온 웹 페이지의 리소스를 다른 출처에서 불러올 수 있도록 허용하는 기술.
CORS(app)

# 학교 정보를 시각화해주는 라우트
api = 'http://openapi.seoul.go.kr:8088/{key}/xml/neisSchoolInfo_ga/1/260/'
apikey = '4f7554547074657338357545716671'

url = api.format(key=apikey)
res = req.urlopen(url)

school = pd.read_csv('http://openapi.seoul.go.kr:8088/4f7554547074657338357545716671/xls/neisSchoolInfo_ga/1/260/',sep='\t', encoding='cp949')

temp = school[['SCHUL_KND_SC_NM','ATPT_OFCDC_SC_NM']]
temp1 = temp.groupby('SCHUL_KND_SC_NM').count()
count_by_category = school['HS_GNRL_BUSNS_SC_NM'].value_counts()
matplotlib.use('Agg')
plt.rcParams['font.family'] = 'Malgun Gothic'
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(15, 6))  # 행 1, 열 2로 변경

axes[0].bar(temp1.index, temp1['ATPT_OFCDC_SC_NM'], color='blue', alpha=0.7, label='전체 기관수')
axes[0].set_title('교육기관 분포')
axes[0].legend()

axes[1].bar(count_by_category.index, count_by_category, color=['skyblue', 'lightgreen', 'lightcoral'])
axes[1].set_title('교육기관 카테고리', fontsize=16)
axes[1].set_ylabel('개수', fontsize=14)
axes[1].set_facecolor('#f5f5f5')  # 배경색 변경
axes[1].legend()

image_path = 'static/plot2.png'  # static 폴더에 저장
plt.savefig(image_path)
plt.close()

app = Blueprint('gw4', __name__, url_prefix='/gw4')

@app.route('/school', methods=['GET'])
def school():
    return send_file(image_path)