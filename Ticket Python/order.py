# _*_ coding: utf-8 _*_

import ngRequest



def checkUser():
    data = {
        "_json_att": ""
    }
    url = 'https://kyfw.12306.cn/otn/login/checkUser'
    return ngRequest.postRequest(url, data)