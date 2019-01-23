# working with ltreb data
require(plyr)
require(dplyr)
require(tidyr)
require(ggplot2)
#

#####ltreb data
ltreb.core <- read.csv("./data/ltreb_tree_core.csv")


#get 201 dbh
ltreb.core$dbh16 <- ltreb.core$dbh17 - (( (ltreb.core$growth5mm * 0.1) * 2) /5)

# remote the na values
#ltreb.core <- na.omit(ltreb.core)

#merge with allo
ltreb.core <- merge(ltreb.core, allo, all.x = TRUE)

#make biomass
ltreb.core$bio17 <- ltreb.core$a * (ltreb.core$dbh17^ltreb.core$b)
ltreb.core$bio16 <- ltreb.core$a * (ltreb.core$dbh16^ltreb.core$b)

#delta/anpp/rgr calcs
ltreb.core$anpp <- ltreb.core$bio17 - ltreb.core$bio16

#RGR
ltreb.core$rgr <- ltreb.core$anpp / ltreb.core$bio17

df <- ltreb.core[!is.na(ltreb.core$rgr),]
#sums
df %>%
  group_by(plot, species) %>%
  summarize(plot.rgr = mean(rgr)) -> plot.rgr.ltreb

plot.rgr.ltreb <- data.frame(plot.rgr.ltreb)


######

write.csv(plot.rgr.ltreb, "plot_rgr_ltreb.csv")
