# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)


# Now I want to try and highlight the values in the scatter plot by their years
# We start with a basic plot, adding all the titles and labels here
plot(df$Total_RTR, df$UOF_only, 
     main = "UOF vs Total RTR incidents", 
     # sub = "Daily Herald graphic", 
     xlab="Total response to resistance incidents", 
     ylab="Use of force incidents only")
# Now we're going to subset the data by the year 2014
y2014 <- subset(df, year==2014)
# And add that subset to the plot, with the color of red and
# as a solid cirlce (pch=19)
points(y2014$Total_RTR,y2014$UOF_only,col="red",pch=19)
# to learn more, don't forget you can use Rstudio's built in query tool
# simply type ?points 

# Now we do the same with the other two years
y2015 <- subset(df, year==2015)
points(y2015$Total_RTR,y2015$UOF_only,col="blue",pch=19)
y2016 <- subset(df, year==2016)
points(y2016$Total_RTR,y2016$UOF_only,col="green",pch=19)

# We also need to add a legend to the plot
legend("topleft", pch = c(19,19,19), col = c("red","blue","green"), legend = c("2014", "2015", "2016"))
# Note that legends can be tricky. You have to leave room for them so they
# don't obscure the data. That means you may need to adjust the scales of your
# graphic beyond what it defaults to. Not something we need to worry about now

# Let's add the regression line
abline(lm(df$UOF_only~df$Total_RTR))

# so now we can see not only that UOF incidents are higher when 
# there are more total RTR incidents and UOFshave increased over time


# Now let's do something similar, but with UOF, SOF and Transitions
# but here, we'll need to set the range of the x and y
# first, let's see the min and max of all the data we want
summary(df)

plot(df$Total_RTR, df$UOF_only, 
     main = "Response to resistance incidents", 
     xlab="Total response to resistance incidents", 
     ylab="Response by type",
     xlim=c(20,60), ylim=c(0,40),col="red",pch=19)
points(df$Total_RTR,df$SOF_only,col="blue",pch=19)
points(df$Total_RTR,df$Transitions,col="green",pch=19)
# update the legend
legend("topleft", pch = c(19,19,19), col = c("red","blue","green"), legend = c("UOF", "SOF", "Transitions"))
# Add the regression lines, but color them (par) to match
abline(lm(df$UOF_only~df$Total_RTR, par(col="red")))
abline(lm(df$SOF_only~df$Total_RTR, par(col="blue")))
abline(lm(df$Transitions~df$Total_RTR, par(col="green")))

