library(ggplot2)
library(ggthemes)
#library(extrafont)

charts.data <- read.csv("copper-data-for-tutorial.csv")

p1 <- ggplot() + geom_line(aes(y = export, x = year, colour = product),
                           data = charts.data, stat="identity")
p1
