# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
library(ggplot2)
library(ggthemes)

#---------------------
# This function set styles for the chart
# Be sure to run it before you plot
theme_gfx <- function(...) {
  theme_fivethirtyeight() +
    theme(
      # edit background colors
      plot.background = element_rect(fill = "white"),
      legend.background = element_rect(fill = "white"),
      panel.background=element_rect(fill="#E0E0E0"),
      strip.background=element_rect(fill="#E0E0E0"),
      # edit font sizes
      plot.title = element_text(size = 30,face="bold"),
      plot.subtitle = element_text(size = 18),
      legend.title=element_text(size=12, face="bold"),
      legend.text=element_text(size=15),
      axis.title=element_text(size=15, face="bold"),
      axis.text=element_text(size=13),
      plot.caption=element_text(size=13, hjust=0),
      strip.text = element_text(face="bold", size=13, hjust=0),
      # This puts the legend across the top
      legend.position="top", 
      legend.direction="horizontal",
      # removes label for legend
      #legend.title = element_blank(),
      ...
    )
}

#----------------
# Get and prepare the data

df <- read_csv("dfCrime.csv")
df <-df[order(df$Year_Quarter),]
# add column containing the row number. 
df$sort <- seq.int(nrow(df)) 


#-----Insert plot here -------------

basebar <- ggplot(df) + 
  aes(x = reorder(Year_Quarter, -sort), 
      y = Total_RTR, 
      fill = factor(year)) +
  geom_bar(stat="identity") + 
  coord_flip() + theme_gfx()

# add all the titles.
basebar <- basebar + labs(
  title="Response to resistance",
  subtitle="Elgin police have increased their use of\nnon-lethal force in response to resistance.",
  x="YEAR, QUARTER", 
  y="RESPONSE TO RESISTANCE INSTANCES",
  caption="\nSource: Elgin police")

# Remove lengend
basebar <- basebar + theme(legend.position="None")

# Better x labels
basebar <- basebar + scale_x_discrete(
  labels=c("4Q","3Q","2Q","2016 1Q","4Q","3Q","2Q","2015 1Q","4Q","3Q","2Q","2014 1Q")
)

# add values to the bars
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

# Grab the data we used and save it for later
dfrtr <- subset(df, select = c("years","Year_Quarter","Total_RTR_incidents"))
write_csv(dfrtr,"dfRTR.csv")
