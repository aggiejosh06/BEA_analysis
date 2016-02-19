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
pce_table <- read.csv("pce.csv", header = TRUE, skip = 4, nrows = 1)
pce_table <- pce_table %>% select(-c(1:42,89))
colnames(pce_table) <- gsub("X", "", colnames(pce_table))

year_range <- colnames(pce_table)

pce_vector <- c()
for(i in 1:ncol(pce_table)) {
        pce_vector[i] <- pce_table[1,i]
}
names(pce_vector) <- year_range

# first_seven <- rep(0,7)
# pce_vector <- c(first_seven, pce_vector)

# pce_years <- colnames(pce_vector)
# pce_vector <- as.numeric(pce_vector[1,])
# names(pce_vector) <- pce_years

pce_test <- rep(2, 46)