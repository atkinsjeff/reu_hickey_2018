# ltreb npp file
require(plyr)
require(dplyr)
require(tidyr)
require(ggplot2)

# import ltreb data
ltreb.dbh <- read.csv("./data/dbh_ltreb_2017.csv")

allo <- read.csv("./data/umbs_allometry.csv")

#plot rgr data
rgr.ltreb <- read.csv("./data/plot_rgr_ltreb_jeff_edit.csv")


# merge to get allometries
ltreb <- merge(ltreb.dbh, allo) 

# calculate biomass per tree
ltreb$bio17 <- ltreb$a * (ltreb$dbh17^ltreb$b)

#merge the two
ltreb <- merge(ltreb, rgr.ltreb, all.x = TRUE)

#merging
ltreb$anpp <- ltreb$bio17 * ltreb$plot.rgr

#sorting out na's for now
df <- ltreb[!is.na(ltreb$anpp),]
#sums
#### summing up
df %>%
  group_by(plot, stand) %>%
  summarize(anpp = sum(anpp)) -> plot.npp.ltreb

plot.npp.ltreb <- data.frame(plot.npp.ltreb)

plot.npp.ltreb$anpp.c.ha <- plot.npp.ltreb$anpp * 5

#write output file
write.csv(plot.npp.ltreb, "./data/ltreb_npp_output.csv")


#write.csv(plot.npp, "laura_2018_plot_npp.csv")


### basic stand box plot
x11()
ggplot(plot.npp.ltreb, aes(x = stand, y = anpp.c.ha)) + 
  geom_boxplot()+
  ylab(expression(NPP[W]))


