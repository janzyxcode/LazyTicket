# _*_ coding: utf-8 _*_
import cons
import login
import time

def loginFunc():
    response = cons.login()
    print(response)
    if response[0] == 200:
        result = response[1][0]
        if result['result_code'] == 0:
            print('')
        else:
            print('--')

def captchaCheckFunc(positions):
    captchaCheckResult = login.captchaCheck(positions)
    print(captchaCheckResult)
    if captchaCheckResult[0] == 200:
        result = captchaCheckResult[1][0]
        if result['result_code'] == 4:
            loginFunc()
        else:
            print('--')


def reset():
    cons.resetCaptchaImagePostions()

def main():
    reset()
    login.uamtk()
    if login.getCaptchaImge() != None:
        positions = cons.getCaptchaImagePoistions()
        while len(positions) == 0:
            time.sleep(0.5)
            positions = cons.getCaptchaImagePoistions()
        captchaCheckFunc(positions)
    else:
        print('s')




main()