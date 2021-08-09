#!/usr/bin/env python

import json
import csv
import statistics 
import pandas as pd

week_data = pd.read_csv("cases-week.csv")

mth_data = pd.read_csv("cases-month.csv")

overall_data = pd.read_csv("cases-overall.csv")

neigh_data = pd.read_csv("edge-graph.csv", header=None)

with open('neighbor-districts-modified.json') as f1:
	mod_dist = json.load(f1)

ids = {}
i=0
for x in mod_dist:
	ids[x] = 101+i
	i+= 1

dict_id = {}

for x in mod_dist:
	n = []
	for y in mod_dist[x]:
		n.append(ids[y])
	dict_id[ids[x]] = n



lst_csv_1 = ['districtid', 'weekid', 'neighbormean', 'neighborstdev']
lst_csv_2 = ['districtid', 'monthid', 'neighbormean', 'neighborstdev']
lst_csv_3 = ['districtid', 'overallid', 'neighbormean', 'neighborstdev']

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

for x in range(101,728):
	neighbor = dict_id[x]
	for y in range (1,26):	
		case = []
		for i in neighbor:
			row = 25*(i-101) + y-1
			case.append(float(week_data.loc[row]['cases']))

		row = 25*(x-101)+y-1
		week[row][2] = round(statistics.mean(case),2)
		if (len(case)<2):
			week[row][3] = 0
		else:
			week[row][3] = round(statistics.stdev(case),2)


for x in range(101,728):
	neighbor = dict_id[x]
	for y in range (1,8):	
		case = []
		for i in neighbor:
			row = 7*(i-101) + y-1
			case.append(float(mth_data.loc[row]['cases']))

		row = 7*(x-101)+y-1
		mth[row][2] = round(statistics.mean(case),2)
		if (len(case)<2):
			mth[row][3] = 0
		else:
			mth[row][3] = round(statistics.stdev(case),2)


for x in range(101,728):
	neighbor = dict_id[x]
	for y in range (1,2):	
		case = []
		for i in neighbor:
			row = 1*(i-101) + y-1
			case.append(float(overall_data.loc[row]['cases']))

		row = 1*(x-101)+y-1
		overall[row][2] = round(statistics.mean(case),2)
		if (len(case)<2):
			overall[row][3] = 0
		else:
			overall[row][3] = round(statistics.stdev(case),2)


week.insert(0,lst_csv_1)
mth.insert(0,lst_csv_2)
overall.insert(0,lst_csv_3)

with open('neighbor-week.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in week:
		wr.writerow(x)

with open('neighbor-month.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in mth:
		wr.writerow(x)

with open('neighbor-overall.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in overall:
		wr.writerow(x)