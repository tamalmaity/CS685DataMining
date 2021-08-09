#!/usr/bin/env python

import csv

L = []
cat = {} #categories with id
rev_cat = {}
fin = []
unfin = []
ar_cat = {} #article - category
ar = {} #articles with id

ar['Test'] = 'A5001'
ar_cat['A5001'] = ['C0001']
ar['Netbook'] = 'A5002'
ar_cat['A5002'] = ['C0001']
ar['Christmas'] = 'A5003'
ar_cat['A5003'] = ['C0001']
ar['Sportacus'] = 'A5004'
ar_cat['A5004'] = ['C0001']
ar['C++'] = 'A5005'
ar_cat['A5005'] = ['C0001']
ar['Macedonia'] = 'A5006'
ar_cat['A5006'] = ['C0001']
ar['Usa'] = 'A5007'
ar_cat['A5007'] = ['C0001']
ar['Rss'] = 'A5008'
ar_cat['A5008'] = ['C0001']
ar['Black_ops_2'] = 'A5009'
ar_cat['A5009'] = ['C0001']
ar['Western_Australia'] = 'A5010'
ar_cat['A5010'] = ['C0001']
ar['The_Rock'] = 'A5011'
ar_cat['A5011'] = ['C0001']
ar['Great'] = 'A5012'
ar_cat['A5012'] = ['C0001']
ar['Georgia'] = 'A5013'
ar_cat['A5013'] = ['C0001']
ar['English'] = 'A5014'
ar_cat['A5014'] = ['C0001']
ar['Fats'] = 'A5015'
ar_cat['A5015'] = ['C0001']
ar['Mustard'] = 'A5016'
ar_cat['A5016'] = ['C0001']
ar['Bogota'] = 'A5017'
ar_cat['A5017'] = ['C0001']
ar['The'] = 'A5018'
ar_cat['A5018'] = ['C0001']
ar['Rat'] = 'A5019'
ar_cat['A5019'] = ['C0001']
ar['Kashmir'] = 'A5020'
ar_cat['A5020'] = ['C0001']


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
				count+=1
				continue
			
			fin.append([ar[line[0]], ar[line[len(line)-1]]])

		count+= 1

count = 0
bogus = []

with open("paths_unfinished.tsv") as tsvfile:
	tsvreader = csv.reader(tsvfile)
	for line in tsvreader:
		if count>=17:
			src = line[0].split('\t')[3].split(';')[0]
			dest = line[0].split('\t')[4]

			'''
			if dest not in ar:
				print(line[0], dest)
				bogus.append(dest)
			if line[0] not in ar:
				print(line[0],dest)
				bogus.append(dest)
				'''
			if src == 'Long_peper':
				src = 'Long_pepper'
			if dest == 'Long_peper':
				dest = 'Long_pepper'

			if src == 'Adolph_Hitler':
				src = 'Adolf_Hitler'
			if dest == 'Adolph_Hitler':
				dest = 'Adolf_Hitler'

			if src== 'Podcast':
				src = 'Podcasting'
			if dest== 'Podcast':
				dest = 'Podcasting'

			if src== 'Charlottes_web':
				src = 'Charlotte%27s_Web'
			if dest== 'Charlottes_web':
				dest = 'Charlotte%27s_Web'

			if src == '_Zebra':
				src = 'Zebra'
			if dest == '_Zebra':
				dest = 'Zebra'

				''''
			if src not in ar:
				bogus.append(src)
			elif dest not in ar:
				bogus.append(dest)
				'''
			unfin.append([ar[src], ar[dest]])

		count+= 1


res_fin  = {}
res_unfin = {}

for x in fin:
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
				res_fin[(a,b)]+= 1
			else:
				res_fin[(a,b)] = 1



for x in unfin:
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
			if (a,b) in res_unfin:
				res_unfin[(a,b)]+= 1
			else:
				res_unfin[(a,b)] = 1


ans = {}
for x in res_fin:
	a = res_fin[x]
	b = 0
	if x in res_unfin:
		b = res_unfin[x]
	val1 = round((a*100)/(a+b),4)
	val2 = round((b*100)/(a+b),4)
	ans[x] = [val1,val2]

for x in res_unfin:
	if x not in ans:
		a = res_unfin[x]
		b = 0
		if x in res_fin:
			b = res_fin[x]
		val1 = round((a*100)/(a+b),4)
		val2 = round((b*100)/(a+b),4)
		ans[x] = [val2,val1]


L = []
for x in ans:
	temp = []
	for y in x:
		temp.append(y)
	for y in ans[x]:
		temp.append(y)
	L.append(temp)

L.sort(key = lambda L: [L[0],L[1]])


with open('category-pairs.csv', 'w', newline='') as file:
	wr = csv.writer(file)#,  delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
	for x in L:
		wr.writerow(x)