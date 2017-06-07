# Continuing to work with the RTR data

library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

# Now we're moving on to work with ggplot2
# This is an advanced data visualization library
# That we can use to make our charts

library(ggplot2)
library(ggthemes)


#--------
# qplot is a way to do quick exploratory graphics with ggplot
# kind of like the base graphics we started with
# Here's a good intro doc
# http://www.statmethods.net/advgraphs/ggplot2.html

# let's start with a histogram
qplot(Total_RTR_incidents,
      data=df,
      alpha=.05, # sets transparency 
      fill=factor(years)
)

# qplot has a number of options

# now a simple density plot
qplot(Total_RTR_incidents, data=df, 
      geom="density",
      color=factor(years),
      fill=factor(years),
      linetype = factor(years),
      alpha=I(.5), # I() keeps alpha out of legend
      main="Distribution of RTR incidents", 
      xlab="Total RTR incidents",
      ylab="Density")


# Here's a simple scatter
# geom_smooth is a way of adding the trend over
# the gray area is the 95% confidence interval
# Generally, the closer that is to the trend line
# the tighter the correlation
qplot(y=Total_RTR_incidents,
      data=df
      ) + geom_smooth(method = "lm")

# simple scatter, with years by color
qplot(y=Total_RTR_incidents,
      data=df,
      color=factor(years)
)

# simple scatter with smoothed trend line
# requires an x value
qplot(UOF_only,Total_RTR_incidents,
      data=df,
      geom=c("point","smooth")
)

# simple scatter, lines not smoothed
# and years as factor
qplot(UOF_only,Total_RTR_incidents,
      data=df,
      color=factor(years)
) + geom_smooth(method = "lm")#, se = FALSE) 
# se would hide 95% conf

# facet grid compares SOF and UOF
# But divides space by year
# and by number of Total RTR incidents (facets)
qplot(UOF_only,SOF_only,
      data=df, 
      color=factor(years),
      facets = Total_RTR_incidents~factor(years),
      xlab="UOF", ylab="SOF")

# here's the box plot
qplot(factor(years), SOF_only, 
      data=df, 
      geom=c("boxplot", "jitter"),
      fill=factor(years), 
      alpha=I(.5),
      main="SOF by Year",
      xlab="Year", ylab="SOF")

# Now a dot plot
qplot(factor(Year_Quarter), SOF_only, 
      data=df, 
      geom=c("dotplot"),
      fill=factor(years), 
      stackdir = "center", binaxis = "y",
      main="SOF by Year, quarter",
      xlab="Year", ylab="SOF")  + coord_flip()

# Generally, qplot allows you to do about the same thing
# as the base plotting that comes with R
# you can choose either 
# Next, we're going to start producing
# really publication-ready charts
# But first, we'll need to prepare the data