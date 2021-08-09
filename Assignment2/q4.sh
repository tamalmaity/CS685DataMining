#!/usr/bin/env python

import csv

count = 0
res = []

f = open("shortest-path-distance-matrix.txt", "r")

for x in f:
	count+=1
	if count>17:
		L = []
		L.append("A"+str(count-17).zfill(4))
		for i in range (len(x)):
			if x[i]=='1':
				L.append("A"+str(i+1).zfill(4))
		res.append(L)

R = []
for x in res:
	for y in x[1:]:
		R.append([x[0],y])


with open('edges.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in R:
		wr.writerow(x)