# Let's load our new dataframe

library(readr)
df <- read_csv("dfrtr.csv")

summary(df)
# load in ggplot and themes
library(ggplot2)
library(ggthemes)


#----Set up plot for print and online --------

# widths for pdf and png files are set up so that
# text elements work for print and online. 
# Generally, the pdf will = a 2-column graphic
# that in a pinch could be used in the paper without
# any work on my part as long as it printed in color,
# and the png will be readable on mobile.

# As for height, adjust that as necessary. Look at the
# look at the files you create and see if they need room!

# While working out your plot, leave these items commented out
# so you can see a preview of your graphic in the plots pane
# when you're satisfied with it, then uncomment to save out
# files. Note you can't create pdfs and pngs at the same time
# you'll have to uncomment one and comment out the other.

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
  coord_flip() + theme_fivethirtyeight()

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

# Here's where we adapt the theme we're using to work for us
# Can ignore
basebar <- basebar + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
  )

basebar

#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 

