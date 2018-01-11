# _*_ coding: utf-8 _*_


import numpy as np
import cv2
import ngRequest
import json

#https://prateekvjoshi.com/2016/03/01/how-to-read-an-image-from-a-url-in-opencv-python/
def getCaptchaImge():
    urlStr = 'https://kyfw.12306.cn/passport/captcha/captcha-image?login_site=E&module=login&rand=sjrand'
    # response = session.get(urlStr, headers=headers)
    response = ngRequest.getRequest(urlStr)
    if response.status_code == 200:
        fileName = '/Users/liaonaigang/Desktop/LazyTicket/Ticket Python/captchaImage/catchpaImage.png'
        arr = np.asarray(bytearray(response.content), dtype=np.uint8)
        img = cv2.imdecode(arr, cv2.IMREAD_COLOR)  # 'load it as it is'
        cv2.imwrite(fileName,img)
    return response.status_code



# {"result_message":"系统维护时间","result_code":-4}
def captchaCheck(positions):
    data = {
        "answer": positions,
        "login_site": "E",
        "rand": "sjrand"
    }
    url = "https://kyfw.12306.cn/passport/captcha/captcha-check"
    return ngRequest.postRequest(url,data)

def login():
    data = {
        "username": 'liaonaigang',
        "password": "liaonai620",
        "appid": "otn"
    }
    url = 'https://kyfw.12306.cn/passport/web/login'
    return ngRequest.postRequest(url,data)

def uamtk():
    data = {
        "appid": "otn"
    }
    url = 'https://kyfw.12306.cn/passport/web/auth/uamtk'
    return ngRequest.postRequest(url,data)

