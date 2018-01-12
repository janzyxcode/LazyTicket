# _*_ coding: utf-8 _*_

import re
import ngRequest
import json
import os


currentWorkPath = os.getcwd()
cityNameDict = {}
cityCodeDict = {}

configPath = currentWorkPath + '/cons/config.json'
captchaPath = currentWorkPath + '/captchaImage/catchpaImage.png'
trainDicListPath = currentWorkPath + '/tickets/ticketLeft.json'

def getStationName():
    url = 'https://kyfw.12306.cn/otn/resources/js/framework/station_name.js?station_version=1.9043'
    response = ngRequest.getRequest(url)
    # req = urllib.request.Request(url)
    # req.add_header('User-Agent','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36')
    if response.status_code == 200:
        html = response.text
        searchObj = re.match(r'(.*)station_names =\'(.*?)\';', html, re.I)
        str = searchObj.group(2)
        array = str.split('@')
        array.pop(0)
        for item in array:
            splis = item.split('|')
            cityNameDict[splis[1]] = splis[2]
            cityCodeDict[splis[2]] = splis[1]
    return response.status_code



def getCityNameWithCode(code):
    return cityCodeDict[code]

def getCityCodeWithName(name):
    return  cityNameDict[name]


def saveData(filename, data):
    with open(filename, 'w', encoding='utf-8') as file_obj:
        json.dump(data, file_obj)

def readConfig():
    data = {}
    with open(configPath,'r',encoding='utf-8') as file_obj:
        data = json.load(file_obj)
    return data

def saveConfig(key,value):
    config = readConfig()
    config[key] = value
    saveData(configPath,config)








