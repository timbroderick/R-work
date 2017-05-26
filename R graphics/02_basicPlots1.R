# Continuing to work with the RTR data
library(readr)
elgCrime <- read_csv("ElginUOF.csv")

# let's get the column names again
summary(elgCrime)

# Now lets see this as a scatter plot
with(elgCrime, plot(Total_RTR_incidents, UOF_only)) # scatter plot
title(main = "UOF vs Total RTR incidents") # adds title
# What you're seeing here
# The first line of code, starting "with", creates a scatter plot. 
# First we say what dataset we want (elgCrime), then
# what we want to test - Total RTR incidents vs UOF only
# What it shows is that as there are more RTR incidents, 
# the number of incidents that involve UOF only also grows.
# Title obviously adds a title

# We can add some other things to help us understand the data too
abline(h=median(elgCrime$UOF_only), lty=2, lwd=2) 
# adds horizontal line for median UOF incidents which looks to be about 19
abline(v=median(elgCrime$Total_RTR_incidents), lwd=2, col="red") 
# adds vertical red line for median RTR incidents, about 36
abline(lm(elgCrime$UOF_only~elgCrime$Total_RTR_incidents))
# adds a regression line, or a line approximating the running average
# (anything above the line would be above average)


# Now, let's take a look at all three RTR categories
# "Par" sets up the plot window to show three plots in 1 column (mfrow)
# mar is margins
par(mfrow=c(3,1),mar=c(4,4,2,1)) 

# Let's add the plot we already did
with(elgCrime, plot(Total_RTR_incidents, UOF_only)) # scatter plot
title(main = "UOF vs Total RTR incidents") # adds title
abline(h=median(elgCrime$UOF_only), lty=2, lwd=2) 
abline(v=median(elgCrime$Total_RTR_incidents), lwd=2, col="red") 
abline(lm(elgCrime$UOF_only~elgCrime$Total_RTR_incidents))

# now SOF 
with(elgCrime, plot(Total_RTR_incidents, SOF_only)) # scatter plot
title(main = "SOF vs Total RTR incidents") # adds title
abline(h=median(elgCrime$SOF_only), lty=2, lwd=2) 
abline(v=median(elgCrime$Total_RTR_incidents), lwd=2, col="red") 
abline(lm(elgCrime$SOF_only~elgCrime$Total_RTR_incidents))

# finally, transitions
with(elgCrime, plot(Total_RTR_incidents, Total_transitions)) # scatter plot
title(main = "Transitions vs Total RTR incidents") # adds title
abline(h=median(elgCrime$Total_transitions), lty=2, lwd=2) 
abline(v=median(elgCrime$Total_RTR_incidents), lwd=2, col="red") 
abline(lm(elgCrime$Total_transitions~elgCrime$Total_RTR_incidents))

# You may need to make your plot window larger to see the results
# again, not enough data for any insights but it does appear
# that while all RTR increase about the same rate,
# there are not only more UOF incidents per quarter but
# there are more quarters with higher-than-average UOF incidents
# than SOF or transitions.

# Now let's save this as a PDF
# dev.cur() starts the process
dev.cur() 
# creates an empty pdf with w/h in inches
pdf(file="myplot.pdf", width = 4, height = 6) 

# make the space
par(mfrow=c(3,1),mar=c(4,4,2,1)) 

# adds the plots
with(elgCrime, plot(Total_RTR_incidents, UOF_only)) # scatter plot
title(main = "UOF vs Total RTR incidents") # adds title
abline(h=median(elgCrime$UOF_only), lty=2, lwd=2) 
abline(v=median(elgCrime$Total_RTR_incidents), lwd=2, col="red") 
abline(lm(elgCrime$UOF_only~elgCrime$Total_RTR_incidents))

with(elgCrime, plot(Total_RTR_incidents, SOF_only)) # scatter plot
title(main = "SOF vs Total RTR incidents") # adds title
abline(h=median(elgCrime$SOF_only), lty=2, lwd=2) 
abline(v=median(elgCrime$Total_RTR_incidents), lwd=2, col="red") 
abline(lm(elgCrime$SOF_only~elgCrime$Total_RTR_incidents))

with(elgCrime, plot(Total_RTR_incidents, Total_transitions)) # scatter plot
title(main = "Transitions vs Total RTR incidents") # adds title
abline(h=median(elgCrime$Total_transitions), lty=2, lwd=2) 
abline(v=median(elgCrime$Total_RTR_incidents), lwd=2, col="red") 
abline(lm(elgCrime$Total_transitions~elgCrime$Total_RTR_incidents))


dev.off() # Then turn off dev and you can view the plot


# --------------
