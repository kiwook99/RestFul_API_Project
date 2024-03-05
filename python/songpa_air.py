from bs4 import BeautifulSoup
from urllib import request as req

from flask import Flask, Blueprint
from flask_cors import CORS

"""
<ListAirQualityByDistrictService>
    <list_total_count>1</list_total_count>
    <RESULT>
        <CODE>INFO-000</CODE>
        <MESSAGE>정상 처리되었습니다</MESSAGE>
    </RESULT>
    <row>
        <MSRDATE>202401050900</MSRDATE>
        <MSRADMCODE>111273</MSRADMCODE>
        <MSRSTENAME>송파구</MSRSTENAME>
        <MAXINDEX/>
        <GRADE/>
        <POLLUTANT/>
        <NITROGEN>0.057</NITROGEN>
        <OZONE>0.003</OZONE>
        <CARBON>0.7</CARBON>
        <SULFUROUS>0.003</SULFUROUS>
        <PM10>54</PM10>
        <PM25>37</PM25>
    </row>
</ListAirQualityByDistrictService>
"""
#print('PM10 Value: ' + pm10_value)
#print('PM25 Value: ' + pm25_value)


# app = Flask(__name__)
app = Blueprint('api_air', __name__, url_prefix='/api_air')
            # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
            # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
            # 세번째 인자 : 해당 앱의 공통 url
CORS(app)

# 526f4d6f6970617237305063747076 : 인증키
# 111273 : 송파구
API_air_quality = "http://openapi.seoul.go.kr:8088/526f4d6f6970617237305063747076/xml/ListAirQualityByDistrictService/1/5/111273"

res = req.urlopen(API_air_quality)

soup = BeautifulSoup(res, 'html.parser')

msrdate = soup.select('MSRDATE')
pm10_value = soup.select('PM10')
pm25_value = soup.select('PM25')

result_air_quality = []
for i in range(len(msrdate)):
    result_air_quality.append({
        'pm10' : pm10_value[i].text,
        'pm25' : pm25_value[i].text
    })


@app.route("/air", methods=['GET'])
def air():
    return result_air_quality
#print(result_air_quality)

    


#print(f'msrdate: {msrdate}')
#print(f'PM10 Value: {pm10_value}')
#print(f'PM25 Value: {pm25_value}')


#if __name__ == "__main__":
#    app.run(host='0.0.0.0', port=5001, debug=True)