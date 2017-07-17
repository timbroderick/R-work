# switching things up a bit - this is data
# from a watchdog graphic that seemed to
# be perfect for this chart type
# ultimately we chose not to use it, but
# still a great example

# as always, read the data in
library(readr)
df <- read_csv("homeExem.csv")

# take a look at it
names(df)
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
#pdf(file="ggplotBox.pdf", width = 7, height = 6.75) 
#png(filename = "ggplotBox.png",width = 600, height = 500, units = "px")

#-----Insert plot here -------------

# A boxplot is something that shows the range of data
# in a set. Basically it divides the most common 
# data into four parts with equal counts of data,
# or quartiles. Bottom and top quartiles are shown 
# by the extent of the top and bottom lines,
# while the two middle quartiles are boxed with the
# median as the line in the box. 
# Any points beyond the box and lines are considered
# potential outliers. So basically, it's showing
# that most of the data or predicted data would be between
# the box and lines, and trying to show what would 
# fall outside that prediction.
boxgfx <- ggplot(df) + 
  aes(x = County, 
      y = ExemRate, 
      fill = factor(County)
      ) + 
  geom_boxplot() + 
  theme_gfx() + 
  geom_jitter() 
# Jitter just takes all the dots and spaces them out
# so they don't overlap and you can see them all

# add all the titles.
boxgfx <- boxgfx + labs(
  title="Accepted exemptions", # your headline
  subtitle="Some assessors are more diligent about tracking \nthe validity of homestead exemptions that can reduce \na home's assessed value by $6,000 to $7,000.",
  x="County", 
  y="PERCENT WITH\nHOMESTEAD EXEMPTIONS",
  caption="\n* For brevity, includes two townships in Will County.\nSource: County assessment offices")

# in this case, there's no need for a legend
boxgfx <- boxgfx + 
  theme(legend.position="None")

boxgfx

#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 

