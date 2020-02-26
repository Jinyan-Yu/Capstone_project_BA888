library(dplyr)
library(data.table)
library(lubridate)
library(tidyverse)
data = fread("crash-updated.csv")
data$City_Town_Name = NULL
data$Distance_From_Nearest_Roadway_Intersection = NULL
data$Distance_From_Nearest_Milemarker = NULL
table(data$Road_Surface_Condition)
data = data %>%
  separate("Crash_Date", sep="-", into = c("day", "month", "year"))

write.csv(data,"crash-updated.csv")


