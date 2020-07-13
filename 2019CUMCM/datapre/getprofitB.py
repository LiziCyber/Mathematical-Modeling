# -*- coding: utf-8 -*-
"""
Created on Sun Sep 15 00:24:27 2019

@author: 10526
"""

from datetime import datetime
f=r'C:\Users\10526\Desktop\DATA\zk5.txt'

l1={}
l2={}
l3={}
c1=0
c2=0
c3=0
a=datetime.strptime("08:00:00","%H:%M:%S")
b=datetime.strptime("16:00:00","%H:%M:%S")
with open(f) as fr:
     for line in fr:
          curLine=line.strip().split("\t")
          t=datetime.strptime(curLine[2],"%H:%M:%S")
          if(t<a):
               if(curLine[0] not in l1):
                    l1[curLine[0]]=[];
               l1[curLine[0]].append(float(curLine[-1]));
               c1+=0.3366*float(curLine[-3])
          elif(t<b):
               if(curLine[0] not in l2):
                    l2[curLine[0]]=[];
               l2[curLine[0]].append(float(curLine[-1]));
               c2+=0.3366*float(curLine[-3])
          else:
               if(curLine[0] not in l3):
                    l3[curLine[0]]=[];
               l3[curLine[0]].append(float(curLine[-1]));
               c3+=0.3366*float(curLine[-3])
               
sum1=0
sum2=0
sum3=0
num1=0
num2=0
num3=0
for key in l1:
     if(len(l1[key])>=7):
          sum1=sum1+sum(l1[key])
          num1=num1+1
for key in l2:
     if(len(l2[key])>=7):
          sum2=sum2+sum(l2[key])
          num2=num2+1
for key in l3:
     if(len(l3[key])>=7):
          sum3=sum3+sum(l3[key])
          num3=num3+1
ans1=(-c1+sum1)/num1/(8*60)
ans2=(-c2+sum2)/num2/(8*60)
ans3=(-c3+sum3)/num3/(8*60)