#03_datascript
require(plyr)
require(dplyr)
require(tidyverse)
require(ggplot2)

####
df <- read.csv("hickey_reu_annotated.csv")

df %>%
  group_by(stand, status) %>%
  summarise_all(mean) -> df2

df2 <- data.frame(df2)

ggplot(df2, aes(x = age, y = clumping.index, color = status))+
  geom_point()+
  geom_smooth(method = "lm")

lm.rugosity <- lm(rugosity ~ age, data = df2)
  
summary(lm.rugosity)
  
  

require(randomForest)


laura.fit <- randomForest(status * as.factor(age) ~  mean.height +	height.2 + mean.height.var +	mean.height.rms +	mode.el +	max.el + mode.2 + max.can.ht	+ mean.max.ht +	mean.vai +	mean.peak.vai +	deep.gap.fraction + porosity	+	rugosity +
                            top.rugosity + sky.fraction	+ rumple +	clumping.index +	enl,
                         data = df2,
                         importance = TRUE,
                         ntree = 2000)
#model fit
laura.fit

# Importance of each predictor.
print(importance((laura.fit)) )

# This plots eveything
varImpPlot(laura.fit)

# View the forest results.




