# light data
require(plyr)
require(dplyr)
require(ggplot2)

npp.ltreb <- read.csv(("./data/ltreb_npp_output.csv"))

npp.hickey <- read.csv("./data/laura_2018_plot_npp.csv")

npp <- rbind(npp.ltreb, npp.hickey)

#csc data
csc <- read.csv("./data/hickey_reu_annotated.csv")

#bringin strucutral data
npp.csc <- merge(npp, csc, all.x = TRUE)

light <- read.csv("./data/hickey_light_data.csv")

#replace hyphens
light$plot <- gsub("-", "_", light$plot)
light$plot <- as.factor(light$plot)
light$fpar <- 1 - (light$Average.Below.PAR / light$Average.Above.PAR)

#merging light
light %>%
  select(plot, fpar) -> y

#merge
df <- merge(npp.csc, y, all.x = TRUE)

#make lue
df$lue <- 
x11()
ggplot(df, aes(x = rugosity, y = anpp.c.ha, color = stand))+
  geom_point()



