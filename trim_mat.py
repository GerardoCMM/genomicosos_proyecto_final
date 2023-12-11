from Bio import SeqIO

import sys

file = sys.argv[1]

in_loc = int(sys.argv[2])

end_loc = int(sys.argv[3])

seqs = SeqIO.parse(open(file),format="fasta")

for seq in seqs:
    print(">"+seq.description)
    print(seq.seq[in_loc:end_loc])

