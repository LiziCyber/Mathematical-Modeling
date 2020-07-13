# -*- coding: utf-8 -*-
"""
Created on Sat Sep 14 20:42:57 2019

@author: 10526
"""

#ini_cData
f=r'C:\Users\10526\Desktop\DATA\cData.txt'
f0=r'C:\Users\10526\Desktop\DATA\cData2.txt'

l=[0]*226
fw=open(f0,'w')
with open(f) as fr:
     for line in fr:
          curLine=line.strip().split()
          for i in range(0,len(curLine),2):
               l[int(curLine[i])]=curLine[i+1]
for i in range(1,226):
     fw.write(l[i]+"\n");
fr.close()
fw.close()