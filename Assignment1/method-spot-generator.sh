#!/usr/bin/env python

import json
import csv
import statistics 
import pandas as pd

week_data = pd.read_csv("cases-week.csv")
mth_data = pd.read_csv("cases-month.csv")
overall_data = pd.read_csv("cases-overall.csv")

n_week = pd.read_csv("neighbor-week.csv")
n_mth = pd.read_csv("neighbor-month.csv")
n_overall = pd.read_csv("neighbor-overall.csv")

s_week = pd.read_csv("state-week.csv")
s_mth = pd.read_csv("state-month.csv")
s_overall = pd.read_csv("state-overall.csv")

lst_csv_1 = ['weekid', 'method', 'spot', 'districtid']
lst_csv_2 = ['monthid', 'method', 'spot', 'districtid']
lst_csv_3 = ['overallid', 'method', 'spot', 'districtid']

def Sort(lst):
	return(sorted(lst, key = lambda x: x[0])) 

week=[]
mth=[]
overall=[]

for x in range (0,week_data.shape[0]):
	if (week_data.loc[x][2]>(n_week.loc[x][2] + n_week.loc[x][3])):
		week.append([week_data.loc[x][1], 'neighborhood', 'hot', week_data.loc[x][0]])
	if (week_data.loc[x][2]<(n_week.loc[x][2] - n_week.loc[x][3])):
		week.append([week_data.loc[x][1], 'neighborhood', 'cold', week_data.loc[x][0]])

	if (week_data.loc[x][2]>(s_week.loc[x][2] + s_week.loc[x][3])):
		week.append([week_data.loc[x][1], 'state', 'hot', week_data.loc[x][0]])
	if (week_data.loc[x][2]<(s_week.loc[x][2] - s_week.loc[x][3])):
		week.append([week_data.loc[x][1], 'state', 'cold', week_data.loc[x][0]])


for x in range (0,mth_data.shape[0]):
	if (mth_data.loc[x][2]>(n_mth.loc[x][2] + n_mth.loc[x][3])):
		mth.append([mth_data.loc[x][1], 'neighborhood', 'hot', mth_data.loc[x][0]])
	if (mth_data.loc[x][2]<(n_mth.loc[x][2] - n_mth.loc[x][3])):
		mth.append([mth_data.loc[x][1], 'neighborhood', 'cold', mth_data.loc[x][0]])

	if (mth_data.loc[x][2]>(s_mth.loc[x][2] + s_mth.loc[x][3])):
		mth.append([mth_data.loc[x][1], 'state', 'hot', mth_data.loc[x][0]])
	if (mth_data.loc[x][2]<(s_mth.loc[x][2] - s_mth.loc[x][3])):
		mth.append([mth_data.loc[x][1], 'state', 'cold', mth_data.loc[x][0]])


for x in range (0,overall_data.shape[0]):
	if (overall_data.loc[x][2]>(n_overall.loc[x][2] + n_overall.loc[x][3])):
		overall.append([overall_data.loc[x][1], 'neighborhood', 'hot', overall_data.loc[x][0]])
	if (overall_data.loc[x][2]<(n_overall.loc[x][2] - n_overall.loc[x][3])):
		overall.append([overall_data.loc[x][1], 'neighborhood', 'cold', overall_data.loc[x][0]])

	if (overall_data.loc[x][2]>(s_overall.loc[x][2] + s_overall.loc[x][3])):
		overall.append([overall_data.loc[x][1], 'state', 'hot', overall_data.loc[x][0]])
	if (overall_data.loc[x][2]<(s_overall.loc[x][2] - s_overall.loc[x][3])):
		overall.append([overall_data.loc[x][1], 'state', 'cold', overall_data.loc[x][0]])

week = Sort(week)
mth = Sort(mth)
overall = Sort(overall)

week.insert(0,lst_csv_1)
mth.insert(0,lst_csv_2)
overall.insert(0,lst_csv_3)

with open('method-spot-week.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in week:
		wr.writerow(x)

with open('method-spot-month.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in mth:
		wr.writerow(x)

with open('method-spot-overall.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in overall:
		wr.writerow(x)
