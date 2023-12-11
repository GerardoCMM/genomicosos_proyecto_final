# Cargar paquetes

library(ape)

library(seqinr)

library(tidyr)

# Cargar base de datos

data <- read.csv("./genes.csv")

species <- data$Species[data$rbcL!="_"&data$matK!="_"&data$trnT!="_"&data$Species!="Lemmaphyllum rostratum"&data$Species!="Thylacopteris papillosa"]

genes <- c("rbcL","matK","trnT") 

for(gene in genes){
  acc_num <- data[data$Species%in%species,gene]
  
  sequences <- read.GenBank(acc_num,as.character = TRUE)
  
  IDs <- paste(attr(sequences, "species"), gene, names(sequences),sep =" ")
  
  write.dna(sequences, format = "fasta",append=FALSE, nbcol = 6,
            colsep = " ", colw = 10, file = paste(gene,".fasta",sep=""))
  
  file = read.fasta(file = paste(gene,".fasta",sep=""), seqtype = "DNA",
             as.string = TRUE, forceDNAtolower = FALSE)
    
  write.fasta(sequences = sequences, names = IDs,
              file.out = paste(gene,".fasta",sep=""))
  
}



















