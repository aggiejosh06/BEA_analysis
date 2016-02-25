require(dplyr)
setwd('~/client work/wayne day/R scripts/')
source('CA4_adjusted.R')

YoY <- data.frame()
for(i in 1:nrow(CA4_adjusted)) {
        for(j in 1:7) {
                YoY[i,j] <- CA4_adjusted[i,j]
        }
}
YoY[ , 8] <- rep(0, nrow(CA4_adjusted))
for(i in 1:nrow(CA4_adjusted)) {
        for(k in 9:53) {
                YoY[i, k] <- ((CA4_adjusted[i, k] - CA4_adjusted[i, k - 1]) / CA4_adjusted[i, k - 1]) * 100 
        }
}
colnames(YoY) <- colnames(CA4_adjusted)