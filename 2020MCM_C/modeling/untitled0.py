# -*- coding: utf-8 -*-
"""
Created on Mon Mar  9 20:00:09 2020

@author: 10526
"""

import numpy as np
from scipy.optimize import minimize
import pandas as pd
import os

def lamk(t, param, data):
    
    times = data[:,0]
    types = data[:,1]
    
    K = np.max(types)+1 #类别从0开始以数字进行标注
    s = param[0]
    #print(s)
    mu = param[1]
    delta = param[2:2+K]
    alpha = param[2+K:]
    
    temp = mu
    idx = times < t

    times = times[idx]
    types = types[idx]
    
    for i in range(times.shape[0]):
        #print(delta.shape)
        temp += alpha[types[i]] * np.exp(-delta[types[i]] * (t-times[i]))
    
    #print(s*np.log(1+np.exp(temp)/(s+0.00001)))
    return s*np.log(1+np.exp(temp)/(s))

#def slam(t, param, data):


def MC(param, data):
    times = data[:,0]
    types = data[:,1]
    T = np.max(times)
    K = np.max(types) #这里的K和上面的K不一样

    r1 = 0
    for i in range(1000):
        t = np.random.uniform(0,T)
        for j in range(K):
            r1 += lamk(t, param[types[j],:], data)

    return r1/times.shape[0]
            
def log_likeli(param, data):
    times = data[:,0]
    types = data[:,1]
    k = np.max(types)+1
    param.resize((2*k+2, k))
    param = param.T

    ll = 0
    #print(times.shape[0])
    for i in range(times.shape[0]):
        ll += np.log(lamk(times[i], param[types[i],:], data))
        
    ll -= MC(param ,data)
    return ll

def combine(s, mu, delta, alpha):
    return np.row_stack((s,mu,delta,alpha))

def HP(dataset, name, param):
    product = dataset.product_title.value_counts().index[0]
    subset = dataset[dataset.product_title==product]
    subset['relative'] = [(x - subset.iloc[0]['review_date']).days for x in subset['review_date']]
    data = subset[['relative', 'like']]
    data = data[data['like']!=0]
    data = np.array(data)[:, :]
    data[:,1] = (data[:,1]+1)/2
    K = np.max(data[:,1])+1
    param.resize(K*K*2+K*2)
    print(param.shape)

    best = 100000
    for i in range(1):
        param = minimize(lambda x: -log_likeli(x, data), 
                         x0=param, method='BFGS', #Nelder-Mead
                         options={'disp': False, 'maxiter':1})
        if param.fun < best:
            best = param.fun
            bp = param
        
    return bp


DATA_DIR = '.\data\enhanced'
hairdryer = 'hair_dryer_finished.csv'
microwave = 'microwave_finished.csv'
pacifier = 'pacifier_finished.csv'

pdata = pd.read_csv(os.path.join(DATA_DIR, pacifier))
hdata = pd.read_csv(os.path.join(DATA_DIR, hairdryer))
mdata = pd.read_csv(os.path.join(DATA_DIR, microwave))

pdata = pdata.dropna(axis=0,how='any').drop(pdata.tail(1).index)
pdata.review_date = pd.to_datetime(pdata.review_date, format='%m/%d/%Y')
hdata = hdata.dropna(axis=0,how='any')
hdata.review_date = pd.to_datetime(hdata.review_date, format='%m/%d/%Y')
mdata = mdata.dropna(axis=0,how='any')
mdata.review_date = pd.to_datetime(mdata.review_date, format='%m/%d/%Y')

pdata.sort_values('review_date', inplace=True)
hdata.sort_values('review_date', inplace=True)
mdata.sort_values('review_date', inplace=True)

s = np.random.uniform(0.5,1,(1,2))
mu = np.random.uniform(0.5,1,(1,2))
delta = np.random.uniform(0.5,1,(2,2))
alpha = np.random.uniform(0.5,1,(2,2))
param = combine(s,mu,delta,alpha)

pparam = HP(pdata, 'hair', param)