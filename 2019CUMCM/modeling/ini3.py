# -*- coding: utf-8 -*-
"""
Created on Fri Sep 13 16:12:36 2019

@author: 10526
"""

#预处理3 合并订单

f=r'C:\Users\10526\Desktop\DATA\zk2.txt'
f0=r'C:\Users\10526\Desktop\DATA\zk3.txt'

fw=open(f0,'w')

with open(f) as fr:
     lastLine=fr.readline()
     fw.write(lastLine.strip())
     for line in fr:
          if(line=="\n"):
               cur=lastLine.strip().split("\t")
               fw.write('\t'+cur[2]+'\t'+cur[3]+'\t'+cur[4]+'\n')
          if(lastLine=="\n"):
               fw.write(line.strip())
          lastLine=line
fr.close()
fw.close()
