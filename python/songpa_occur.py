from flask import Flask, Blueprint, jsonify
from flask_cors import CORS
from urllib import request as req
from bs4 import BeautifulSoup

#app = Flask(__name__)

app = Blueprint('api_occur', __name__, url_prefix='/api_occur')
            # 첫번째 인자 : url_for()에서 해당앱을 찾기 위한 키워드
            # 두번째 인자 : 정적파일과 템플릿 위치를 추적하기 위해
            # 세번째 인자 : 해당 앱의 공통 url

CORS(app)

@app.route("/occur", methods=['GET'])
def occur():

    # 인증키 : 446573696f70617231313146776f6652
    API_occur = "http://openapi.seoul.go.kr:8088/446573696f70617231313146776f6652/xml/AccInfo/1/15/"

    res = req.urlopen(API_occur)

    soup = BeautifulSoup(res, 'html.parser')

    occur_list = []
    # 모든 row 태그 반복
    for rows in soup.find_all('row'):
        # 각각의 row 태그에 대한 데이터 추출
        row_data = {}
        for rows_child in rows.children:
            if rows_child.name is not None:
                row_data[rows_child.name] = rows_child.text
        occur_list.append(row_data)


    return jsonify(occur_list)


#if __name__ == "__main__":
#    app.run(host='0.0.0.0', port=5001, debug=True)


'''
    accident_list = []
    # 모든 row 태그 반복
    for rows in soup.find_all('row'):
        # 각각의 row 태그에 대한 데이터 추출
        row_data = {}
        for rows_child in rows.children:
            if rows_child.name is not None:
                row_data[rows_child.name] = rows_child.text
        accident_list.append(row_data)

        #print(accident_list);
        return jsonify(accident_list)
'''

'''
    #date = soup.select('body data:first-child>occr_date')
    #occr_time  = soup.select('body data:first-child>occr_time')
    #info = soup.select('body data:first-child>acc_info')

    date = soup.select('occr_date')
    occr_time = soup.select('occr_time')
    info = soup.select('acc_info')


    result_occur = []
    for i in range(len(date)):
        result_occur.append({
            'occr_time' : occr_time[i].text,
            'info' : info[i].text,
        })
    print(result_occur)
    return jsonify(result_occur)
'''