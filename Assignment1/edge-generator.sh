#!/usr/bin/env python

import json
import csv

with open('neighbor-districts-modified.json') as f1:
	mod_dist = json.load(f1)

ids = {}
i=0
for x in mod_dist:
	ids[x] = 101+i
	i+= 1

graph = []
for x in mod_dist:
	for y in mod_dist[x]:
		if x<y:
			lst = [ids[x], ids[y]]
			graph.append(lst)

with open('edge-graph.csv', 'w', newline='') as file:
	wr = csv.writer(file, quoting=csv.QUOTE_ALL)
	for x in graph:
		wr.writerow([x])
