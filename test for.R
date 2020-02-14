library(tidyverse)
library(dplyr)
uber <- read_csv("uberresource.csv")
#View(uber)

#uber %>% group_by(destination) %>% count()
#uber %>% group_by(source) %>% count()

uber$route = paste(uber$source, uber$destination, sep = "_")
View(uber)


a=grep(uber$route,pattern = "University")
uber$school = ifelse(uber$X1  %in%  a, 1, 0)


set.seed(777)
n <- sample(1:nrow(uber), 0.7 * nrow(uber))

uber_train = uber[n,]
uber_test = uber[-n,]


uber_train %>% group_by(route) %>% count(sort = TRUE)

write_csv(uber_train, "training set")
write_csv(uber_test, "test set")


View(uber_train)




