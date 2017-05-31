# We're going to use R to "interview" some data
# specifically three years of Response to Resisitance numbers from Elgin
# The data is divided by quarter, giving us 12 rows
# RTR incidents are further divided by Show of Force only, Use of Force only
# and Transitions, or incidents that started with a SOF and ended with UOF
# RTR incidents do not involve a taser or handgun, those are seperate datasets

# Keep in mind this is a pretty small dataset, so these aren't necessarily
# showing anything definitive. We'd probably need several more years of data
# to draw any conclusions.

# readr is a library that does a lot of things ...
library(readr)

# ... but in this case, we're using it to load in
# the data into a dataframe from a csv
elgCrime <- read_csv("ElginUOF.csv")

# here's a number of ways to take a look at what we've loaded
ls() # lists the data sets loaded
class(elgCrime) # see's what the data is
dim(elgCrime) # finds dimensions in rows and columns
nrow(elgCrime) # finds number of rows
ncol(elgCrime) # finds number of columns
object.size(elgCrime) # size of the data set in memory used
names(elgCrime) # returns vector of column names
head(elgCrime) # looks at first six columns (with column names)
head(elgCrime, 10) # looks at first 10 rows
tail(elgCrime, 5) # looks at athe last 5 rows
# head and tail become very useful when you're looking at a dataset
# of thousands of rows. 

# table gives us a deeper summary look at single column
table(elgCrime$Total_RTR_incidents)
str(elgCrime) # good general preview of the data

# Here's a great way to look at the data
summary(elgCrime)
# What this shows us
# Where possible, for each column it gives mean, median, highest and lowest value
# in the context of quarters, with each quarter having the same number of instances
# So for SOF only, the minimum value is 6 and the first quarter goes from 6 to 9.75
# The second quarter goes from 9.75 to the median, 12. It also includes the mean
# Then the third quarter goes from the median to 13.25, and last quarter
# from there to the maximum value of 19


# let's get the column names again
names(elgCrime)
# you can also get a sortable preview of the data frame by clicking on it
# in the Environment tab in Rstudio

# -----
# Now let's visualize the data using R's basic plotting functions
# let's look at the one of the columns as a histogram
hist(elgCrime$Total_RTR_incidents, breaks=10, main="Breaks = 10", col="green")
# What you're seeing here
# we know there are 12 quarters of data (3 years with 4 quarters each)
# so we have 12 instances of numbers that range from 25 to 60
# Frequency counts how many instances are in each segment. 
# For instance, in the range of 25 to 30, there are two intances (frequency)
# Breaks means it creates 10 "bins" for the range of the data (25 to 60)
# that doesn't mean if you create 12 breaks that you'll get 12 bars
# It means that it'll divide the range by 12 and count how many instances
# fall into each of the 12 "bins". Go ahead and change the number of breaks
# and see how the histogram changes. Not every number will work, but
# it will try to give you as close to what you want as possible
# main gives it a title, col gives it a color

# Now, let's grab the total RTR incidents
reg <- table(elgCrime$Total_RTR_incidents) # subsets a matrices
reg
# creates a bar plot - this is a lot like the histogram
barplot(reg,col="wheat",main="Number of RTR incidents")


# Now let's see how things relate
# first, let's look at UOF by Total RTR
boxplot(UOF_only~Total_RTR_incidents, data=elgCrime, col="red", xlab="Total RTR", ylab="UOF only", col.axis="blue",col.lab = "red")
title(main = "UOF in Total RTR")
# much like the histogram, we see the range of RTR incidents across the bottom
# 10 RTR values have one corresonding UOF value, but one - 32
# has two corresponding UOF values - 18 and 21
# Boxplot shows the mean of each "bin". Since all others have only 
# one UOF value, they're flat. 32 has two values. The line shows the median 
# of 19 and the red box shows the range of the values (18 and 21)

# --------------

# Last exercise here. Let's add a column to the data and rename it
# we'll be using this again later
# first, let's make sure it's sorted by year quarter
# from 2014 1st quarter to 2016 last (ascending order)
elgCrime[order(elgCrime$Year_Quarter),]
# Alternatively, here's how you would sort decending order
# elgCrime[order(elgCrime$Year_Quarter, decreasing=TRUE),]
# first, let's create a vector of only the years and load it into a matrix
elgYears <- c(2014,2014,2014,2014,2015,2015,2015,2015,2016,2016,2016,2016)
elgYears
years <- matrix(elgYears,12,1)
years

# Now let's bind the years matrix with elgCrime so we have a column of just years
df <- cbind(years,elgCrime)
df

# And just in case, let's save the df dataset to a csv, so it's portable
?readr
write_csv(df,"dfCrime.csv")

# These next two plots I'm not entirely sure about - 
# they seem to approximate the histograms, but with
# a smoothed line rather than bars. 

# This loads the density data of the total RTR into d
d <- density(df$Total_RTR_incidents) 
# we then use d to create a plot, in this case a smooth line
# showing where - in the range of total RTR incidents -
# we see the most incidents
plot(d, main="Total RTR incidents") # plots the results
# This styles the plot as a filled polygon with an opacity
# or alpha set to 50% transparency
polygon(d, col=rgb(1, 0, 0,0.5), border="red") 

# This next plot involves a library called "sm"
# it's fine if you want to skip this - I think there are
# easier ways of doing this with ggplot2
# first we load the library and attach the data (df) to it
library(sm)
attach(df)
# then we use our new years column to divide the data by the years
sm.density.compare(df$Total_RTR_incidents, df$years, xlab="Total RTR incidents", ylim= c(0,0.08))
title(main="Response to Resistance by year")

# all this formats the legend, although we'll see easier ways
# of doing this later on
RTRyears <- factor(years, levels= c("2014","2015","2016"), labels = c("2014", "2015", "2016"))
colfill<-c( 2:( 2+length( levels(RTRyears) ) ) )
legend( "topright", levels(RTRyears), fill=colfill )
# the end result is pretty cool. We can see three lines for each 
# year's data, with most of the values in 2014 being on the 
# lower end of the RTR range and most of 2016 on the high end
# 2015 is mostly a bit higher than 2014, with a single instance 
# on the high end.

# next file, we'll look at the info using scatter plots
