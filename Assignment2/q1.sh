#!/usr/bin/env python

import csv

count = 0;

L = []

with open("articles.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile, delimiter="\t")
	for line in tsvreader:
		count+= 1
		if count>12:
			line = str(line[0])
			num = ("A"+str(count-12).zfill(4))
			L.append([line,num])


with open('article-ids.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in L:
		wr.writerow(x)