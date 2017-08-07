# switching things up a bit - this is data
# from a watchdog graphic that seemed to
# be perfect for this chart type
# ultimately we chose not to use it, but
# still a great example

# as always, read the data in
library(readr)
library(ggplot2)
library(ggthemes)

df <- read_csv("homeExem.csv")

# take a look at it
names(df)
summary(df)

#---------------------
# This function set styles for the chart
# Be sure to run it before you plot

theme_gfx <- function(...) {
  theme_set(theme_get() + theme(text = element_text(family = 'Verdana', size= 12, lineheight=0.9))) + 
    theme(
      # edit background colors
      plot.background = element_blank(),
      legend.background = element_blank(),
      panel.background=element_rect(fill="#E5E5E5"),
      strip.background=element_rect(fill="#E5E5E5"),
      # modify grid and tick lines
      panel.grid.major = element_line(size = .6, color="#D2D2D2"),
      panel.grid.minor = element_line(size = .6, color="#D2D2D2", linetype = "dashed"),
      axis.ticks = element_blank(),
      # edit font sizes
      plot.title = element_text(size = 27,face="bold"),
      plot.subtitle = element_text(size = 18),
      #legend.title=element_text(size = 13,face="bold"),
      legend.text=element_text(size=14.7),
      axis.title=element_text(size=15, face="bold"),
      axis.text=element_text(size=13.5),
      plot.caption=element_text(size=13.5, hjust=0),
      strip.text = element_text(face="bold", size=13.5, hjust=0),
      # This puts the legend across the top
      legend.position="top", 
      legend.direction="horizontal",
      # removes label for legend
      legend.title = element_blank(),
      ...
    )
}

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
  geom_jitter()  +
  scale_y_continuous( limits = c(0, 100), breaks=c( seq( 0,100,10 ) ) )
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

# color scheme - comment out for B/W PDF
boxgfx <- boxgfx + scale_colour_tableau() + scale_fill_tableau()
# make B/W PDF - remember to change name of file!
#boxgfx <- boxgfx + scale_colour_grey(start = 0, end = 0.75) + scale_fill_grey(start = 0, end = 0.75)

boxgfx

#----- End plot --------------
# Uncomment the line below when saving pdfs or pngs
#dev.off() 

