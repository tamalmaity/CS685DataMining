#!/usr/bin/env python

import csv

count = 0
L = {}
d = {}
ar = {}

with open("category-ids.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		d[line[0]] = line[1]


with open("categories.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile, delimiter="\n")
	for line in tsvreader:
		count+= 1
		if count>13:
			line = line[0].split('\t')
			if line[0] in L:
				l = L[line[0]]
				l.append(line[1])
				L[line[0]] = l
			else:
				L[line[0]] = [line[1]]


with open("article-ids.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		l = []
		if line[0] not in L:
			ar[line[1]] = "Z" #mark as subject
		else:
			for x in L[line[0]]:
				l.append(d[x])
			ar[line[1]] = l

res = []
for x in ar:
	r = []
	r.append(x)
	for i in ar[x]:
		if i=="Z":
			r.append("C0001")
		else:
			r.append(i)
	res.append(r)

with open('article-categories.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in res:
		wr.writerow(x)
