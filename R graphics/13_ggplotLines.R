# Let's load our new dataframe

library(readr)
df <- read_csv("dfsubset.csv")

# load in ggplot and themes
library(ggplot2)
library(ggthemes)


# line chart

# First, let's change the levels of force
# to make them more readable.
df$set <- factor(df$set, levels = c("Transitions","SOF_only","UOF_only"),
                   labels = c("Transitions","Show of force","Use of force" ))


#----Set up plot for print and online --------

# widths for pdf and png files are set up so that
# text elements work for print and online. 
# Generally, the pdf will = a 2-column graphic
# that in a pinch could be used in the paper without
# any work on my part as long as it printed in color,
# and the png will be readable on mobile.

# As for height, adjust that as necessary. Look at the
# files you create and see if they need room!

# While working out your plot, leave these items commented out
# so you can see a preview of your graphic in the plots pane
# when you're satisfied with it, then uncomment to save out
# files. Note you can't create pdfs and pngs at the same time
# you'll have to uncomment one and comment out the other.

#dev.cur()
#pdf(file="ggplotLine.pdf", width = 7, height = 6) 
#png(filename = "ggplotLine.png",width = 600, height = 500, units = "px")
#-----Insert plot here -------------

# line chart
pLine <- ggplot(df) +
  aes(Year_Quarter, 
      value, 
      group = set, 
      color = set) +
  geom_line(stat="identity", 
            size = 1.5) + 
  geom_point(stat="identity", 
             size = 3,
             shape=21,
             fill="white") + 
  theme_fivethirtyeight()

# Let's customize the x scale
# Remember \n = a line break
pLine <- pLine + scale_x_discrete(
  labels=c("1Q\n2014","2Q","3Q","4Q","1Q\n2015","2Q","3Q","4Q","1Q\n2016","2Q","3Q","4Q")
)

# Let's also customize the y scale
# we set the min and max, then where breaks should be
pLine <- pLine + 
  scale_y_continuous(breaks=c(seq(0,40,5)) )

# add all the titles.
pLine <- pLine + labs(
  title="Response to resistance", # your headline
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="NUMBER PER QUARTER",
  caption="\nNote: Show of Force and Use of Force are incidents where \npolice only warned or only used force in repsonse to resistance. \nTransition is incidents where police showed then used force. \nSource: Elgin police")

# This puts the legend horizontally across the top
# you can leave this alone 
pLine <- pLine + 
  theme(legend.position="top", 
        legend.direction="horizontal",
        legend.title = element_blank())

# Here's where we adapt the theme we're using to work for us
# Can ignore
pLine <- pLine + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
)

pLine


#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 

