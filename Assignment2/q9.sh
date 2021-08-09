#!/usr/bin/env python

import csv
import networkx as nx 

L = []
d = {} # article name -> article id
c = {} # article id -> cat id
cat = {}
rev_cat = {}

num = 1
with open("article-ids.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		d[line[0]] = num
		num+= 1

with open("category-ids.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		cat[line[1]] = line[0]
		rev_cat[line[0]] = line[1]


with open("article-categories.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		temp = []
		for x in range (len(line)):
			if x==0:
				continue
			s = int(line[x][1:])  
			temp.append(s)
		c[int(line[0][1:])] = temp



count = 1
path = [] #one entry is like [4595, 1695, 2245]

with open("paths_finished.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile)
	for line in tsvreader:
		if count>=17:
			line = line[0].split('\t')[3]
			line = line.split(';')
			if (count == 2412):
				count+= 1
				continue

			if len(line)==1:
				count+= 1
				continue

			temp = []
			'''
			for x in line:
				temp.append(x)
			temp.reverse()
			t = []
			for x in range(len(temp)):
				if temp[x]=='<':
					x+=1
					continue
				t.append(temp[x])
			t.reverse()
			new_t = []
			for x in t:
				new_t.append(d[x])
			path.append(new_t)
			'''

			for x in line:
				if x =='<':
					temp.pop()
				else:
					temp.append(x)

			for i in range(len(temp)):
				temp[i] = d[temp[i]]

			path.append(temp)


		count+= 1


human_path_num = [0 for i in range (147)]
human_path_times = [0 for i in range (147)]

for x in path:
	real_set = set()
	se = set()
	for y in x:
		s = set()
		for z in c[y]:
			se.add(z)
			string = cat["C"+str(z).zfill(4)]
			string = string.split('.')
			now = string[0]
			s.add(now)
			for j in range(1,len(string)):
				now = now + '.' + string[j]
				s.add(now)
			
		for i in s:
			human_path_times[int(rev_cat[i][1:])]+= 1

	for i in se:
		name = cat["C"+str(i).zfill(4)]
		name = name.split('.')
		now = name[0]
		real_set.add(now)
		for j in range (1,len(name)):
			now = now + '.' + name[j]
			real_set.add(now)

	for i in real_set:
		human_path_num[int(rev_cat[i][1:])]+= 1

short = []
for x in path:
	short.append([x[0], x[len(x)-1]])


G = nx.DiGraph()  #directed graph

ed = []

with open("edges.csv") as f:
	csvreader = csv.reader(f)
	for line in csvreader:
		ed.append([int(line[0][1:]), int(line[1][1:])])

for i in range(len(d)):
	G.add_node(i+1)

for x in ed:
	G.add_edge(x[0], x[1])

short_path = []

for x in short:
	lst = nx.shortest_path(G,source=x[0],target=x[1])
	short_path.append(lst)


short_path_num = [0 for i in range (147)]
short_path_times = [0 for i in range (147)]

for x in short_path:
	real_set = set()
	se = set()
	for y in x:
		s = set()
		for z in c[y]:
			se.add(z)
			string = cat["C"+str(z).zfill(4)]
			string = string.split('.')
			now = string[0]
			s.add(now)
			for j in range(1,len(string)):
				now = now + '.' + string[j]
				s.add(now)
			
		for i in s:
			short_path_times[int(rev_cat[i][1:])]+= 1

	for i in se:
		name = cat["C"+str(i).zfill(4)]
		name = name.split('.')
		now = name[0]
		real_set.add(now)
		for j in range (1,len(name)):
			now = now + '.' + name[j]
			real_set.add(now)

	for i in real_set:
		short_path_num[int(rev_cat[i][1:])]+= 1


res = []
for x in range(len(human_path_times)):
	if x==0:
		continue
	res.append(["C"+ str(x).zfill(4), human_path_num[x], human_path_times[x],
		short_path_num[x], short_path_times[x]])

with open('category-subtree-paths.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in res:
		wr.writerow(x)