#!/usr/bin/env python

import json
from datetime import timedelta, date
import csv

with open('neighbor-districts-modified.json') as f1:
	mod_dist = json.load(f1)
with open('data-all.json') as f2:
	all_data = json.load(f2)

def which_week(s):
	sep = '-'
	m = s.split(sep,2)[1]
	d = s.split(sep,2)[2]
	start = date (2020, 3, 15)
	today = date (2020, int(m), int(d))
	diff = today-start
	return (int(diff.days/7)+1)

def which_mth(s):
	sep = '-'
	m = int(s.split(sep,2)[1])
	return (m-2)

def daterange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)

ids = {}
i=0
for x in mod_dist:
	y = x.split('/',1)[0]
	ids[y] = 101+i
	i+= 1


start_date = date(2020, 3, 15)
end_date = date(2020, 9, 6)

unknown_st_code = ['TG', 'AS', 'MN', 'SK', 'GA']
lst_csv_1 = ['districtid', 'weekid', 'cases']
lst_csv_2 = ['districtid', 'monthid', 'cases']
lst_csv_3 = ['districtid', 'overallid', 'cases']

week = [[0 for x in range (3)] for x in range (25*627)] # since 25 weeks
i = 101
j = 1
for x in week:
	x[0] = i
	x[1] = j
	j+= 1
	if (j==26):
		j=1
		i+= 1

mth = [[0 for x in range (3)] for x in range (7*627)] # since 7 months
i = 101
j = 1
for x in mth:
	x[0] = i
	x[1] = j
	j+= 1
	if (j==8):
		j=1
		i+= 1

overall = [[0 for x in range (3)] for x in range (1*627)] # since 1 overall
i = 101
j = 1
for x in overall:
	x[0] = i
	x[1] = j
	j+= 1
	if (j==2):
		j=1
		i+= 1


for x in all_data:
	sep = '-'
	m = int(x.split(sep,2)[1])
	d = int(x.split(sep,2)[2])
	if m<3 or m>9 or (m==3 and d<15) or (m==9 and d>5):
		continue
	for y in all_data[x]:
		if y in unknown_st_code:
			district = "unknown_"+y
			num = ids[district]
			w = which_week(x)
			row = 25*(num-101) + w - 1
			w_mth = which_mth(x)
			row_mth = 7*(num-101) + w_mth - 1

			if 'delta' in all_data[x][y] and 'confirmed' in all_data[x][y]['delta']:
				week[row][2]+= all_data[x][y]['delta']['confirmed']
				mth[row_mth][2]+= all_data[x][y]['delta']['confirmed']
				overall[num-101][2]+= all_data[x][y]['delta']['confirmed']

		else:
			if 'districts' in all_data[x][y]:
				for z in all_data[x][y]['districts']:
					district = z.lower()
					district = district+'_'+y
					if district not in ids:
						continue
					num = ids[district]
					w = which_week(x)
					row = 25*(num-101) + w -1
					w_mth = which_mth(x)
					row_mth = 7*(num-101) + w_mth-1

					if 'delta' in all_data[x][y]['districts'][z] and 'confirmed' in all_data[x][y]['districts'][z]['delta']:
						week[row][2]+= all_data[x][y]['districts'][z]['delta']['confirmed']
						mth[row_mth][2]+= all_data[x][y]['districts'][z]['delta']['confirmed']
						overall[num-101][2]+= all_data[x][y]['districts'][z]['delta']['confirmed']
'''

summ = 0
for x in mth:
	summ+= x[2]
print(summ)

summ = 0
for x in week:
	summ+= x[2]
print(summ)

summ = 0
for x in overall:
	summ+= x[2]
print(summ)
'''


week.insert(0,lst_csv_1)
mth.insert(0,lst_csv_2)
overall.insert(0,lst_csv_3)

with open('cases-week.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in week:
		wr.writerow(x)
with open('cases-month.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in mth:
		wr.writerow(x)
with open('cases-overall.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in overall:
		wr.writerow(x)




      #print(which_week(s))
'''

print (all_data['2020-05-05']['MH']["districts"]["Ahmednagar"]["delta"]["confirmed"])
summ = 0
for x in all_data['2020-05-05']['MH']["districts"]:
	if 'delta' in all_data['2020-05-05']['MH']["districts"][x]:
		if 'confirmed' in all_data['2020-05-05']['MH']["districts"][x]["delta"]:
			summ+= all_data['2020-05-05']['MH']["districts"][x]["delta"]["confirmed"]

print(summ)

print(all_data['2020-03-15']["KL"]["delta"]["confirmed"])

'''