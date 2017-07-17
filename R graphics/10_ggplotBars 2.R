# Let's load our new dataframe

library(readr)
df <- read_csv("dfrtr.csv")

summary(df)
# load in ggplot and themes
library(ggplot2)
library(ggthemes)

#---------------------
# This function set styles for the chart
# Be sure to run it before you plot


theme_gfx <- function(...) {
  theme_fivethirtyeight() +
    theme(
      plot.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      plot.title = element_text(size = 30),
      plot.subtitle = element_text(size = 18),
      legend.text=element_text(size=15),
      axis.title=element_text(size=15, face="bold"),
      axis.text=element_text(size=13),
      plot.caption=element_text(size=12, hjust=0),
      # This puts the legend across the top
      legend.position="top", 
      legend.direction="horizontal",
      # removes label for legend
      legend.title = element_blank(),
      ...
    )
}


#----Set up plot for print and online --------

#dev.cur()
#pdf(file="ggplotBars.pdf", width = 7, height = 6.75) 
#png(filename = "ggplotBars.png",width = 600, height = 500, units = "px")

#-----Insert plot here -------------

basebar <- ggplot(df) + 
  aes(x = reorder(Year_Quarter, -sort), 
      y = Total_RTR, 
      fill = factor(year),
      label = Total_RTR) + # have the values appear on the bars
  geom_bar(stat="identity") + 
  coord_flip() + theme_gfx()

# add all the titles.
basebar <- basebar + labs(
  title="Response to resistance", # your headline
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="RESPONSE TO RESISTANCE INSTANCES",
  caption="\nSource: Elgin police")


# We don't need a legend so you can leave this alone
# unless you need a legend
basebar <- basebar + theme(legend.position="None")

# Here's where we go further in formating the bar values
# you'll need to edit x, y and label with appropriate values
basebar <- basebar + geom_text(
  position = "stack", 
  aes(x = Year_Quarter, 
      y = Total_RTR - (Total_RTR * 0.025), 
      hjust = 1,
      label = Total_RTR),
  size=5,
  fontface="bold",
  color="white"
  )

basebar

#----- End plot --------------
#dev.off() 

