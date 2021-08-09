#!/usr/bin/env python

import csv 

L = [['Equal_Length','Larger_by_1','Larger_by_2','Larger_by_3',
'Larger_by_4','Larger_by_5','Larger_by_6','Larger_by_7','Larger_by_8',
'Larger_by_9','Larger_by_10','Larger_by_more_than_10']]
L.append([0]*12)

count = 0

with open("finished-paths-no-back.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		count+= 1
		if (int(line[0])-int(line[1])>=11):
			L[1][11]+= 1
		else:
			L[1][int(line[0])-int(line[1])]+= 1

for i in range(12):
	L[1][i] = round((L[1][i]*100)/count,4)


R = [['Equal_Length','Larger_by_1','Larger_by_2','Larger_by_3',
'Larger_by_4','Larger_by_5','Larger_by_6','Larger_by_7','Larger_by_8',
'Larger_by_9','Larger_by_10','Larger_by_more_than_10']]
R.append([0]*12)

count = 0

with open("finished-paths-back.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		count+= 1
		if (int(line[0])-int(line[1])>=11):
			R[1][11]+= 1
		else:
			R[1][int(line[0])-int(line[1])]+= 1


for i in range(12):
	R[1][i] = round((R[1][i]*100)/count,4)


with open('percentage-paths-no-back.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in L:
		wr.writerow(x)

with open('percentage-paths-back.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in R:
		wr.writerow(x)