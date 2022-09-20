import os
import sys
import json


json_file = sys.argv[1]
#print(json_file)

with open(json_file, 'r') as fh:
	spj = json.load(fh)
	clade_mut = spj['nucMutLabelMapReverse']
	for clade in clade_mut:
		mut_nt = clade_mut[clade]
		for mut in mut_nt:
			print(clade,mut)
