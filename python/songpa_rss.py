from flask import Flask, Blueprint
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup




#app = Flask(__name__)
app = Blueprint('api_weather', __name__, url_prefix='/api_weather')
            # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
            # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
            # 세번째 인자 : 해당 앱의 공통 url


CORS(app)
#CORS(app, resources={r"/rss": {"origins": "http://localhost:8088"}})



@app.route("/weather", methods=['GET'])
def rss():
    API_weather = "https://www.weather.go.kr/w/rss/dfs/hr1-forecast.do?zone=1171051000"

    res = req.urlopen(API_weather)

    soup = BeautifulSoup(res, 'html.parser')

    hour = soup.select('body data:first-child>hour')
    temp = soup.select('body data:first-child>temp')
    wkfor = soup.select('body data:first-child>wfKor')


    result_weather = []
    for i in range(len(hour)):
        result_weather.append({
            'temp': temp[i].text,
            'wkfor': wkfor[i].text
        })
    



    #return jsonify({'weather': result_weather, 'air_quality': result_air_quality})


    #return jsonify(result) # 사용자가 json data를 내보내도록 제공하는 flask의 함수.
    return result_weather

#if __name__ == "__main__":
#    app.run(host='0.0.0.0', port=5001, debug=True)


