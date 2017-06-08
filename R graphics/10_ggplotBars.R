# Let's load our new dataframes

library(readr)
df <- read_csv("dfsubset.csv")
dfrtr <- read_csv("dfRTR.csv")

names(df)
# load in ggplot and themes
library(ggplot2)
library(ggthemes)
library(plyr)

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

#----Set up plot for print and online --------
#dev.cur()
#pdf(file="ggplotBars.pdf", width = 4, height = 4) 
#png(filename = "ggplotBars.png",width = 600, height = 400, units = "px")
#-----Insert plot here -------------

# stacked bars
stacked <- ggplot() + geom_bar(data=df, 
           aes(Year_Quarter, 
               value, 
               fill = force),
           position = "stack", 
           stat="identity") + coord_flip()
#adjust legend position
stacked <- stacked + theme(legend.position="top", legend.direction="horizontal",
                  legend.title = element_blank())

# add titles
stacked <- stacked + labs(
  title="RTR by year, quarter",
  subtitle="subtitle here",
  x="Years, quarters", 
  y="Types of response-to-resistance",
  caption="caption here")

#df <- ddply(df, .(Year_Quarter), transform, pos = value) #cumsum(value) )#- (value * 0.10))
#stacked <- stacked + geom_text(data=df, aes(x = Year_Quarter, y = value + (value*.5), label = value), size = 4)

stacked

#----- End plot --------------
#dev.off() 
