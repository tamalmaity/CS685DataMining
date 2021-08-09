#!/usr/bin/env python

import csv
import sys
import networkx as nx 

sys.setrecursionlimit(10**6) 

R = []
L = []
e=[]
mat = []

def dfs(temp, x, vis):
	vis[x[0]] = True
	temp.append(x[0])

	for y in x[1:]:
		if vis[y]==False:
			temp = dfs(temp, L[y-1], vis)

	return temp


def conn_comp():
	vis = [False for i in range(len(L)+1)]
	node = []
	for x in L:
		if vis[x[0]] == False:
			temp = []
			i = 0
			t = dfs(temp,x,vis)

			edge = 0
			for k in t:
				edge = edge+len(L[k-1])-1
			edge = int(edge/2)
			e.append(edge)

			node.append(t)

	return node



if __name__ == "__main__": 
	with open("edges.csv") as f:
		csvreader = csv.reader(f)
		for line in csvreader:
			temp = []
			for x in line:
				s = int(x[1:])
				temp.append(s)
			R.append(temp)


	a = 0
	for x in R:
		if x[0]!=a:
			if x[0]==a+2:
				L.append([a+1])
			L.append(x)
			a = x[0]
		else:
			L[len(L)-1].append(x[1])


	for x in L:
		for y in x[1:]:
			if x[0] not in L[y-1]:
				L[y-1].append(x[0])

	R.clear()

	for x in L:
		if len(x)==1:
			continue
		for y in x:
			if y==x[0]:
				continue
			R.append([x[0],y])


	'''
	L.clear()
	L.append([1,2,3])
	L.append([2,1,5,3])
	L.append([3,1,5,7,2])
	L.append([4,6])
	L.append([5,2,3])
	L.append([6,4])
	L.append([7,3])
	print(L)
	'''

	lst = conn_comp()
	res = []
	count = 0
	for x in lst:
		G = nx.Graph()
		for y in x:
			G.add_node(y)
			for z in L[y-1]:
				G.add_node(z)
				G.add_edge(y,z)
		dia = nx.algorithms.distance_measures.diameter(G,e=None)
		res.append([len(x), e[count], dia])
		count+= 1

res.sort(key = lambda res: res[0]) 

with open ('graph-components.csv', 'w',newline='') as f:
	wr = csv.writer(f)
	for x in res:
		wr.writerow(x)





		
	
