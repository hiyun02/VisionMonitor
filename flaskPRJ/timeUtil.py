import datetime

#입력은 time.time()의 리턴인 float이 됨
def count_time(time1, time2) :
    
    sec = time2 - time1
    result_list = str(datetime.timedelta(seconds=sec)).split(".")
    
    return result_list[0]  

def floatTime(float) :
    result_list = str(datetime.timedelta(seconds=float)).split(".")
    return result_list[0] 