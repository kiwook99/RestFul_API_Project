from flask import Flask, Blueprint, jsonify, request
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup




#app = Flask(__name__)
app = Blueprint('api_parking', __name__, url_prefix='/api_parking')
            # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
            # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
            # 세번째 인자 : 해당 앱의 공통 url


CORS(app)

# 한 페이지당 아이템 개수
ITEMS_PER_PAGE = 30


@app.route("/parking", methods=['GET'])
def parking():
    API_parking = "http://openapi.seoul.go.kr:8088/70726b596a70617234324a684e444c/xml/TbOpendataFixedcctvSP/1/148/"

    res = req.urlopen(API_parking)

    soup = BeautifulSoup(res, 'html.parser')

    # 현재 페이지 번호 가져오기
    page = int(request.args.get('page', 1))

    parking_list = []
    # 모든 <row> 태그에 대해 반복
    for rows in soup.find_all('row'):
        # 각각의 <row> 태그에 대한 데이터 추출
        row_data = {}
        for rows_child in rows.children:
            if rows_child.name is not None:
                row_data[rows_child.name] = rows_child.text
        parking_list.append(row_data)

    start_idx = (page - 1) * ITEMS_PER_PAGE
    end_idx = start_idx + ITEMS_PER_PAGE
    page_data = parking_list[start_idx:end_idx]


    return jsonify(page_data)



#if __name__ == "__main__":
#    app.run(host='0.0.0.0', port=5001, debug=True)


