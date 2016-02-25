# Overview --------------------
# This script is designed to make appropriate adjustments to designated line codes.

setwd("~/client work/wayne day/R scripts/")
require(dplyr)
source("CA4_custom_line_codes.R")
source("PCE.R")

# List of linecodes to be inflated.
inf_linecodes <- factor(c('10', '11', '12', '30', '35', '36', '42', '45', '46', '47', '50', '60', '70', '47 / 20', '10 - 47', '(10 - 47) / 20', '50 / 7020', '46 / 20', '45 / 20', '50 / 20', '70 / 20', '(60 - 36 + 42)', '(60 - 36 + 42) / 20', '35 / 7010'))

# Separation of rows. Not all linecodes will be inflated.
CA4_raw_untouched <- CA4_total %>% filter(!(LineCode %in% inf_linecodes))

CA4_raw_to_be_inf <- CA4_total %>% filter(LineCode %in% inf_linecodes)

CA4_raw_inflated <- data.frame()

for(i in 1:nrow(CA4_raw_to_be_inf)) {
        for(j in 1:(ncol(CA4_raw_to_be_inf) - 7)) {
                CA4_raw_inflated[i, j] <- round(CA4_raw_to_be_inf[i,(j + 7)]*(100/pce_vector[j]), digits = 0)
        }
}

# Add back the rows that have been inflated with the rows that were not inflated.
CA4_raw_inflated <- cbind(CA4_raw_to_be_inf[, c(1:7)], CA4_raw_inflated)

colnames(CA4_raw_inflated)[c(8:53)] <- colnames(CA4_raw_untouched)[c(8:53)]

CA4_adjusted <- rbind(CA4_raw_inflated, CA4_raw_untouched)
CA4_adjusted$LineCode <- factor(CA4_adjusted$LineCode, levels = linecode)
CA4_adjusted <- CA4_adjusted %>% arrange(GeoFIPS, LineCode)

rm(inf_linecodes, CA4_raw_untouched, CA4_raw_to_be_inf, CA4_raw_inflated)

# Notes --------------------