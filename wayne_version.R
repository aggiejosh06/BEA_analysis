# Overview --------------------
# This script is to serve as a diagnostic when comparing my scripts with Wayne's values. 

setwd("~/client work/wayne day/wayne's work")
require(dplyr)
require(gdata)
setwd("~/client work/wayne day/R scripts/")
source("CA4.R")

# Audit of Non-Inflation Adjusted Values --------------------
all_data_not_inf_adj <- read.xls("CA4_Final.xls", sheet = 18, perl = "/usr/bin/perl", stringsAsFactors = FALSE)

all_data_not_inf_adj_filter <- all_data_not_inf_adj %>% filter(LineCode %in% CA4_raw_linecodes) %>% arrange(GeoFIPS, LineCode) %>% select(-c(1:7))

for (i in 1:ncol(all_data_not_inf_adj_filter)) {
        for (j in 1:nrow(all_data_not_inf_adj_filter)) {
                all_data_not_inf_adj_filter[j, i] <- gsub(",", "", all_data_not_inf_adj_filter[j, i])
        }
}

all_data_not_inf_adj_filter[ , c(1:46)] <- sapply(all_data_not_inf_adj_filter[, c(1:46)], as.numeric)

# Need to make sure the ordering is all correct.
# This outcome should be zero.
sum((all_data_not_inf_adj_filter - CA4_raw[,c(8:53)]) != 0)

# Audit of Inflation Adjusted Values --------------------
all_data_inf_adj <- read.xls("CA4_Final.xls", sheet = 15, perl = "/usr/bin/perl")

# Don't bother filtering for GeoFIPs.
all_data_inf_adj_filter <- all_data_inf_adj %>% filter(LineCode %in% CA4_raw_linecodes) %>% arrange(GeoFIPS, LineCode) %>% select(-c(1:7))

# Compare Wayne's values with my values.
# Note that my PCE values for 2012 - 2014 were up to date so those values are different
test <- all_data_inf_adj_filter - CA4_adjusted[, c(8:53)]
sum((all_data_inf_adj_filter[,c(1:43)] -CA4_adjusted[, c(8:50)] != 0))

# Note: Wayne's output is rounded to the nearest integer.


# Data Integrity Testing --------------------
