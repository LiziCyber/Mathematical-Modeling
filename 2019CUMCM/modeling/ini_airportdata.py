# -*- coding: utf-8 -*-
"""
Created on Sat Sep 14 22:18:06 2019

@author: 10526
"""
from datetime import datetime
f=r'C:\Users\10526\Desktop\DATA\airportdata.txt'
f0=r'C:\Users\10526\Desktop\DATA\airportdata2.txt'

t0=datetime.strptime("00:00:00.000","%H:%M:%S.%f")
fw=open(f0,'w')
x=[]
y=[]
with open(f) as fr:
     for line in fr:
          curLine=line.strip().split("\t")
          curLine[0]=curLine[0].split()[1]
          if(curLine[1]=='T1'):
               if(len(curLine[0].split(":")[0])==1):
                    curLine[0]='0'+curLine[0];
               t=datetime.strptime(curLine[0],"%H:%M:%S.%f")
               x.append((t-t0).seconds)
               y.append(int(curLine[2]))
               fw.write(str((t-t0).seconds)+'\t'+curLine[2]+'\n')
fr.close()
fw.close()