# 01
require(plyr)
require(dplyr)
require(tidyverse)

# import core data
rpl <- read.csv("./data/RPL_Core_Analysis.csv")

# checking data
head(rpl)
str(rpl)

# make dbh2013

rpl$dbh_cm2013 <- rpl$dbh_cm - ( (rpl$five_yr_inc_mm * 0.1) * 2)

# allometries
a.pire <- 0.0778
b.pire <- 2.4171

a.quru <- 0.1335
b.quru <- 2.4220

a.prpe <- 0.1556
b.prpe <- 2.1948

# PIRE
rpl %>%
  filter(species == "PIRE") -> rpl.pire

head(rpl.pire)
# Biomass = kg (Perala and Alban, 1994 for PIRE and QURU)
# make biomass calculations
rpl.pire$bio2013 <- a.pire * (rpl.pire$dbh_cm2013^b.pire)
rpl.pire$bio2018 <- a.pire * (rpl.pire$dbh_cm^b.pire)

# bring back together. And you can do this with all these guys (rpl.quru etc. when you got em)
# rpl.npp <- rpl.pire

# prpe
rpl %>%
  filter(species == "PRPE") -> rpl.prpe

head(rpl.prpe)
# Biomass = kg (Perala and Alban, 1994 for PIRE and prpe)
# make biomass calculations
rpl.prpe$bio2013 <- a.prpe * (rpl.prpe$dbh_cm2013^b.prpe)
rpl.prpe$bio2018 <- a.prpe * (rpl.prpe$dbh_cm^b.prpe)

# prpe
rpl %>%
  filter(species == "QURU") -> rpl.quru

head(rpl.quru)
# Biomass = kg (Perala and Alban, 1994 for PIRE and QURU)
# make biomass calculations
rpl.quru$bio2013 <- a.quru * (rpl.quru$dbh_cm2013^b.quru)
rpl.quru$bio2018 <- a.quru * (rpl.quru$dbh_cm^b.quru)

#
rpl.npp <- rbind(rpl.pire, rpl.prpe, rpl.quru)

rpl.npp$delta.biomass <- rpl.npp$bio2018-rpl.npp$bio2013
rpl.npp$anpp <- rpl.npp$delta.biomass / 5
rpl.npp$rgr <- rpl.npp$anpp / rpl.npp$bio2018

#sums
rpl.npp %>%
  group_by(plot) %>%
  summarize(plot.npp = sum(anpp)) -> plot.npp

rpl.npp %>%
  group_by(plot, species) %>%
  summarize(plot.rgr = mean(rgr)) -> plot.rgr



write.csv(plot.rgr, "plot_rgr.csv")

plot.npp <- data.frame(plot.npp)

plot.rgr <- data.frame(plot.rgr)











##################
# bring in light data
light <- read.csv("./data/hickey_light_data.csv")

# sort it down to just what we need
light %>% 
  select(plot, TAU) -> light.small

light.small$fapar <- 1 - light.small$TAU

df <- merge(light.small, rpl.npp)

df$LUE <- df$anpp / df$fapar

ggplot(df, aes(x = stand, y = LUE))+
  geom_boxplot()







plot(df$fapar, df$anpp)
