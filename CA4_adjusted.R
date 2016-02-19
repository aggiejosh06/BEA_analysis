# Overview --------------------
# This script is designed to make appropriate adjustments to designated line codes.

setwd("~/client work/wayne day/input/CA4/")
require(dplyr)
source("CA4.R")
source("PCE.R")

# List of linecodes to be inflated.
inf_linecodes <- c(10:12, 30, 35:36, 42, 45:47, 50, 60, 70)

CA4_raw_untouched <- CA4_raw %>% filter(!(LineCode %in% inf_linecodes))

CA4_raw_to_be_inf <- CA4_raw %>% filter(LineCode %in% inf_linecodes)

CA4_raw_inflated <- data.frame()

for(i in 1:nrow(CA4_raw_to_be_inf)) {
        for(j in 1:(ncol(CA4_raw_to_be_inf) - 7)) {
                CA4_raw_inflated[i, j] <- round(CA4_raw_to_be_inf[i,(j + 7)]*(100/pce_vector[j]), digits = 0)
        }
}

CA4_raw_inflated <- cbind(CA4_raw_to_be_inf[, c(1:7)], CA4_raw_inflated)

colnames(CA4_raw_inflated)[c(8:53)] <- colnames(CA4_raw_untouched)[c(8:53)]

CA4_adjusted <- rbind(CA4_raw_inflated, CA4_raw_untouched)
CA4_adjusted <- CA4_adjusted %>% arrange(GeoFIPS, LineCode)