#test

#dependencies
require(tidyverse)
require(ggplot2)

#import data
df <- read.csv("./data/laura.csv")

#structure of data frame
str(df)

#historgram
x11()
hist(df$DBH, breaks = seq(0, 40, by = 5))


######
ggplot(df, aes(x = DBH))+ 
  geom_histogram(binwidth = 0.5,
                 color = "red", 
                 fill = "#FF69B4", 
                 alpha = .5)+
  theme_bw()+
  xlab("Stupid Trees")+
  ylab("")+
  facet_grid( .~ Plot)
  

##########
df$ba <- ((df$DBH/2)^2) * pi 

head(df)

###
df %>%
  group_by(Plot, Species) %>%
  summarise(max(ba))

#####
# find out the unique plots we have
unique(df$Plot)

# make a list of data frames where each is a unique plot
big.boi <- split(df, df$Plot)

# Let's look at the total range
range(df$DBH)

# make the breaks that we want for DBH
breaks <- seq(0, 40, by = 5)


# loop through em all
x <- cut(big.boi[[i]][[4]], breaks, right = FALSE)

dbh.freq <- table(dbh.class)

y <- data.frame(dbh.freq)
