# Let's load our new dataframes

library(readr)
df <- read_csv("dfsubset.csv")
dfrtr <- read_csv("dfRTR.csv")

# load in ggplot and themes
library(ggplot2)
library(ggthemes)

# line chart
pLine <- ggplot(df, aes(Year_Quarter, value, group = force, col = force))
pLine + geom_point(stat="identity") + geom_line(stat="identity")

p1 <- ggplot() + geom_line(aes(y = value, x = Year_Quarter, group = force, colour = force),
                           data = df, stat="identity")
p1
