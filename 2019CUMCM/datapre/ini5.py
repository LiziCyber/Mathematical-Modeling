# -*- coding: utf-8 -*-
"""
Created on Fri Sep 13 22:01:00 2019

@author: 10526
"""
#预处理5 找到机场空载回城区的汽车
import os
from math import sin, asin, cos, radians, fabs, sqrt
EARTH_RADIUS=6371           # 地球平均半径，6371km
path=r'C:\Users\10526\Desktop\DATA\Taxi_070220'
f0=r'C:\Users\10526\Desktop\DATA\kz1.txt'

files=os.listdir(path)
fw=open(f0,'w')
i=0;

def ina(x,y):
     x=round(float(x),2)
     y=round(float(y),2)
     if(x<=121.80 and x>=121.77 and y<=31.17 and y>=31.15):
          return True
     else:
          return False

def hav(theta):
    s = sin(theta / 2)
    return s * s
 
def get_distance_hav(lng0, lat0, lng1, lat1):
    # 经纬度转换成弧度
    lat0 = radians(float(lat0))
    lat1 = radians(float(lat1))
    lng0 = radians(float(lng0))
    lng1 = radians(float(lng1))
 
    dlng = fabs(lng0 - lng1)
    dlat = fabs(lat0 - lat1)
    h = hav(dlat) + cos(lat0) * cos(lat1) * hav(dlng)
    distance = 2 * EARTH_RADIUS * asin(sqrt(h))
 
    return distance
     
for f in files:
     with open(r'C:\Users\10526\Desktop\DATA\Taxi_070220\\'+f) as fr:
          s=set()
          for line in fr:
               curLine=line.replace(" ","").strip().split(",")
               s.add(curLine[len(curLine)-1])
          if(len(s)==1 or '2' in s or '3' in s):
               continue
          
          fr.seek(0)
          for line in fr:
               curLine=line.replace(" ","").strip().split(",")
               if(curLine[len(curLine)-1]=='0' and ina(curLine[2],curLine[3])):
                    for line1 in fr:
                         curLine1=line1.replace(" ","").strip().split(",")
                         if(curLine1[len(curLine1)-1]=='1' and not ina(curLine1[2],curLine1[3])):
                              curLine[1]=curLine[1][0:10]+'\t'+curLine[1][10:18]
                              fw.write("\t".join(curLine)+"\t")
                              fw.write(curLine1[1][10:18]+'\t'+\
                                       curLine1[2]+'\t'+curLine1[3]+'\t'+\
                                       str(1.414*get_distance_hav(\
                                       curLine[2],curLine[3],
                                       curLine1[2],curLine1[3]))\
                                       +'\n')
                              break
          fr.close()
fw.close()

