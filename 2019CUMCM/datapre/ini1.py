# -*- coding: utf-8 -*-
"""
Created on Fri Sep 13 14:09:59 2019

@author: 10526
"""
#预处理1 找到所有标号载客的车
import os
path=r'C:\Users\10526\Desktop\DATA\Taxi_070220'
f0=r'C:\Users\10526\Desktop\DATA\zk1.txt'
l=[]
files=os.listdir(path)
fw=open(f0,'w')
i=0;
for f in files:
     with open(r'C:\Users\10526\Desktop\DATA\Taxi_070220\\'+f) as fr:
          s=set()
          for line in fr:
               curLine=line.replace(" ","").strip().split(",")
               s.add(curLine[len(curLine)-1])
          if(len(s)==1 or '2' in s or '3' in s):
               continue
          i+=1
          flag=0
          fr.seek(0)
          for line in fr:
               curLine=line.replace(" ","").strip().split(",")
               curLine[1]=curLine[1][0:10]+'\t'+curLine[1][10:18]
               if(curLine[len(curLine)-1]=='1'):
                    fw.write("\t".join(curLine)+'\n')
                    flag=1
               elif(curLine[len(curLine)-1]=='0' and flag==1):
                    fw.write('\n')
                    flag=0
          fr.close()
fw.close()


