library(tidyverse)
uber <- read_csv("rideshare_kaggle.csv")
View(uber)
uber <- uber %>% filter(cab_type=="Uber")


uber %>% group_by(destination) %>% count()
uber %>% group_by(source) %>% count()

uber=uber %>% unite(route, source, destination, sep = "_", remove = TRUE, na.rm = FALSE)


n <- sample(1:nrow(uber), 0.8 * nrow(uber))

uber = uber[n,]

uber %>% group_by(route) %>% count(sort = TRUE)




test =uber %>% filter(route == "Financial District_South Station")
nrow(test)
