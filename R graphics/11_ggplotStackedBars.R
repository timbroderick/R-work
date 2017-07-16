# Let's load our new dataframe

library(readr)
df <- read_csv("dfsubset.csv")

names(df)
# load in ggplot and themes
library(ggplot2)
library(ggthemes)

# First, let's change the levels of force
# to make them more readable.
# Note that here you can decide the order in which
# the bars are stacked.
df$set <- factor(df$set, levels = c("Transitions","SOF_only","UOF_only"),
                   labels = c("Transitions","Show of force","Use of force" ))


#----Set up plot for print and online --------

# widths for pdf and png files are set up so that
# text elements work for print and online. 
# Generally, the pdf will = a 2-column graphic
# that in a pinch could be used in the paper without
# any adjusting by a graphic artist as long as it printed in color,
# and the png will be readable on mobile.

# As for height, adjust that as necessary. Look at the
# look at the files you create and see if they need room!

# While working out your plot, leave these items commented out
# so you can see a preview of your graphic in the plots pane
# when you're satisfied with it, then uncomment to save out
# files. Note you can't create pdfs and pngs at the same time
# you'll have to uncomment one and comment out the other.

#dev.cur()
#pdf(file="ggplotStackedBars.pdf", width = 7, height = 6.75) 
#png(filename = "ggplotStackedBars.png",width = 600, height = 500, units = "px")
#-----Insert plot here -------------

# stacked bars
stacked <- ggplot(df) + # ggplot(dataframe name)
  aes(x = reorder(Year_Quarter, -sort), # column for the x axis
      y = value, # Column with values that get plotted
      fill = set, # Column with values that decide color
      label = value) + # have the values appear on the bars
  geom_bar(stat = "identity") + # leave these last lines alone
  coord_flip() + theme_fivethirtyeight()

# add all the titles.
stacked <- stacked + labs(
  title="Response to resistance", # your headline
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="TYPES OF RESPONSE TO RESISTANCE",
  caption="\nNote: Show of Force and Use of Force are incidents where \npolice only warned or only used force in repsonse to resistance. \nTransition is incidents where police showed then used force. \nSource: Elgin police")


# This puts the legend horizontally across the top
# you can leave this alone 
stacked <- stacked + 
  theme(legend.position="top", 
        legend.direction="horizontal",
        legend.title = element_blank())

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

# Here's where we adapt the theme we're using to work for us
# Can ignore
stacked <- stacked + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
  )

stacked

#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 

