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
qplot(Total_RTR,
      data=df,
      alpha=.05, # sets transparency 
      fill=factor(year)
)

# qplot has a number of options

# now a simple density plot
qplot(Total_RTR, data=df, 
      geom="density",
      color=factor(year),
      fill=factor(year),
      linetype = factor(year),
      alpha=I(.5), # I() keeps alpha out of legend
      main="Distribution of RTR incidents", 
      xlab="Total RTR incidents",
      ylab="Density")


# Here's a simple scatter
# geom_smooth is a way of adding the trend over
# the gray area is the 95% confidence interval
# Generally, the closer that is to the trend line
# the tighter the correlation
qplot(y=Total_RTR,
      data=df
      ) + geom_smooth(method = "lm")

# simple scatter, with years by color
qplot(y=Total_RTR,
      data=df,
      color=factor(year)
)

# simple scatter with smoothed trend line
# requires an x value
qplot(Total_RTR,UOF_only,
      data=df,
      geom=c("point","smooth")
)

# simple scatter, lines not smoothed
# and years as factor
qplot(Total_RTR,UOF_only,
      data=df,
      color=factor(year)
) + geom_smooth(method = "lm")#, se = FALSE) 
# se would hide 95% conf

# facet grid compares total RTR and UOF
# But divides space by year
qplot(Total_RTR,UOF_only,
      data=df, 
      color=factor(year),
      xlab="Total RTR", ylab="UOF") + facet_grid(. ~ factor(year))
# for facet_grid, you can replace the . ~ with another
# factor and it will do both, like
# Total_RTR ~ factor(year)

# here's the box plot
qplot(factor(year), SOF_only, 
      data=df, 
      geom=c("boxplot", "jitter"),
      fill=factor(year), 
      alpha=I(.5),
      main="SOF by Year",
      xlab="Year", ylab="SOF")

# Now a dot plot
qplot(factor(Year_Quarter), SOF_only, 
      data=df, 
      geom=c("dotplot"),
      fill=factor(year), 
      stackdir = "center", binaxis = "y",
      main="SOF by Year, quarter",
      xlab="Year", ylab="SOF")  + coord_flip()

# Generally, qplot allows you to do about the same thing
# as the base plotting that comes with R
# you can choose either 
# Next, we're going to start producing
# really publication-ready charts
# But first, we'll need to prepare the data