# _*_ coding: utf-8 _*_
import cons
import time
import os
import login
import order
import ticket

#无语，只能拖过message判断是否成功，其他会报错
def loginFunc():
    print('开始登录')
    response = login.loginReq()
    print(response)
    if isinstance(response,str):
        if response == '登录成功':
            auth = uamtkFunc()
            if auth!=None:
                result = login.uamauthclient(auth['newapptk'])
                if isinstance(result,dict):
                    info = login.initMy12306()
                    print(info)



#错误5次就重启
def captchaCheckFunc(positions):
    print('开始验证验证图')
    # 取出验证结果，4：成功  5：验证失败  7：过期
    response = login.captchaCheck(positions)
    if os.path.exists(cons.captchaPath):
        os.remove(cons.captchaPath)
    if isinstance(response,dict):
        code = response['result_code']
        if code == '4':
            print('验证成功')
            loginFunc()
        else:
            print('验证失败')
            cons.saveConfig('capthaPoistions', '')
            getCaptchPoistionFunc()

def getCaptchPoistionFunc():
    print('刷新验证图')
    response = login.getCaptchaImge()
    if response == 200:
        print('获取得到验证图，开始手动验证')
        positions = cons.readConfig()['capthaPoistions']
        while len(positions) == 0:
            time.sleep(0.5)
            positions = cons.readConfig()['capthaPoistions']
        print('验证码：' + positions)
        captchaCheckFunc(positions)
    else:
        print('验证图获取失败')


def uamtkFunc():
    print('检查登陆状态')
    response = login.uamtk()
    if isinstance(response,dict):
        print('登陆状态返回啦')
        code = response['result_code']
        if code == 0:
            return response
        cons.saveConfig('authUamtk', code)
    return None


def reset():
    print('初始化啦')
    cons.saveConfig('capthaPoistions', '')


def main():
    print('程序开始')
    reset()
    if uamtkFunc()==None:
        getCaptchPoistionFunc()


# order.checkUser()
# login.uamtk()
# login.uamauthclient('38yWwum-Mwe8tNyXe1vgn-6az2Q2uZZ3FvsVm6hQz3g73l1l0')
# main()
# os.remove(cons.captchaPath)
cons.getStationName()
ticket.getTrainRquestList()