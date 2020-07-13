# -*- coding: utf-8 -*-
"""
Created on Fri Sep 13 15:55:30 2019

@author: 10526
"""

#预处理2 拆分订单

f=r'C:\Users\10526\Desktop\DATA\zk1.txt'
f0=r'C:\Users\10526\Desktop\DATA\zk2.txt'

fw=open(f0,'w')

with open(f) as fr:
     lastLine=fr.readline()
     fw.write(lastLine)
     lastLine=lastLine.strip().split("\t")
     for line in fr:
          if(line=="\n"):
               fw.write("\n")
               lastLine=line
               continue
          if(lastLine=="\n"):
               fw.write(line)
               lastLine=line.strip().split("\t")
               continue
          curLine=line.strip().split("\t")
          t0=int(lastLine[2][3:5])
          t1=int(curLine[2][3:5])
          if(t1-t0>2):
               fw.write("\n")
          fw.write(line)
          lastLine=curLine
fr.close()
fw.close()
