setwd("~/client work/wayne day/input/CA4/")
require(dplyr)
#I guess I just assume that each state .csv file conforms to the same data structure...
#Consider using data.table()?
#The BEA throws in ALL united states with each individual state .csv file...
#CA4 <- data.frame()
#file.names <- dir(path = "." , pattern = ".csv")
#for(i in 1:length(file.names)) {
#        file <- read.csv(file.names[1], header = FALSE, skip = 1)
#        #file <- file[-seq(nrow(file), by = -1, len = 4),]
#        #file <- droplevels(file)
#        CA4 <- rbind(CA4, file)
#}

ALL <- read.csv("CA4_1969_2014_ALL.csv", header = TRUE)
ALL <- ALL[-seq(nrow(ALL), by = -1, len = 4), ]
layer_one <- ALL %>% filter(GeoFIPS %in% "00000")
layer_two_array <- paste("0",seq(from = 0, to = 9999), sep = "")
layer_two <- ALL %>% filter(GeoFIPS %in% layer_two_array)
rm(layer_two_array)
layer_three <- ALL %>% filter(GeoFIPS %in% seq(from = 10000, to = 49007, by = 1))
ALL <- rbind(layer_one, layer_two, layer_three) 
        