# -*- encoding: utf-8 -*-
from flask import Flask
from flask_cors import CORS

from incheon_weather import app as incheon_weather
from incheon_man import app as incheon_man
from incheon_school import app as incheon_school
from incheon_car import app as incheon_car
from incheon_parking import app as incheon_parking
from incheon_books import app as incheon_books
from incheon_bus import app as incheon_bus
from gwanak_weather import app as gwanak_weather
from gwanak_people import app as gwanak_people
from gwanak_schoolList import app as gwanak_schoolList
from gwanak_school import app as gwanak_school
from gwanak_news import app as gwanak_news
from gwanak_topis import app as gwanak_topis
from gwanak_parking import app as gwanak_parking
from gwanak_searchparking import app as gwanak_searchparking
from songpa_rss import app as api_weather
from songpa_air import app as api_air
from songpa_population import app as api_population
from songpa_school import app as api_school
from songpa_parking import app as api_parking
from songpa_occur import app as api_occur
from songpa_news import app as api_news
from Anyang_weather import app as weather_api
from Anyang_population import app as population_api
from Anyang_smokingzone import app as smokingzone_api
from gwangmyeong_weather import app as gwangmyeong_weather
from gwangmyeong_parking import app as gwangmyeong_parking
from gwangmyeong_school import app as gwangmyeong_school



app = Flask(__name__)
app.debug = True
app.config['JSON_AS_ASCII'] = False

CORS(app)

"""
CORS : Cross Origin Resources Sharing
---------------------------------------------
자바스크립트(같은 도메인에서만 사용가능)를 사용한 api 등의 
리소스 호출시 동일 출처(같은 호스트네임)가 아니더라도 정상적으로 사용 

자바스크립트 : 동일출처정책(Same-Origin Policy) 외부서버에서 온 요청을 차단
"""

app.register_blueprint(incheon_weather)
app.register_blueprint(incheon_man)
app.register_blueprint(incheon_school)
app.register_blueprint(incheon_car)
app.register_blueprint(incheon_parking)
app.register_blueprint(incheon_books)
app.register_blueprint(incheon_bus)
app.register_blueprint(gwanak_weather)
app.register_blueprint(gwanak_people)
app.register_blueprint(gwanak_schoolList)
app.register_blueprint(gwanak_school)
app.register_blueprint(gwanak_news)
app.register_blueprint(gwanak_topis)
app.register_blueprint(gwanak_parking)
app.register_blueprint(gwanak_searchparking)
app.register_blueprint(api_weather)
app.register_blueprint(api_air)
app.register_blueprint(api_population)
app.register_blueprint(api_school)
app.register_blueprint(api_parking)
app.register_blueprint(api_occur)
app.register_blueprint(api_news)
app.register_blueprint(weather_api)
app.register_blueprint(population_api)
app.register_blueprint(smokingzone_api)
app.register_blueprint(gwangmyeong_weather)
app.register_blueprint(gwangmyeong_parking)
app.register_blueprint(gwangmyeong_school)

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5001)