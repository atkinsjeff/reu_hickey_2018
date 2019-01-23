# this file uses the plot level relative growth rates to calculate plot NPP
require(tidyverse)
require(ggplot2)
#tree dbh data
dbh <- read.csv("./data/planted_pine_dbh_master.csv")

#plot rgr data
rgr <- read.csv("plot_rgr.csv")

#merged
dbh2 <- merge(dbh, rgr)

#
dbh2$anpp <- dbh2$dbh_cm_18 * dbh2$plot.rgr


#########
# allometries
a.pire <- 0.0778
b.pire <- 2.4171

a.quru <- 0.1335
b.quru <- 2.4220

a.prpe <- 0.1556
b.prpe <- 2.1948

# PIRE
dbh %>%
  filter(species == "PIRE") -> dbh.pire

# Biomass = kg (Perala and Alban, 1994 for PIRE and QURU)
# make biomass calculations
dbh.pire$bio18 <- a.pire * (dbh.pire$dbh_cm_18^b.pire)

# prpe
dbh %>%
  filter(species == "PRPE") -> dbh.prpe

head(rpl.prpe)
# Biomass = kg (Perala and Alban, 1994 for PIRE and prpe)
# make biomass calculations
dbh.prpe$bio18 <- a.prpe * (dbh.prpe$dbh_cm_18^b.prpe)

# prpe
dbh %>%
  filter(species == "QURU") -> dbh.quru

# make biomass calculations
dbh.quru$bio18 <- a.quru * (dbh.quru$dbh_cm_18^b.quru)

#
dbh3 <- rbind(dbh.pire, dbh.prpe, dbh.quru)

#
dbh4 <- merge(dbh3, rgr)

#merging
dbh4$anpp <- dbh4$bio18 * dbh4$plot.rgr

#### summing up
dbh4 %>%
  group_by(plot, stand) %>%
  summarize(anpp = sum(anpp)) -> plot.npp

plot.npp <- data.frame(plot.npp)

plot.npp$anpp.c.ha <- plot.npp$anpp * 5


write.csv(plot.npp, "laura_2018_plot_npp.csv")


### basic stand box plot
x11()
ggplot(plot.npp, aes(x = stand, y = anpp.c.ha)) + 
  geom_boxplot()+
  ylab(expression(NPP[W]))


####
comp <- read.csv("laura_2018_plot_npp_with_old.csv")

x11()
ggplot(comp, aes(x = old_anpp, y = anpp, color = stand))+
  geom_point(size = 2)




