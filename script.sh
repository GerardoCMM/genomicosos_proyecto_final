# Get sequences

Rscript get_seqs.R

# Align sequences

mafft --maxiterate 1000 --thread 6 matK.fasta > matK_a.fasta

mafft --maxiterate 1000 --thread 6 rbcL.fasta > rbcL_a.fasta

mafft --maxiterate 1000 --thread 6 trnT.fasta > trnT_a.fasta

# Trimming alignment matrix

python trim_mat.py matK_a.fasta 16 820 > matK_at.fasta

python trim_mat.py rbcL_a.fasta 99 1277 > rbcL_at.fasta

python trim_mat.py trnT_a.fasta 59 884 > trnT_at.fasta

# Joining all alignments into single matrix

python join.py > matrix.fasta

# Matrix size

# matK 804 bp
# rbcL 1178 bp
# trnT 825 bp
# total 2807

# Selecting best model

Rscript select_model.R

# Selected models 

# matK GTR+G
# rbcL GTR+G+I
# trnT GTR+G

# Maximum likelihood as starting tree for BI

raxmlHPC-PTHREADS-SSE3 -T 2 -f d -m GTRGAMMA -N 1 -O -p 935311 -n matrix.tre -s ./matrix.fasta

# Joined matrix was converted to Nexus using MEGA11, trees and mrBayes block added afterwards


# Running mrbayes

mkdir BI

cd BI

cp ../matrix.nexus matrix.nexus

$mrbayes matrix.nexus