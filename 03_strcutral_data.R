#laura script


df <- read.csv("hickey_reu_annotated.csv")

df %>%
  group_by(plot) %>%
  summarise_all(mean) -> df2

df2 <- data.frame(df2)

