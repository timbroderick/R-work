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
basebar <- ggplot(dfrtr) + 
  geom_bar(aes(x = Year_Quarter, 
               y = Total_RTR_incidents, 
               fill = factor(years) ), 
           stat="identity") + coord_flip()
basebar

# stacked bars
stackedbar <- ggplot(df) +
  geom_bar(aes(Year_Quarter, 
               value, 
               fill = force),
           position = "stack", 
           stat="identity") + coord_flip()
stackedbar

# grouped bars
grouped <- ggplot(df) +
  geom_bar(aes(Year_Quarter, 
               value, 
               fill = force),
           position = "dodge", 
           stat="identity") + coord_flip()
grouped

# here we change the names in the data frame
df$force <- factor(df$force, levels = c("Total_transitions","SOF_only","UOF_only"),
                   labels = c("Transitions","Show of force","Use of force" ))


#----Set up plot for print and online --------
dev.cur()
pdf(file="ggplotBars.pdf", width = 7, height = 6) 
#png(filename = "ggplotBars.png",width = 600, height = 500, units = "px")
#-----Insert plot here -------------

# stacked bars
stacked <- ggplot(df) + 
  aes(x =Year_Quarter,
      y = value, 
      fill = force, 
      label = value) + 
  geom_bar(stat = "identity") + 
  coord_flip() + theme_fivethirtyeight()

#adjust legend position and change label names


stacked <- stacked + 
  theme(legend.position="top", 
        legend.direction="horizontal",
        legend.title = element_blank())


# add titles
stacked <- stacked + labs(
  title="Response to resistance",
  subtitle="By year and quarter.\nElgin police have increased their use of non-lethal\nforce in response to resistance.",
  x="YEAR, QUARTER", 
  y="TYPES OF RESPONSE TO RESISTANCE",
  caption="Source: Elgin police")

# add bar labels
stacked <- stacked + geom_text(
  position = "stack", 
  #data=df, 
  aes(x = Year_Quarter, 
      y = value - (value * 0.025), 
      hjust = 1,
      label = value),
  size=5,
  fontface="bold",
  color="white"
  )

# now let's mess with some aesthetics of the plot
stacked <- stacked + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 30),
  plot.subtitle = element_text(size = 18),
  legend.text=element_text(size=15),
  axis.title=element_text(size=14, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14)
  )

stacked

#----- End plot --------------
dev.off() 

