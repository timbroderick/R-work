# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

# Simple Dotplot - what is CEX? Seems to have something to do
# with type size.
# dotchart(data we want, labels = the column we want to use
# to label the data, cex=type size?, main=Title text, 
# xlab= label for the x axis
dotchart(df$Total_RTR,labels=df$Year_Quarter,
         main="RTR incidents by year, quarter",
         xlab="RTR incidents")


# Dotplot: Grouped, Sorted and Colored
x <- df[order(df$Year_Quarter),] # sort and place into new dataframe x
x$year <- factor(x$year) # it must be class of factor
# next we're creating a new column called color and
x$color[x$year==2014] <- "red" # assign red to 2014 rows
x$color[x$year==2015] <- "blue" # assign blue to 2015 rows 
x$color[x$year==2016] <- "darkgreen" # assign etc
# creates the plot, groups items by years, colors by color
# data, labels, cex, group by the years column,
# gcolor is the color of the years label 
# color for each year is from the color column
dotchart(x$Total_RTR,labels=x$Year_Quarter,cex=.9,groups= x$year,
         main="RTR incidents\ngrouped by year",
         xlab="RTR incidents", gcolor="Orange", color=x$color) 


