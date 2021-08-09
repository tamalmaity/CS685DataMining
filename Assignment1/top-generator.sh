#!/usr/bin/env python

import json
import csv
import statistics 
import pandas as pd

ms_week = pd.read_csv("method-spot-week.csv")
ms_mth = pd.read_csv("method-spot-month.csv")
ms_overall = pd.read_csv("method-spot-overall.csv")

z_week = pd.read_csv("zscore-week.csv")
z_mth = pd.read_csv("zscore-month.csv")
z_overall = pd.read_csv("zscore-overall.csv")

lst_csv_1 = ['weekid', 'method', 'spot', 'districtid1', 'districtid2', 'districtid3', 'districtid4', 'districtid5']
lst_csv_2 = ['monthid', 'method', 'spot', 'districtid1', 'districtid2', 'districtid3', 'districtid4', 'districtid5']
lst_csv_3 = ['overallid', 'method', 'spot', 'districtid1', 'districtid2', 'districtid3', 'districtid4', 'districtid5']


def Sort(lst):
	return(sorted(lst, key = lambda x: x[0])) 

def Rev_Sort(lst):
	return(sorted(lst , key = lambda x: x[0], reverse=True))


week = []
mth = []
overall = []

week = [[0 for x in range (8)] for x in range (25*4)] # since 25 weeks
for x in range (25):
	for i in range (4):
		week[x*4+i][0] = x+1
		week[x*4+i][3] = week[x*4+i][4] = week[x*4+i][5] = week[x*4+i][6] = week[x*4+i][7] = '-'
		if i==0:
			week[x*4+i][1] = 'neighborhood'
			week[x*4+i][2] = 'cold'
		elif i==1:
			week[x*4+i][1] = 'neighborhood'
			week[x*4+i][2] = 'hot' 
		elif i==2:
			week[x*4+i][1] = 'state'
			week[x*4+i][2] = 'cold' 
		elif i==3:
			week[x*4+i][1] = 'state'
			week[x*4+i][2] = 'hot' 

mth = [[0 for x in range (8)] for x in range (7*4)] # since 7 mths
for x in range (7):
	for i in range (4):
		mth[x*4+i][0] = x+1
		mth[x*4+i][3] = mth[x*4+i][4] = mth[x*4+i][5] = mth[x*4+i][6] = mth[x*4+i][7] = '-'
		if i==0:
			mth[x*4+i][1] = 'neighborhood'
			mth[x*4+i][2] = 'cold'
		elif i==1:
			mth[x*4+i][1] = 'neighborhood'
			mth[x*4+i][2] = 'hot' 
		elif i==2:
			mth[x*4+i][1] = 'state'
			mth[x*4+i][2] = 'cold' 
		elif i==3:
			mth[x*4+i][1] = 'state'
			mth[x*4+i][2] = 'hot' 

overall = [[0 for x in range (8)] for x in range (1*4)] # since 1 overall
for x in range (1):
	for i in range (4):
		overall[x*4+i][0] = x+1
		overall[x*4+i][3] = overall[x*4+i][4] = overall[x*4+i][5] = overall[x*4+i][6] = overall[x*4+i][7] = '-'
		if i==0:
			overall[x*4+i][1] = 'neighborhood'
			overall[x*4+i][2] = 'cold'
		elif i==1:
			overall[x*4+i][1] = 'neighborhood'
			overall[x*4+i][2] = 'hot' 
		elif i==2:
			overall[x*4+i][1] = 'state'
			overall[x*4+i][2] = 'cold' 
		elif i==3:
			overall[x*4+i][1] = 'state'
			overall[x*4+i][2] = 'hot' 

for x in week:
	lst = []
	for y in range (0, ms_week.shape[0]):
		if ms_week.loc[y][0] == x[0] and ms_week.loc[y][1]==x[1] and ms_week.loc[y][2]==x[2]:	
			row = (ms_week.loc[y][0]-1) + 25*(ms_week.loc[y][3]-101)
			if x[1]=='neighborhood':
				zsc = z_week.loc[row][2]
			else:
				zsc = z_week.loc[row][3]
			lst.append([zsc, ms_week.loc[y][3]]) 

	if x[2]=='cold':
		lst = Sort(lst)
		i=0
		for r in lst:
			x[3+i] = r[1]
			i+= 1
			if i==5:
				break
	else:
		lst = Rev_Sort(lst)
		i=0
		for r in lst:
			x[3+i] = r[1]
			i+= 1
			if i==5:
				break

for x in mth:
	lst = []
	for y in range (0, ms_mth.shape[0]):
		if ms_mth.loc[y][0] == x[0] and ms_mth.loc[y][1]==x[1] and ms_mth.loc[y][2]==x[2]:	
			row = (ms_mth.loc[y][0]-1) + 7*(ms_mth.loc[y][3]-101)
			if x[1]=='neighborhood':
				zsc = z_mth.loc[row][2]
			else:
				zsc = z_mth.loc[row][3]
			lst.append([zsc, ms_mth.loc[y][3]]) 

	if x[2]=='cold':
		lst = Sort(lst)
		i=0
		for r in lst:
			x[3+i] = r[1]
			i+= 1
			if i==5:
				break
	else:
		lst = Rev_Sort(lst)
		i=0
		for r in lst:
			x[3+i] = r[1]
			i+= 1
			if i==5:
				break

for x in overall:
	lst = []
	for y in range (0, ms_overall.shape[0]):
		if ms_overall.loc[y][0] == x[0] and ms_overall.loc[y][1]==x[1] and ms_overall.loc[y][2]==x[2]:	
			row = (ms_overall.loc[y][0]-1) + 1*(ms_overall.loc[y][3]-101)
			if x[1]=='neighborhood':
				zsc = z_overall.loc[row][2]
			else:
				zsc = z_overall.loc[row][3]
			lst.append([zsc, ms_overall.loc[y][3]]) 

	if x[2]=='cold':
		lst = Sort(lst)
		i=0
		for r in lst:
			x[3+i] = r[1]
			i+= 1
			if i==5:
				break
	else:
		lst = Rev_Sort(lst)
		i=0
		for r in lst:
			x[3+i] = r[1]
			i+= 1
			if i==5:
				break




week.insert(0,lst_csv_1)
mth.insert(0,lst_csv_2)
overall.insert(0,lst_csv_3)

	

with open('top-week.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in week:
		wr.writerow(x)

with open('top-month.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in mth:
		wr.writerow(x)

with open('top-overall.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in overall:
		wr.writerow(x)
