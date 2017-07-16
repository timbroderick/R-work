# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

# earlier we created a set of three charts. 
# here's how to do something similar only by looking at
# the relationship between two things (UOF and SOF)
# by year. But instead of having to create each plot
# we can use the lattice package to do that for us

# load in the lattice library
library(lattice)



# From http://www.dummies.com/programming/r/how-to-create-a-lattice-plot-in-r/
# To make a lattice plot, you need to specify a formula
# typically of the form y ~ x | z. 
# It means to create a plot of y against x, conditional on z. 
# In other words, create a plot for every unique value of z. 
# Each of the variables in the formula has to be a column in 
# the data frame that you specify in the data argument.

xyplot(UOF_only~Total_RTR|factor(year), 
       data=df, 
       type=c("p", "r"),
       main="UOF v Total RTR by year",
       ylab="UOF", xlab="Total RTR")

# in our case, we compared UOF of force versus Total RTR incidents 
# by year, and so got three boxes - 2014, 2015, 2016
# making years a factor allows it to show up in the labels
# type gave us both points (p) and a regression line (r)

# if we had another criteria - besides years - we could add it
# like this factor(years)*criteria
