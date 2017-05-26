# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the data with the years column
# Let's get the colummn names
names(df)


# Now I want to try and highlight the values in the scatter plot by their years
# We start with a basic plot, adding all the titles and labels here
plot(df$Total_RTR_incidents, df$UOF_only, 
     main = "UOF vs Total RTR incidents", 
     # sub = "Daily Herald graphic", 
     xlab="Total response to resistance incidents", 
     ylab="Use of force incidents only")
# Now we're going to subset the data by the year 2014
y2014 <- subset(df, years==2014)
# And add that subset to the plot, with the color of red and
# as a solid cirlce (pch=19)
points(y2014$Total_RTR_incidents,y2014$UOF_only,col="red",pch=19)
# to learn more, don't forget you can use Rstudio's built in query tool
# simply type ?points 

# Now we do the same with the other two years
y2015 <- subset(df, years==2015)
points(y2015$Total_RTR_incidents,y2015$UOF_only,col="blue",pch=19)
y2016 <- subset(df, years==2016)
points(y2016$Total_RTR_incidents,y2016$UOF_only,col="green",pch=19)

# We also need to add a legend to the plot
legend("topleft", pch = c(19,19,19), col = c("red","blue","green"), legend = c("2014", "2015", "2016"))
# Note that legends can be tricky. You have to leave room for them so they
# don't obscure the data. That means you may need to adjust the scales of your
# graphic beyond what it defaults to. Not something we need to worry about now

# Let's add the regression line
abline(lm(df$UOF_only~df$Total_RTR_incidents))

# so now we can see not only that UOF incidents are higher when 
# there are more total RTR incidents and UOFshave increased over time


# Now let's save this as a PDF. Note that since we already created
# the subsets, we don't have to recreate them
dev.cur()
# we want to save this as a pdf and a png, but can only
# do one at a time. So uncomment the pdf and comment (#) the png
# when you want a pdf, and visa versa for the png
pdf(file="myplot2.pdf", width = 3.75, height = 3.5) 
# But let's also save this out as a png
#png(filename = "myplot2.png",width = 600, height = 400, units = "px")
#-----Insert plot here -------------

plot(df$Total_RTR_incidents, df$UOF_only, 
     main = "UOF vs Total RTR incidents", 
     xlab="Total response to resistance incidents", 
     ylab="Use of force incidents only")
points(y2014$Total_RTR_incidents,y2014$UOF_only,col="red",pch=19)
points(y2015$Total_RTR_incidents,y2015$UOF_only,col="blue",pch=19)
points(y2016$Total_RTR_incidents,y2016$UOF_only,col="green",pch=19)
legend("topleft", pch = c(19,19,19), col = c("red","blue","green"), legend = c("2014", "2015", "2016"))
abline(lm(df$UOF_only~df$Total_RTR_incidents))
#----- End plot --------------
dev.off() 



# Now let's do something similar, but with UOF, SOF and Transitions
# but here, we'll need to set the range of the x and y
# first, let's see the min and max of all the data we want
summary(df)

plot(df$Total_RTR_incidents, df$UOF_only, 
     main = "Response to resistance incidents", 
     xlab="Total response to resistance incidents", 
     ylab="Response by type",
     xlim=c(20,60), ylim=c(0,40),col="red",pch=19)
points(df$Total_RTR_incidents,df$SOF_only,col="blue",pch=19)
points(df$Total_RTR_incidents,df$Total_transitions,col="green",pch=19)
# update the legend
legend("topleft", pch = c(19,19,19), col = c("red","blue","green"), legend = c("UOF", "SOF", "Transitions"))
# Add the regression lines, but color them (par) to match
abline(lm(df$UOF_only~df$Total_RTR_incidents, par(col="red")))
abline(lm(df$SOF_only~df$Total_RTR_incidents, par(col="blue")))
abline(lm(df$Total_transitions~df$Total_RTR_incidents, par(col="green")))


#----Set up plot for print and online --------
dev.cur()
pdf(file="myplot3.pdf", width = 4, height = 4) 
#png(filename = "myplot3.png",width = 600, height = 400, units = "px")
#-----Insert plot here -------------
plot(df$Total_RTR_incidents, df$UOF_only, 
     main = "Response to resistance incidents", 
     xlab="Total response to resistance incidents", 
     ylab="Response by type",
     xlim=c(20,60), ylim=c(0,40),col="red",pch=19)
points(df$Total_RTR_incidents,df$SOF_only,col="blue",pch=19)
points(df$Total_RTR_incidents,df$Total_transitions,col="green",pch=19)
# update the legend
legend("topleft", pch = c(19,19,19), col = c("red","blue","green"), legend = c("UOF", "SOF", "Transitions"))
# Add the regression lines, but color them (par) to match
abline(lm(df$UOF_only~df$Total_RTR_incidents, par(col="red")))
abline(lm(df$SOF_only~df$Total_RTR_incidents, par(col="blue")))
abline(lm(df$Total_transitions~df$Total_RTR_incidents, par(col="green")))
#----- End plot --------------
dev.off() 

# note that I needed to play around a bit with the size for the PDF
# generally, a little under 4 inches corresponds to a 2 column graphic
# but due to the legend, the depth needed to be increased so the 
# dots wouldn't run into the legend

# for online, 600 pixels wide is a good width for a png.
# anything wider and it might not work well for mobile.
# These basic graphics aren't great for presentation though
# when we start playing with ggplot2 we'll get closer
# to more finished graphics

