# -*- coding: utf-8 -*-
"""
Created on Fri Sep 13 16:37:56 2019

@author: 10526
"""

#预处理4 计算距离

from math import sin, asin, cos, radians, fabs, sqrt
EARTH_RADIUS=6371           # 地球平均半径，6371km

def hav(theta):
    s = sin(theta / 2)
    return s * s
 
def get_distance_hav(lng0, lat0, lng1, lat1):
    # 经纬度转换成弧度
    lat0 = radians(lat0)
    lat1 = radians(lat1)
    lng0 = radians(lng0)
    lng1 = radians(lng1)
 
    dlng = fabs(lng0 - lng1)
    dlat = fabs(lat0 - lat1)
    h = hav(dlat) + cos(lat0) * cos(lat1) * hav(dlng)
    distance = 2 * EARTH_RADIUS * asin(sqrt(h))
 
    return distance
f=r'C:\Users\10526\Desktop\DATA\zk3.txt'
f0=r'C:\Users\10526\Desktop\DATA\zk4.txt'

fw=open(f0,'w')
with open(f) as fr:
     for line in fr:
          curLine=line.strip().split('\t')
          curLine.append(str(get_distance_hav(float(curLine[3]),float(curLine[4]),float(curLine[9]),float(curLine[10]))))
          fw.write('\t'.join(curLine)+'\n')
fr.close()
fw.close()
y=get_distance_hav(121.475000,31.227000,121.470000,31.206800)