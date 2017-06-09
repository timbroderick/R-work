# Let's load our new dataframes

library(readr)
df <- read_csv("dfsubset.csv")

names(df)
# load in ggplot and themes
library(ggplot2)
library(ggthemes)


# grouped bars

# First, let's change the levels of force
# to make them more readable.
# Note that here you can decide the order in which
# the bars are stacked.
df$force <- factor(df$force, levels = c("Total_transitions","SOF_only","UOF_only"),
                   labels = c("Transitions","Show of force","Use of force" ))


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
#pdf(file="ggplotGroupedBars.pdf", width = 7, height = 12) 
#png(filename = "ggplotGroupedBars.png",width = 600, height = 800, units = "px")
#-----Insert plot here -------------

grouped <- ggplot(df) + 
  aes(Year_Quarter,
      value,
      fill = force,
      label = value) + 
  geom_bar(stat = "identity", position = position_dodge(width = NULL)) + 
  coord_flip() + theme_fivethirtyeight()

# add all the titles.
grouped <- grouped + labs(
  title="Response to resistance", # your headline
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="TYPES OF RESPONSE TO RESISTANCE",
  caption="\nNote: Show of Force and Use of Force are incidents where \npolice only warned or only used force in repsonse to resistance. \nTransition is incidents where police showed then used force. \nSource: Elgin police")


# This puts the legend horizontally across the top
# you can leave this alone 
grouped <- grouped + 
  theme(legend.position="top", 
        legend.direction="horizontal",
        legend.title = element_blank())

# Here's where we go further in formating the bar values
# you'll need to edit x, y and label with appropriate values
grouped <- grouped + geom_text(
  position = position_dodge(width = 0.9), 
  aes(x = Year_Quarter, 
      y = value - (value * 0.1), 
      vjust = 0.5,
      label = value),
  size=5,
  fontface="bold",
  color="white"
  )

# Here's where we adapt the theme we're using to work for us
# Can ignore
grouped <- grouped + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
  )

grouped

#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 

