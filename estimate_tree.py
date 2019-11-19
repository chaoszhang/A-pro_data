import os
import sys
import numpy as np

f500 = open(sys.argv[2], "w")
f100 = open(sys.argv[3], "w")
runname = sys.argv[4]
with open(sys.argv[1], "r") as ins:
	for line in ins:
		A, C, G, T = np.random.dirichlet((36, 26, 28, 32))
		t = np.random.dirichlet((16, 3, 5, 5, 6, 15))
		t /= t[5]
		a, b, c, d, e, f = t
		with open(runname + "control.txt", "w") as fout:
			print >>fout, "[TYPE] NUCLEOTIDE 1"
			print >>fout, "[MODEL] modelname"
			print >>fout, "  [submodel] GTR", a, b, c, d, e
			print >>fout, "  [statefreq]", T, C, A, G
			print >>fout, "[TREE] treename", line
			print >>fout, "[PARTITIONS] partitionname"
			print >>fout, "  [treename modelname 500]"
			print >>fout, "[EVOLVE] partitionname 1 " + runname
		os.system("echo '" + runname + "control.txt' | ./indelible > /dev/null")
	        f500.write(os.popen("./fasttree -nt -gtr -nopr -gamma " + runname + ".fas 2> /dev/null").read())
		with open(runname + ".fas", "r") as fin:
			with open(runname + "short.fas", "w") as fout:
				for line in fin:
					arr = line.split()
					if len(line) == 0 or len(arr) == 0:
						continue
					t = arr[0]
					print >>fout, t[:100] if len(t) > 100 else t
		f100.write(os.popen("./fasttree -nt -gtr -nopr -gamma " + runname + "short.fas 2> /dev/null").read())
		
