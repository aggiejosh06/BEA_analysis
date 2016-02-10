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

options(stringsAsFactors=FALSE)

#List from Wayne's "All Data Not Inf Adj" tab.
geofips <- factor(c("00000", "01000", "02000", "04000", "05000", "06000", "08000", "09000", "10000", "12000", "12420", "13000", "15000", "15180", "16000", "17000", "18000", "19000", "19100", "19124", "20000", "21000", "21340", "22000", "23000", "23104", "24000", "25000", "26000", "26420", "27000", "28000", "29000", "29700", "30000", "31000", "32000", "32580", "33000", "33260", "34000", "35000", "36000", "36220", "37000", "38000", "39000", "40000", "41000", "41700", "42000", "44000", "45000", "46000", "47000", "48000", "49000", "50000", "51000", "53000", "54000", "55000", "56000", "89154", "89206", "89238", "89288", "89365"))

linecode <- factor(c("10","11","12","20","30","50","7010","7020","47","47 / 20","10 - 47","(10 - 47) / 20","50 / 7020","46", "46 / 20","45","45 / 20","50 / 20","70","70 / 20","36","42","60","(60 - 36 + 42)","(60 - 36 + 42) / 20","35","35 / 7010"))  

#This list will pull the statewide and national GeoFIPS
ALL <- read.csv("CA4_1969_2014_ALL.csv", header = TRUE)
ALL <- ALL[-seq(nrow(ALL), by = -1, len = 4), ]
#ALL <- ALL %>% filter(GeoFIPS %in% geofips)
#ALL <- droplevels(ALL)

ALL_geofips <- unique(ALL$GeoFIPS)
#Returns vector checking which geofips are found in ALL_geofips.
ALL_geofips_used <- ALL_geofips %in% geofips
ALL_geofips <- ALL_geofips[ALL_geofips_used]
ALL_geofips_used_sum <- sum(ALL_geofips_used)

#This list will pull the Texas MSAs
TX <- read.csv("CA4_1969_2014_MSA.csv", header = TRUE)
TX <- TX[-seq(nrow(TX), by = -1, len = 4), ]
#TX <- TX %>% filter(GeoFIPS %in% geofips)

TX_geofips <- unique(TX$GeoFIPS)
#Returns vector checking which geofips are found in ALL_geofips.
TX_geofips_used <- TX_geofips %in% geofips
TX_geofips <- TX_geofips[TX_geofips_used]
TX_geofips_used_sum <- sum(TX_geofips_used)

#Pulls from Metropolitan Divisions
MDIV <- read.csv("CA4_1969_2014_MDIV.csv", header = TRUE)
MDIV <- MDIV[-seq(nrow(MDIV), by = -1, len = 4), ]
#MDIV <- MDIV %>% filter(GeoFIPS %in% geofips)

MDIV_geofips <- unique(MDIV$GeoFIPS)
#Returns vector checking which geofips are found in ALL_geofips.
MDIV_geofips_used <- MDIV_geofips %in% geofips
MDIV_geofips <- MDIV_geofips[MDIV_geofips_used]
MDIV_geofips_used_sum <- sum(MDIV_geofips_used)

#Pulls from Combined Statistical Areas
CSA <- read.csv("CA4_1969_2014_CSA.csv", header = TRUE)
CSA <- CSA[-seq(nrow(CSA), by = -1, len = 4), ] 
#CSA <- CSA %>% filter(GeoFIPS %in% geofips)

CSA_geofips <- unique(CSA$GeoFIPS)
#Returns vector checking which geofips are found in ALL_geofips.
CSA_geofips_used <- CSA_geofips %in% geofips
CSA_geofips <- CSA_geofips[CSA_geofips_used]
CSA_geofips_used_sum <- sum(CSA_geofips_used)

total_geofips_used <- sum(ALL_geofips_used_sum, TX_geofips_used_sum, MDIV_geofips_used_sum, CSA_geofips_used_sum)

#Combines pulls above to one big table.
CA4_raw <- rbind(ALL, TX, MDIV, CSA)
CA4_raw <- CA4_raw %>% filter(GeoFIPS %in% geofips)
CA4_raw$GeoFIPS <- factor(CA4_raw$GeoFIPS)

CA4_raw_geofips <- unique(CA4_raw$GeoFIPS)
CA4_raw_LineCode <- unique(CA4_raw$LineCode)

layer_one <- ALL %>% filter(GeoFIPS %in% "00000")
layer_two_array <- paste("0",seq(from = 0, to = 9999), sep = "")
layer_two <- ALL %>% filter(GeoFIPS %in% layer_two_array)
layer_three <- ALL %>% filter(GeoFIPS %in% seq(from = 10000, to = 49007, by = 1))
ALL <- rbind(layer_one, layer_two, layer_three) 
rm(layer_one, layer_two, layer_two_array, layer_three)
ALL <- droplevels(ALL)



ALL <- ALL %>% filter(LineCode %in% c(10:12,20,30,42,45:47,50,60,70,7010,7020))
x = c()
for(i in seq_along(geofips)){
      x[1] <- paste(geofips[i], sep = ",")  
}
        