#!/usr/bin/env python

import csv

count = 0
res1 = []
res2 = []
L = []
d = {}

f = open("shortest-path-distance-matrix.txt", "r")

for x in f:
	count+=1
	if count>17:
		L.append(x)

num = 1
with open("article-ids.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		d[line[0]] = num
		num+= 1

count = 1

eq = []
av  = []
with open("paths_finished.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile)
	for line in tsvreader:
		if count>=17:
			line = line[0].split('\t')[3]
			line = line.split(';')
			if (len(line)==1):
				continue
			human_path_back = 0
			human_path_no = 0
			if (count == 2412):
				count+= 1
				continue
			short_path = int(L[d[line[0]]-1][d[line[-1]]-1])
			
			'''
			back = 0
			for x in line:
				if x=='<':
					back+= 1
				human_path_back+= 1

			human_path_no = human_path_back
			human_path_back-= 1
			human_path_no = human_path_no - 2*back - 1
			'''
			human_path_back = 0
			st = []
			for x in line:
				human_path_back+= 1
				if x == '<':
					st.pop()
				else:
					st.append(x)

			human_path_back-= 1
			human_path_no = len(st) - 1
			st.clear()
			
			res1.append([human_path_no, short_path, round(human_path_no/short_path,4)])
			res2.append([human_path_back, short_path, round(human_path_back/short_path,4)])

			'''
			if human_path_back>human_path_no:
				av.append(human_path_back)
			if human_path_back==human_path_no:
				eq.append(human_path_back)
			'''


		count+= 1

'''
sum = 0
s = 0
for x in av:
	sum+= x

for x in eq:
	s+= x

print(sum/len(av),s/len(eq), len(av)/len(res1),len(eq)/len(res1))
'''


with open('finished-paths-no-back.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in res1:
		wr.writerow(x)

with open('finished-paths-back.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in res2:
		wr.writerow(x)
