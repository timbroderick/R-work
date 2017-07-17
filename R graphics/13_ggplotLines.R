# Let's load our new dataframe

library(readr)
df <- read_csv("dfsubset.csv")

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
#pdf(file="ggplotLine.pdf", width = 7, height = 6) 
#png(filename = "ggplotLine.png",width = 600, height = 500, units = "px")

#-----Insert plot here -------------

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
  theme_gfx()

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

pLine


#----- End plot --------------

#dev.off() 

