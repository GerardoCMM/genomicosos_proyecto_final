# Loading libraries

library(ape)

library(phangorn)

# Selecting model

genes <- c("rbcL","matK","trnT") 

for(gene in genes){

	data <- read.phyDat(paste(gene,"at.fasta",sep="_"), format = "fasta")

	tree <- nj(dist.ml(data)) 

	mt <- modelTest(data,tree)
	
	mt <- mt[order(mt$AIC),]

	write.csv(mt,paste(gene,"mt.csv",sep="_"))
}