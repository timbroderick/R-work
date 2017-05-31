# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

library(ggplot2)
library(ggthemes)

p1 <- ggplot(df, aes(Total_RTR_incidents, UOF_only, color = factor(years)))
p1 + geom_point() + geom_line()

p2 <- ggplot(df, aes(Total_RTR_incidents,UOF_only))
p2 + geom_point() + stat_smooth() 

p3 <- ggplot(df, aes(years,UOF_only)) + stat_summary(fun.y = median, geom = "bar")
p3
