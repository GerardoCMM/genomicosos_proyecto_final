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

## Graficar

# Se cambian los valores de estos dos objetos para comparar distintos caracteres

c_1 <- 7

c_2 <- 8

object <- plotTree.datamatrix(tree2,characters[,c(c_1,c_2)],fsize=0.5,yexp=1,
                              header=FALSE,xexp=1.45,palettes=c ("YlOrRd", "PuBuGn"))

# Cambiando la descripción de lo q es el caracter

leg<-legend(x="topright",legend=names(object$colors[[1]]),
  cex=0.7,pch=22,pt.bg=object$colors[[1]],
  pt.cex=1.5,bty="n",title="Entero")

leg<-legend(x="right",names(object$colors[[2]]),
            cex=0.7,pch=22,pt.bg=object$colors[[2]],
            pt.cex=1.5,bty="n",title="Tricomas")

# Modelo de correlación

species  <- c()

tree_mod <- drop.tip(tree2,species)

char_1 <- factor(characters[!rownames(characters)%in%species,c_1],levels = c(0,1))

names(char_1) <- rownames(characters[!rownames(characters)%in%species,])

char_2 <- factor(characters[!rownames(characters)%in%species,c_2],levels = c(0,1))

names(char_2) <- names(char_1)

cor_fit <- fitPagel(tree_mod,char_1,char_2)

plot(cor_fit,signif=4,cex.main=1,
      cex.sub=0.8,cex.traits=0.7,cex.rates=0.7,
      lwd=1)

# With MCMC

ngen <- 2e6

mat <- characters[tree_mod$tip.label,c(c_1,c_2)]

mat[,1] <- factor(mat[,1],levels=c(1,0))

mat[,2] <- factor(mat[,2],levels=c(1,0))

mcmc_fern <- threshBayes(tree_mod,mat,type=c ("disc", "disc"),
                         ngen=ngen, plot=FALSE,
                         control=list (print.interval=ngen/10))

plot(mcmc_fern)

par(mar=c(5.1,4.1,2.1,2.1),mfrow=c(1,1))

plot(density(mcmc_fern),cex.lab=0.8, cex.axis=0.7)

r.mcmc <- tail(mcmc_fern$par$r,0.8*nrow(mcmc_fern$par))

class(r.mcmc) <- "mcmc"

HPDinterval(r.mcmc,prob = 0.9)













