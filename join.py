from Bio import SeqIO

uno = SeqIO.parse(open("matK_at.fasta"),format="fasta")
dos = SeqIO.parse(open("rbcL_at.fasta"),format="fasta")
tre = SeqIO.parse(open("trnT_at.fasta"),format="fasta")

ids=[]
unoseq=[]
dosseq=[]
treseq=[]

for seq in uno:
    unoseq.append(seq.seq)

for seq in dos:
    ids.append(seq.id.split(" ")[0].replace(".",""))
    dosseq.append(seq.seq)
    
for seq in tre:
    treseq.append(seq.seq)

for num in range(41):
    print(">"+ids[num])
    print(unoseq[num]+dosseq[num]+treseq[num])

    