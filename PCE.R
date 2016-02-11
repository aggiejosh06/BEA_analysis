# Overview --------------------
# Creates price index

setwd("~/client work/wayne day/input/PCE/")
require(dplyr)

pce <- read.csv("pce.csv", header = TRUE, skip = 4, nrows = 1)
pce <- pce %>% select(-c(1:2))
colnames(pce) <- gsub("X", "", colnames(pce))
year <- colnames(pce)
pce <- t(pce)
colnames(pce) <- c("index")
pce <- as.data.frame(pce)
pce <- cbind(year, pce)
rownames(pce) <- c()
pce <- pce %>% filter(year %in% seq(from = 1969, to = 2014, by = 1))

#My attempt to go the vector route...
#pce_vector <- read.csv("pce.csv", header = TRUE, skip = 4, nrows = 1)
#pce_vector <- pce_vector %>% select(-c(1:2))
#colnames(pce_vector) <- gsub("X", "", colnames(pce_vector))
#pce_years <- colnames(pce_vector)
#pce_vector <- as.numeric(pce_vector[1,])
#names(pce_vector) <- pce_years
