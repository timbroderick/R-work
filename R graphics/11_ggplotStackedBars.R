# Let's load our new dataframe

library(readr)
df <- read_csv("dfsubset.csv")

names(df)
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
#pdf(file="ggplotStackedBars.pdf", width = 7, height = 6.75) 
#png(filename = "ggplotStackedBars.png",width = 600, height = 500, units = "px")

#-----Insert plot here -------------

# stacked bars
stacked <- ggplot(df) + 
  aes(x = reorder(Year_Quarter, -sort), 
      y = value, 
      fill = set, 
      label = value) + 
  geom_bar(stat = "identity") + 
  coord_flip() + theme_gfx()

# add all the titles.
stacked <- stacked + labs(
  title="Response to resistance", # your headline
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="TYPES OF RESPONSE TO RESISTANCE",
  caption="\nNote: Show of Force and Use of Force are incidents where \npolice only warned or only used force in repsonse to resistance. \nTransition is incidents where police showed then used force. \nSource: Elgin police")

# Here's where we go further in formating the bar values
# you'll need to edit x, y and label with appropriate values
stacked <- stacked + geom_text(
  position = "stack", 
  aes(x = Year_Quarter, 
      y = value - (value * 0.025), 
      hjust = 1,
      label = value),
  size=5,
  fontface="bold",
  color="white"
  )

# Finally, let's make the axis labels better
# Reverse order since we resorted the bars
stacked <- stacked + scale_x_discrete(
  labels=c("4Q","3Q","2Q","2016 1Q","4Q","3Q","2Q","2015 1Q","4Q","3Q","2Q","2014 1Q")
)

stacked

#----- End plot --------------

#dev.off() 

