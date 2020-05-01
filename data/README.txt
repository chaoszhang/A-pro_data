#Dir Level 1
exp1 for varying n
exp2 for varying k
e3_*_* for dup rate vs loss to dup ratio
e4_*_* for dup rate vs ILS

e3_5_05 means duplication is at 5X level and loss rate is 0.5X duplication rate.
e4_1_50 means duplication is at 1X level and ILS when there is no duplication is 50%.

#Dir Level 2 & 3
For exp1 & exp2, the level 2 directory name mean n and k respectively; the level 3 directories are replicates.
For e3_*_* & e4_*_*, the level 2 directories are replicates.

#File Names
Other than the true species tree s_tree.trees, each tree represents an inferred species tree.
When file name starts with a number k, it means the number of genes is subsampled to k; otherwise k=1000.
If the name of the file contains e100 or e500, then the inputs are estimated gene trees of length 100 or 500; otherwise the inputs are the true gene trees.
