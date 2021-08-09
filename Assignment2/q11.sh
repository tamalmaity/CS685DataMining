#!/usr/bin/env python

import csv

L = []
cat = {} #categories with id
rev_cat = {}
fin = []
ar_cat = {} #article - category
ar = {} #articles with id

with open("category-ids.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		cat[line[1]] = line[0]
		rev_cat[line[0]] = line[1]

with open("article-ids.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		ar[line[0]] = line[1]

with open("article-categories.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		temp = []
		for x in range(len(line)):
			if x == 0:
				continue
			else:
				temp.append(line[x])
		ar_cat[line[0]] = temp


count = 0
f = open("shortest-path-distance-matrix.txt", "r")

for x in f:
	count+=1
	if count>17:
		L.append(x)


count = 1

with open("paths_finished.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile)
	for line in tsvreader:
		if count>=17:
			line = line[0].split('\t')[3]
			line = line.split(';')
			if (len(line)==1):
				count+= 1
				continue
			if (count == 2412):
				count+= 1
				continue

			path = 0
			back = 0
			for x in line:
				path+= 1 
				if x=='<':
					back+= 1
			path = path - 2*back - 1
			
			fin.append([ar[line[0]], ar[line[len(line)-1]], path])

		count+= 1

d = {}
for x in fin:
	if (x[0],x[1]) in d:
		d[(x[0],x[1])].append(x[2])
	else:
		d[(x[0],x[1])] = [x[2]]

for x in d:
	a = int(x[0][1:]) -1
	b = int(x[1][1:]) -1
	c = int(L[a][b])
	t = []
	for y in d[x]:
		t.append(round((y/c),4))
	s = 0
	for i in t:
		s+= i
	d[x] = round(s/len(t),4)


res_fin  = {}

for x in d:
	src = []
	for i in ar_cat[x[0]]:
		src.append(i)

	for i in range (len(src)):
		src[i] = cat[src[i]]

	src_s = set()
	for i in src:
		temp = i.split('.')
		now = temp[0]
		src_s.add(now)
		for j in range(1,len(temp)):
			now = now + '.' + temp[j]
			src_s.add(now)

	src_s = list(src_s);
	for i in range (len(src_s)):
		src_s[i] = rev_cat[src_s[i]]


	dest = []
	for i in ar_cat[x[1]]:
		dest.append(i)

	for i in range (len(dest)):
		dest[i] = cat[dest[i]]

	dest_s = set()
	for i in dest:
		temp = i.split('.')
		now = temp[0]
		dest_s.add(now)
		for j in range(1,len(temp)):
			now = now + '.' + temp[j]
			dest_s.add(now)

	dest_s = list(dest_s);
	for i in range (len(dest_s)):
		dest_s[i] = rev_cat[dest_s[i]]

	for a in src_s:
		for b in dest_s:
			if (a,b) in res_fin:
				res_fin[(a,b)].append(d[x])
			else:
				res_fin[(a,b)] = [d[x]]

result = []
for x in res_fin:
	s = 0
	for y in res_fin[x]:
		s+= y
	
	result.append([x[0], x[1], round(s/len(res_fin[x]),4)])

result.sort(key = lambda result: [result[0],result[1]])


with open('category-ratios.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in result:
		wr.writerow(x)


