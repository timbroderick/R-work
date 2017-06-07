# Let's load our new dataframes

library(readr)
df <- read_csv("dfsubset.csv")
dfrtr <- read_csv("dfRTR.csv")

# load in ggplot and themes
library(ggplot2)
library(ggthemes)

# basic bar chart
basebar <- ggplot() + geom_bar(aes(x = Year_Quarter, y = Total_RTR_incidents, 
                                   fill = factor(years) ), 
                               data = dfrtr,
                               stat="identity") + coord_flip()
basebar

# stacked bars
stacked <- ggplot() +
  geom_bar(data=df, 
           aes(Year_Quarter, value, fill = force),
           position = "stack", 
           stat="identity") + coord_flip()
stacked

# grouped bars
grouped <- ggplot() +
  geom_bar(data=df, 
           aes(Year_Quarter, value, fill = force),
           position = "dodge", 
           stat="identity") + coord_flip()
grouped

# create a pub ready version of stacked
# and play with ggplot themes
