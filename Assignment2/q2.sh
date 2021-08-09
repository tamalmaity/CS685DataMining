#!/usr/bin/env python

import csv

count = 0

L = []
lst = set()

with open("categories.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile, delimiter="\n")
	for line in tsvreader:
		count+= 1
		if count>13:
			line = line[0].split('\t')[1]
			lst.add(line)

lst = list(lst)
	
lst.sort()

count = 1
total = []


q = []
d = set()

###########
for x in lst:
	m = x.split('.')
	if len(m)>=1 and m[0] not in d:
		q.append(m[0])
		d.add(m[0])

q.sort()

for x in q:
	L.append(["C" + str(count).zfill(4),x])
	count+= 1

##########
d.clear()

while len(q)!=0:
	ele = q.pop().split('.')
	for x in lst:
		m = x.split('.')
		if len(m)>=2 and ele[0] == m[0] and (ele[0]+'.'+m[1]) not in d:
			q.append(m[0]+'.'+m[1])
			d.add(m[0]+'.'+m[1])

q = list(d)

q.sort()

for x in q:
	L.append(["C" + str(count).zfill(4),x])
	count+= 1

##########
d.clear()

while len(q)!=0:
	ele = q.pop().split('.')
	for x in lst:
		m = x.split('.')
		if len(m)>=3 and ele[0] == m[0] and ele[1] == m[1] and (ele[0]+'.'+m[1]+'.'+m[2]) not in d:
			q.append(m[0]+'.'+m[1]+'.'+m[2])
			d.add(m[0]+'.'+m[1]+'.'+m[2])

q = list (d)

q.sort()

for x in q:
	L.append(["C" + str(count).zfill(4),x])
	count+= 1

############
d.clear()

while len(q)!=0:
	ele = q.pop().split('.')
	for x in lst:
		m = x.split('.')
		if (len(ele)<len(m)):
			flag = 1
			for i in range (len(ele)):
				if m[i]!=ele[i]:
					flag = 0
					break
			if flag and (ele[0]+'.'+m[1]+'.'+m[2]+'.'+m[3]) not in d:
				q.append(m[0]+'.'+m[1]+'.'+m[2]+'.'+m[3])
				d.add(m[0]+'.'+m[1]+'.'+m[2]+'.'+m[3])


		if len(m)>=4 and ele[0] == m[0] and ele[1] == m[1] and ele[2] == m[2] and (ele[0]+'.'+m[1]+'.'+m[2]+'.'+m[3]) not in d:
			q.append(m[0]+'.'+m[1]+'.'+m[2]+'.'+m[3])
			d.add(m[0]+'.'+m[1]+'.'+m[2]+'.'+m[3])

q = list(d)

q.sort()


for x in q:
	L.append(["C" + str(count).zfill(4),x])
	count+= 1

L1 = []
for x in L:
	L1.append([x[1],x[0]])

L1.sort(key = lambda L1: L1[0]) 


with open('category-ids.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in L1:
		wr.writerow(x)
