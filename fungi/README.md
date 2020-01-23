Re-analyses of data from: http://www.nature.com/nature/journal/vaop/ncurrent/full/nature08064.html

Used data from http://compbio.mit.edu/candida/families/fams.tar.gz

After extracting, run:

```bash
cat fams/*/*.pep.ml.tree  > pep.ml.trees
bash rename.sh pep.ml.trees > pep.ml.renamed.trees
```

Then, to run A-Pro:

```bash
java -D"java.library.path=/Users/smirarab/workspace/A-pro/ASTRAL-MP/lib" -jar ~/ASTRAL-MP/astral.1.1.2.jar -i pep.ml.renamed.trees -o apro-pep.ml.renamed.tre 2> apr-pep.ml.renamed.log
```

To root:

```bash
cat apro-pep.ml.renamed.tre|nw_reroot - clus cpar > apro-pep.ml.renamed.rerooted.tre
```

fungi-ref.tre is the reference MrBayes tree from the original publication:

