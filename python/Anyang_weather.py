from flask import Blueprint, Flask, render_template,jsonify
from bs4 import BeautifulSoup
from urllib import request as req
from flask_cors import CORS


#app = Flask(__name__)
app = Blueprint('weather_api', __name__, url_prefix='/weather_api')
                    # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
                    # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
                    # 세번째 인자 : 해당 앱의 공통 url

CORS(app)

@app.route('/weather')
def get_current_weather():
    # 기상청 현재 날씨 RSS 주소
    rss_url = 'https://www.weather.go.kr/w/rss/dfs/hr1-forecast.do?zone=4117361000'
    
    # 데이타 가져오기
    res = req.urlopen(rss_url)
    
    # 필요 데이타 추출하기
    soup = BeautifulSoup(res, 'html.parser')
    
    
    # 현재 시간, 날씨 상태, 최고/최저 온도 추출
    pub_date_tag = soup.find('pubdate')
    wf_tag = soup.find('wfkor')
    temp_tag = soup.find('temp')

    # None 체크 후 텍스트 추출
    pub_date = pub_date_tag.text.strip() if pub_date_tag else "시간 정보 없음"
    wf_kor = wf_tag.text.strip() if wf_tag else "날씨 정보 없음"
    temp = temp_tag.text.strip() if temp_tag else "온도 정보 없음"
    data = {
        "pub_date" : pub_date,
        "wf_kor" : wf_kor,
        "temp" : temp
    }

    return jsonify([pub_date,wf_kor,temp])


def index():
    # 현재 날씨 정보 가져오기
    weather_info = get_current_weather()
    return render_template('index1.html', weather_info=weather_info)

# if __name__ == "__main__":
#     app.run(port=5002, debug=False)
