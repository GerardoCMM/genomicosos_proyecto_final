setwd("../compu/Proyecto_final/Comparison/")

# Cargar paquetes

library(phytools)
library(phangorn)
library(ape)
library(coda)
library(tidyr)

# Leer datos

tree <- read.tree("tree.tre")

characters <- read.csv("../characters.csv")

rownames(characters) <- characters$Species

characters <- characters[,-1]

characters[sapply(characters, is.character)] <- lapply(characters[sapply(characters, is.character)], 
                                       as.factor)
characters[sapply(characters, is.integer)] <- lapply(characters[sapply(characters, is.integer)], 
                                                       as.factor)

# Retiramos tips sin datos morfológicos

no_in_char <- tree$tip.label[!tree$tip.label%in%rownames(characters)]

tree2 <- drop.tip(tree,no_in_char)

# Ejemplo caracteres 9 y 10

## Graficar

object <- plotTree.datamatrix(tree2,characters[,c(2,3)],fsize=0.5,yexp=1,
                              header=FALSE,xexp=1.45,palettes=c ("YlOrRd", "PuBuGn"))

leg<-legend(x="topright",names(object$colors$X2),
  cex=0.7,pch=22,pt.bg=object$colors$X2,
  pt.cex=1.5,bty="n",title="Deciduous")

leg<-legend(x="right",names(object$colors$X3),
            cex=0.7,pch=22,pt.bg=object$colors$X3,
            pt.cex=1.5,bty="n",title="Shape")

# Modelo de correlación

char_1 <- characters[,2]

names(char_1) <- rownames(characters)

char_2 <- characters[,3]

names(char_2) <- rownames(characters)

cor_fit <- fitPagel(tree2,char_1,char_2)

plot(cor_fit,signif=4,cex.main=1,
      cex.sub=0.8,cex.traits=0.7,cex.rates=0.7,
      lwd=1)

# With MCMC

ngen <- 4e6

mcmc_fern <- threshBayes(tree2,characters[tree2$tip.label,c(2,3)],type=c ("disc", "disc"),
                         ngen=ngen, plot=FALSE,
                         control=list (print.interval=ngen/10))

plot(mcmc_fern)

par(mar=c(5.1,4.1,2.1,2.1),mfrow=c(1,1))

plot(density(mcmc_fern),cex.lab=0.8, cex.axis=0.7)

r.mcmc <- tail(mcmc_fern$par$r,0.8*nrow(mcmc_fern$par))

class(r.mcmc) <- "mcmc"

HPDinterval(r.mcmc)













