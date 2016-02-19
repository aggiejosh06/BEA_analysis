# Overview --------------------
# This script is designed to pull data entries directly from the CA4 files provided by the BEA website.

setwd("~/client work/wayne day/input/CA4/")
require(dplyr)

options(stringsAsFactors=FALSE)

# List from Wayne's "All Data Not Inf Adj" tab.
geofips <- factor(c("00000", "01000", "02000", "04000", "05000", "06000", "08000", "09000", "10000", "12000", "12420", "13000", "15000", "15180", "16000", "17000", "18000", "19000", "19100", "19124", "20000", "21000", "21340", "22000", "23000", "23104", "24000", "25000", "26000", "26420", "27000", "28000", "29000", "29700", "30000", "31000", "32000", "32580", "33000", "33260", "34000", "35000", "36000", "36220", "37000", "38000", "39000", "40000", "41000", "41700", "42000", "44000", "45000", "46000", "47000", "48000", "49000", "50000", "51000", "53000", "54000", "55000", "56000", "89154", "89206", "89238", "89288", "89365"))

linecode <- factor(c("10","11","12","20","30","50","7010","7020","47","47 / 20","10 - 47","(10 - 47) / 20","50 / 7020","46", "46 / 20","45","45 / 20","50 / 20","70","70 / 20","36","42","60","(60 - 36 + 42)","(60 - 36 + 42) / 20","35","35 / 7010"))  

# Data Extraction --------------------

# Statewide and national GeoFIPS
ALL <- read.csv("CA4_1969_2014_ALL.csv", header = TRUE)
ALL <- ALL[-seq(nrow(ALL), by = -1, len = 4), ]
# ALL <- ALL %>% filter(GeoFIPS %in% geofips)
# ALL <- droplevels(ALL)

# ALL_geofips <- unique(ALL$GeoFIPS)
# Returns vector checking which geofips are found in ALL_geofips.
# ALL_geofips_used <- ALL_geofips %in% geofips
# ALL_geofips <- ALL_geofips[ALL_geofips_used]
# ALL_geofips_used_sum <- sum(ALL_geofips_used)

# MSAs
MSA <- read.csv("CA4_1969_2014_MSA.csv", header = TRUE)
MSA <- MSA[-seq(nrow(MSA), by = -1, len = 4), ]
# MSA <- MSA %>% filter(GeoFIPS %in% geofips)

# MSA_geofips <- unique(MSA$GeoFIPS)
# Returns vector checking which geofips are found in ALL_geofips.
# MSA_geofips_used <- MSA_geofips %in% geofips
# MSA_geofips <- MSA_geofips[MSA_geofips_used]
# MSA_geofips_used_sum <- sum(MSA_geofips_used)

# Metropolitan Divisions
MDIV <- read.csv("CA4_1969_2014_MDIV.csv", header = TRUE)
MDIV <- MDIV[-seq(nrow(MDIV), by = -1, len = 4), ]
# MDIV <- MDIV %>% filter(GeoFIPS %in% geofips)

# MDIV_geofips <- unique(MDIV$GeoFIPS)
# Returns vector checking which geofips are found in ALL_geofips.
# MDIV_geofips_used <- MDIV_geofips %in% geofips
# MDIV_geofips <- MDIV_geofips[MDIV_geofips_used]
# MDIV_geofips_used_sum <- sum(MDIV_geofips_used)

# Combined Statistical Areas
CSA <- read.csv("CA4_1969_2014_CSA.csv", header = TRUE)
CSA <- CSA[-seq(nrow(CSA), by = -1, len = 4), ] 
# CSA <- CSA %>% filter(GeoFIPS %in% geofips)

# CSA_geofips <- unique(CSA$GeoFIPS)
# Returns vector checking which geofips are found in ALL_geofips.
# CSA_geofips_used <- CSA_geofips %in% geofips
# CSA_geofips <- CSA_geofips[CSA_geofips_used]
# CSA_geofips_used_sum <- sum(CSA_geofips_used)

# total_geofips_used <- sum(ALL_geofips_used_sum, TX_geofips_used_sum, MDIV_geofips_used_sum, CSA_geofips_used_sum)

# Combines tables above
CA4_raw <- rbind(ALL, MSA, MDIV, CSA)

# Data Transformation --------------------

CA4_raw <- CA4_raw %>% filter(GeoFIPS %in% geofips, LineCode %in% linecode) %>% arrange(GeoFIPS, LineCode)
CA4_raw[ , c(1:7)] <- lapply(CA4_raw[ , c(1:7)], as.factor)
CA4_raw[ , c(8:53)] <- sapply(CA4_raw[ , c(8:53)], as.numeric)

for(i in 1:53) {
        colnames(CA4_raw)[i] <- gsub("X","", colnames(CA4_raw[,c(1:53)]))[i]
}

CA4_raw_geofips <- unique(CA4_raw$GeoFIPS)
CA4_raw_linecodes <- unique(CA4_raw$LineCode)
  
# Notes --------------------

# Consider using data.table()?
# Is region used for anything useful?
