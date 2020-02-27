library(dplyr)
library(data.table)
library(lubridate)
library(tidyverse)
library(reshape2)
data = fread("crash-updated.csv")
data$City_Town_Name = NULL
data$Distance_From_Nearest_Roadway_Intersection = NULL
data$Distance_From_Nearest_Milemarker = NULL
table(data$Road_Surface_Condition)
data = data %>%
  separate("Crash_Date", sep="-", into = c("day", "month", "year"))

write.csv(data,"crash-updated.csv")

data = fread("crash-updated.csv")
data01 = data %>% filter(!Crash_Severity %in% c('Unknown',
                                                'Not Reported'),
                         !Maximum_Injury_Severity_Reported %in%
                           c('Unknown',
                             'Not Reported'),
                         !Manner_of_Collision %in%
                           c('Unknown','Not Reported'))

# hist for the manner of collision 
data01 %>% group_by(Manner_of_Collision)%>%
  count() %>% ungroup() %>% 
  mutate(Manner_of_Collision = reorder(Manner_of_Collision, n)) %>% 
  ggplot(aes(Manner_of_Collision,n))+
  geom_bar(stat = 'identity')+
  coord_flip()+ 
  labs(x = 'frequency',
       title = 'Hist of each manner of collision') +
  geom_text(aes(label = n),vjust = 0.1)

# number of vehicle v.s. number of injury 
data02 = melt(data01, id.vars = 'Number_of_Vehicles', 
              measure.vars = c('Total_Nonfatal_Injuries',
                               'Total_Fatal_Injuries'))
data02 = data02 %>% group_by(Number_of_Vehicles,
                             variable) %>% 
  summarise(total = sum(value))
data02 %>% ggplot(aes(Number_of_Vehicles, total,fill = variable))+
  geom_bar(stat = 'identity')+
  labs(x = 'number of vehicles in crash',
       y = 'total injury')+
  facet_wrap(~variable,scales = 'free_y')

# type of the cars
d = data %>% select(Crash_Number,Vehicle_Configuration)
d = separate_rows(d,Vehicle_Configuration, sep = '/',convert = T)
d = separate(d,Vehicle_Configuration, into = c('a','b'),sep = ':',convert = T)
d= drop_na(d)
d[,'b'] <- gsub("()","",d[,'b'])












