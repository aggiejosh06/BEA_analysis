# Overview --------------------
# This script is designed to create the custom line codes used by Wayne

setwd("~/client work/wayne day/R scripts/")
require(dplyr)
source("CA4.R")

# (10 - 47) / 20 --------------------
# Personal income LESS personal current transfers DIVIDED by population
# (Personal income (thousands of dollars) - Personal current transfer receipts)/ Population (persons) * 1,000

lc10 <- CA4_raw %>% filter(LineCode == 10)
lc47 <- CA4_raw %>% filter(LineCode == 47)
lc20 <- CA4_raw %>% filter(LineCode == 20)

outcome <- ((lc10[, c(8:53)] - lc47[, c(8:53)]) / lc20[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("(10 - 47) / 20"), times = nrow(lc10)))
description <- data.frame(Description = rep("Personal income LESS personal current transfers DIVIDED by population", times = nrow(lc10)))
one <- cbind(lc10[,c(1:4)], line_code, lc10[, c(6)], description, outcome)
colnames(one)[6] <- "IndustryClassification"
rm(lc10, lc47, lc20, outcome, line_code, description)

# (63 - 36 + 42) --------------------
# TOTAL of Other Income

lc60 <- CA4_raw %>% filter(LineCode == 60)
lc36 <- CA4_raw %>% filter(LineCode == 36)
lc42 <- CA4_raw %>% filter(LineCode == 42)

outcome <- (lc60[, c(8:53)] - lc36[, c(8:53)] + lc42[, c(8:53)])
line_code <- data.frame(LineCode = rep(as.factor("(60 - 36 + 42)"), times = nrow(lc60)))
description <- data.frame(Description = rep("TOTAL of other income", times = nrow(lc60)))
two <- cbind(lc60[,c(1:4)], line_code, lc60[, c(6)], description, outcome)
colnames(two)[6] <- "IndustryClassification"
rm(lc60, lc36, lc42, outcome, description)

# (63 - 36 + 42) / 20 --------------------
# Total of Other Income Divided by Population 

lc60 <- CA4_raw %>% filter(LineCode == 60)
lc36 <- CA4_raw %>% filter(LineCode == 36)
lc42 <- CA4_raw %>% filter(LineCode == 42)
lc20 <- CA4_raw %>% filter(LineCode == 20)

outcome <- ((lc60[, c(8:53)] - lc36[, c(8:53)] + lc42[, c(8:53)]) / lc20[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("(60 - 36 + 42) / 20"), times = nrow(lc60)))
description <- data.frame(Description = rep("TOTAL of other income DIVIDED by Population", times = nrow(lc60)))
three <- cbind(lc60[,c(1:4)], line_code, lc60[, c(6)], description, outcome)
colnames(three)[6] <- "IndustryClassification"
rm(lc60, lc36, lc42, lc20, outcome, description)

# 10 - 47 --------------------
# Personal income LESS personal current transfers 
# Personal income (thousands of dollars) - Personal current transfer receipts

lc10 <- CA4_raw %>% filter(LineCode == 10)
lc47 <- CA4_raw %>% filter(LineCode == 47)

outcome <- lc10[, c(8:53)] - lc47[, c(8:53)]
line_code <- data.frame(LineCode = rep(as.factor("10 - 47"), times = nrow(lc10)))
description <- data.frame(Description = rep("Personal income LESS personal current transfers", times = nrow(lc10)))
four <- cbind(lc10[,c(1:4)], line_code, lc10[, c(6)], description, outcome)
colnames(four)[6] <- "IndustryClassification"
rm(lc10, lc47, outcome, line_code, description)

# 35 / 7010 --------------------
# Earned income over total employment

lc35 <- CA4_raw %>% filter(LineCode == 35)
lc7010 <- CA4_raw %>% filter(LineCode == 7010)

outcome <- (lc35[, c(8:53)] / lc7010[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("35 / 7010"), times = nrow(lc35)))
description <- data.frame(Description = rep("Earnings by place of work DIVIDED BY Total Employment", times = nrow(lc35)))
five <- cbind(lc35[,c(1:4)], line_code, lc35[, c(6)], description, outcome)
colnames(five)[6] <- "IndustryClassification"
rm(lc35, lc7010, outcome, line_code, description)

# 46 / 20 --------------------
# Earned income over total employment

lc46 <- CA4_raw %>% filter(LineCode == 46)
lc20 <- CA4_raw %>% filter(LineCode == 20)

outcome <- (lc46[, c(8:53)] / lc20[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("46 / 20"), times = nrow(lc46)))
description <- data.frame(Description = rep("Dividends, interest, and rent DIVIDED BY Population", times = nrow(lc46)))
six <- cbind(lc46[,c(1:4)], line_code, lc46[, c(6)], description, outcome)
colnames(six)[6] <- "IndustryClassification"
rm(lc46, lc20, outcome, line_code, description)

# 47 / 20 --------------------
# Earned income over total employment

lc47 <- CA4_raw %>% filter(LineCode == 47)
lc20 <- CA4_raw %>% filter(LineCode == 20)

outcome <- (lc47[, c(8:53)] / lc20[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("47 / 20"), times = nrow(lc47)))
description <- data.frame(Description = rep("Personal current transfer receipts DIVIDED BY Population
", times = nrow(lc47)))
seven <- cbind(lc47[,c(1:4)], line_code, lc47[, c(6)], description, outcome)
colnames(seven)[6] <- "IndustryClassification"
rm(lc47, lc20, outcome, line_code, description)

# 50 / 20 --------------------
# Earned income over total employment

lc50 <- CA4_raw %>% filter(LineCode == 50)
lc20 <- CA4_raw %>% filter(LineCode == 20)

outcome <- (lc50[, c(8:53)] / lc20[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("50 / 20"), times = nrow(lc50)))
description <- data.frame(Description = rep("Wages and salaries DIVIDED BY Population", times = nrow(lc50)))
eight <- cbind(lc50[,c(1:4)], line_code, lc50[, c(6)], description, outcome)
colnames(eight)[6] <- "IndustryClassification"
rm(lc50, lc20, outcome, line_code, description)

# 70 / 20 --------------------
# Earned income over total employment

lc70 <- CA4_raw %>% filter(LineCode == 70)
lc20 <- CA4_raw %>% filter(LineCode == 20)

outcome <- (lc70[, c(8:53)] / lc20[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("70 / 20"), times = nrow(lc70)))
description <- data.frame(Description = rep("Proprietors' income 9/ DIVIDED BY Population", times = nrow(lc70)))
nine <- cbind(lc70[,c(1:4)], line_code, lc70[, c(6)], description, outcome)
colnames(nine)[6] <- "IndustryClassification"
rm(lc70, lc20, outcome, line_code, description)

# 45 / 20 --------------------
# Earned income over total employment

lc45 <- CA4_raw %>% filter(LineCode == 45)
lc20 <- CA4_raw %>% filter(LineCode == 20)

outcome <- (lc45[, c(8:53)] / lc20[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("45 / 20"), times = nrow(lc45)))
description <- data.frame(Description = rep("Net earnings by place of residence DIVIDED by Population", times = nrow(lc45)))
ten <- cbind(lc45[,c(1:4)], line_code, lc45[, c(6)], description, outcome)
colnames(ten)[6] <- "IndustryClassification"
rm(lc45, lc20, outcome, line_code, description)

# 50 / 7020 --------------------
# Earned income over total employment

lc50 <- CA4_raw %>% filter(LineCode == 50)
lc7020 <- CA4_raw %>% filter(LineCode == 7020)

outcome <- (lc50[, c(8:53)] / lc7020[, c(8:53)]) * 1000
line_code <- data.frame(LineCode = rep(as.factor("50 / 7020"), times = nrow(lc50)))
description <- data.frame(Description = rep("Wages and salaries DIVIDED BY wages and salary employment", times = nrow(lc50)))
eleven <- cbind(lc50[,c(1:4)], line_code, lc50[, c(6)], description, outcome)
colnames(eleven)[6] <- "IndustryClassification"
rm(lc50, lc7020, outcome, line_code, description)

# Combines all custom fields
CA4_custom <- rbind(one, two, three, four, five, six, seven, eight, nine, ten, eleven)

rm(one, two, three, four, five, six, seven, eight, nine, ten, eleven)

# This is for comparison purposes
CA4_total <- rbind(CA4_raw, CA4_custom)
CA4_total2$LineCode <- factor(CA4_total$LineCode, levels = linecode)
CA4_total <- CA4_total %>% arrange(GeoFIPS, LineCode)

# Notes --------------------
# Does 35 / 7010 really need to be multiplied by 1,000?
