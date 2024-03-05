from flask import Flask, Blueprint, send_file
from flask_cors import CORS
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib

# 애플리케이션 초기화
app = Flask(__name__, template_folder='templates')
# Cross-Origin:  웹 브라우저에서 실행 중인 스크립트가
# 한 출처(origin)에서 불러온 웹 페이지의 리소스를 다른 출처에서 불러올 수 있도록 허용하는 기술.
CORS(app)

# 인구 통계 정보를 가져오는 라우트
# http://openapi.seoul.go.kr:8088/{API KEY}/{파일형식}/SPOP_LOCAL_RESD_JACHI/{시작인덱스}/{종료인덱스}/{기준일}
df1 = pd.read_csv('http://openapi.seoul.go.kr:8088/6d52694e5164676432376f4e77596b/xls/SPOP_LOCAL_RESD_JACHI/21/21/20180301', sep='\t')
df2 = pd.read_csv('http://openapi.seoul.go.kr:8088/6d52694e5164676432376f4e77596b/xls/SPOP_LOCAL_RESD_JACHI/21/21/20190301', sep='\t')
df3 = pd.read_csv('http://openapi.seoul.go.kr:8088/6d52694e5164676432376f4e77596b/xls/SPOP_LOCAL_RESD_JACHI/21/21/20200301', sep='\t')
df4 = pd.read_csv('http://openapi.seoul.go.kr:8088/6d52694e5164676432376f4e77596b/xls/SPOP_LOCAL_RESD_JACHI/21/21/20210301', sep='\t')
df5 = pd.read_csv('http://openapi.seoul.go.kr:8088/6d52694e5164676432376f4e77596b/xls/SPOP_LOCAL_RESD_JACHI/21/21/20220301', sep='\t')

df = pd.concat([df1, df2, df3, df4, df5], ignore_index=True)
df['STDR_DE_ID'] = pd.to_datetime(df['STDR_DE_ID'], format='%Y%m%d')  # 날짜 형식으로 변환
df['YEAR'] = df['STDR_DE_ID'].dt.year
sum_of_male = df.iloc[:, 4:18].sum(axis=1)
sum_of_female = df.iloc[:, 19:32].sum(axis=1)

matplotlib.use('Agg')
plt.rcParams['font.family'] = 'Malgun Gothic'
fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(15, 6))  # 행 1, 열 2로 변경

axes[0].bar(df['YEAR'], df['TOT_LVPOP_CO'], color='orange', alpha=0.7, label='전체 인구수')
axes[0].set_xlabel('날짜')
axes[0].set_ylabel('인구수')
axes[0].legend()

axes[1].bar(df['YEAR'], df['TOT_LVPOP_CO'], label='남성 인구수')
axes[1].bar(df['YEAR'], sum_of_female, color='pink', label='여성 인구수')
axes[1].set_xlabel('날짜')
axes[1].set_ylabel('인구수')
axes[1].legend()
plt.tight_layout()

image_path = 'static/plot.png'  # static 폴더에 저장
plt.savefig(image_path)
plt.close()


app = Blueprint('gw2', __name__, url_prefix='/gw2')

@app.route('/people', methods=['GET'])
def people():
    return send_file(image_path)
