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

lst_csv_1 = ['districtid', 'weekid', 'neighborhoodzscore', 'statezscore']
lst_csv_2 = ['districtid', 'monthid', 'neighborhoodzscore', 'statezscore']
lst_csv_3 = ['districtid', 'overallid', 'neighborhoodzscore', 'statezscore']

week = [[0 for x in range (4)] for x in range (25*627)] # since 25 weeks
i = 101
j = 1
for x in week:
	x[0] = i
	x[1] = j
	j+= 1
	if (j==26):
		j=1
		i+= 1

mth = [[0 for x in range (4)] for x in range (7*627)] # since 7 months
i = 101
j = 1
for x in mth:
	x[0] = i
	x[1] = j
	j+= 1
	if (j==8):
		j=1
		i+= 1

overall = [[0 for x in range (4)] for x in range (1*627)] # since 1 overall
i = 101
j = 1
for x in overall:
	x[0] = i
	x[1] = j
	j+= 1
	if (j==2):
		j=1
		i+= 1

for x in range (0,week_data.shape[0]):
	if n_week.loc[x][3] != 0:
		week[x][2] = round((week_data.loc[x][2] - n_week.loc[x][2])/n_week.loc[x][3], 2)

	if s_week.loc[x][3] != 0:
		week[x][3] = round((week_data.loc[x][2] - s_week.loc[x][2])/s_week.loc[x][3], 2)


for x in range (0,mth_data.shape[0]):
	if n_mth.loc[x][3] != 0:
		mth[x][2] = round((mth_data.loc[x][2] - n_mth.loc[x][2])/n_mth.loc[x][3], 2)

	if s_mth.loc[x][3] != 0:
		mth[x][3] = round((mth_data.loc[x][2] - s_mth.loc[x][2])/s_mth.loc[x][3], 2)


for x in range (0,overall_data.shape[0]):
	if n_overall.loc[x][3] != 0:
		overall[x][2] = round((overall_data.loc[x][2] - n_overall.loc[x][2])/n_overall.loc[x][3], 2)

	if s_overall.loc[x][3] != 0:
		overall[x][3] = round((overall_data.loc[x][2] - s_overall.loc[x][2])/s_overall.loc[x][3], 2)


week.insert(0,lst_csv_1)
mth.insert(0,lst_csv_2)
overall.insert(0,lst_csv_3)

with open('zscore-week.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in week:
		wr.writerow(x)

with open('zscore-month.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in mth:
		wr.writerow(x)

with open('zscore-overall.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in overall:
		wr.writerow(x)
