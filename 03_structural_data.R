#laura script
require(ggplot2)
require(corrplot)

x <- read.csv("hickey_reu_annotated.csv")

x %>%
  group_by(plot, status) %>%
  summarise_all(mean) -> df

df <- data.frame(df)

plot(df$age, df$rugosity)

x11()
ggplot(df, aes(x = age, y = rugosity, color = status))+
  geom_point()

# planted
df %>%
  filter(status == "planted") -> df.p

M <- cor(df[, c(3, 5:32)])
x11()
corrplot(M, method = "circle")

#####
reu <- read.csv("REU18_plot_summary.csv")
head(reu)

df.pp <- merge(df.p, reu, by = "plot")

x11()
ggplot(df.pp, aes(y = age.x, x = mean.max.ht))+
  geom_point()

