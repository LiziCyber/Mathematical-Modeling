# -*- coding: utf-8 -*-
"""
Created on Sun Sep 15 13:25:06 2019

@author: 10526
"""

from datetime import datetime
f=r'C:\Users\10526\Desktop\DATA\t4data0.txt'
f0=r'C:\Users\10526\Desktop\DATA\t4data1.txt'

no=0;ts=1;te=2;di=3;

fw=open(f0,'w')
with open(f) as fr:
     for line in fr:
          curLine=line.strip().split("\t")
          t0=datetime.strptime(curLine[0],"%H:%M:%S")
          t1=datetime.strptime(curLine[1],"%H:%M:%S")
          profit=float(curLine[2])
          t=(t1-t0).seconds/60    #得到订单时间
          fw.write(str(profit)+'\t'+str(t)+'\n')
fr.close()
fw.close()