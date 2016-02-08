setwd("~/client work/wayne day/input/CA4/")
#I guess I just assume that each state .csv file conforms to the same data structure...
CA4 <- data.frame()
file.names <- dir(path = "." , pattern = ".csv")
for(i in 1:length(file.names)) {
        file <- read.csv(file.names[1], header = FALSE, skip = 1)
        file <- file[-seq(nrow(file), by = -1, len = 4),]
        file <- droplevels(file)
        CA4 <- rbind(CA4, file)
}