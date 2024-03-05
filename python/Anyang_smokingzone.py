from flask import Flask, Blueprint, jsonify
from urllib import request as req
from bs4 import BeautifulSoup
import json
from flask_cors import CORS


# Flask 애플리케이션을 생성합니다.
app = Flask(__name__)

# Smoking Zone API에 대한 Blueprint를 생성합니다.
app = Blueprint('smokingzone_api', __name__, url_prefix='/smokingzone_api')

CORS(app)
# Smoking Zone 정보를 반환하는 엔드포인트를 정의합니다.
@app.route('/smokingzone', methods=['GET'])
def get_smoking_zone():
    api = 'https://api.odcloud.kr/api/15060926/v1/uddi:2fbc5375-a15d-4907-9482-ecc12da41af2?page=1&perPage=10&returnType=xml&serviceKey=fKOC%2FCNosICC4Nz0vNFoh882R8cHpam%2B7OXCFrhnjRIp96YeElUAN4DerTStjfIkXhf3Zy6%2F3zLfA%2BEbT5laiQ%3D%3D'
    url = api
    res = req.urlopen(url)
    data = res.read().decode('utf-8')  # 응답 텍스트를 추출하고 UTF-8로 디코딩

    data_dict = json.loads(data)

    return jsonify(data_dict)

# if __name__ == "__main__":
#     app.run(port=5002, debug=True)



