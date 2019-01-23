# pcl processing script
#this script, thanks in part to the indomitable Ben Bond-Lamberty, error checks which files have missing lines.
require(plyr)
require(dplyr)
require(tidyverse)


# require(forestr)
# setwd("./data/pcl")
# 
# files <- list.files(pattern = "*.CSV", full.names = TRUE)
# 
# for(i in seq_along(files)) {
#   filedata <- readLines(files[i])
#   lines_to_skip <- min(which(filedata != "")) - 1
#   cat(i, files[i], lines_to_skip, "\n")
#   x <- read.csv(files[i], skip = lines_to_skip)
# }
# 
# setwd("c:/github/reu_hickey_2018/")

#### 
data_dir <- ("./data/kreider")
process_multi_pcl(data_dir, marker.spacing = 10, max.vai = 8)

# collating data output
output_directory <- "./output/output"

#
library(dplyr)
library(readr)
df <- list.files(path = output_directory, full.names = TRUE) %>%
  lapply(read_csv) %>%
  bind_rows

df <- data.frame(df)
write.csv(df, "hickey_reu.CSV")
####
df <- read.csv("hickey_reu_annotated.csv")

df %>%
  group_by(plot) %>%
  summarise_all(mean) -> df2

df2 <- data.frame(df2)
  


