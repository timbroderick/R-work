# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# let's get the column names again
summary(df)

# Now lets see this as a scatter plot
with(df, plot(Total_RTR, UOF_only)) # scatter plot
title(main = "UOF vs Total RTR incidents") # adds title
# What you're seeing here
# The first line of code, starting "with", creates a scatter plot. 
# First we say what dataset we want (elgCrime), then
# what we want to test - Total RTR incidents vs UOF only
# What it shows is that as there are more RTR incidents, 
# the number of incidents that involve UOF only also grows.
# Title obviously adds a title

# We can add some other things to help us understand the data too
abline(h=median(df$UOF_only), lty=2, lwd=2) 
# adds horizontal line for median UOF incidents which looks to be about 19
abline(v=median(df$Total_RTR), lwd=2, col="red") 
# adds vertical red line for median RTR incidents, about 36


fit <- lm(df$UOF_only~df$Total_RTR)
summary(fit)
# Lots to uppack here. Honestly, I am not qualified to
# explain in detail these more advanced statistic measures. 
# What follows is a very over-simplified explanation. 
# Look at the last three lines. Generally, you want ...
# A) your Adjusted R-square to be as close to 1.00 as possible
#    here it's 0.6556, which means it's estimated that 
#    about 66 percent of the observations can be explained by
#    the relationship between the two data set
#    Which makes sense - the more Totol RTR incidents there are
#    the more you see UOF_only incidents
# B) the p-value to be less that 0.05

# HOWEVER: Don't expect too much out of these stats - we're using a very 
# small dataset so it's not going to be very informative and may even
# cause confusing results. Look at the portion labeled Coefficients:

# C) Std. Error and t value. You want the two t values to be as large 
#    as possible versus the std errors. It is for one line 
#     and not the other. It's telling us that with only 12 datapoints, 
#    it's not able to make any definitive predictions. It just
#    doesn't have enough data to tell whether any new points added
#    would likely fall along the regression line.
# D) And that confusion carries on into the Pr(>|t|) or p-value. 
#    It uses those T values and Error to compute the P-value
#    The top one is well over 0.05 which isn't good, but the bottom one 
#    is well under so much so that R has tagged it with *** 
#    indicating it's significant
# ------
# Statistics is a science. Our purpose in graphing these
# values out is to see how the data relates to the
# regression line and maybe spot outliers. We will seldom use 
# T values or R2 in our stories.
# But there's nothing wrong in knowing about these things. And in fact
# understanding when it's telling you that something's wrong can
# be very useful.
# Here's a link to a resource explaining what you see with the summary
# https://feliperego.github.io/blog/2015/10/23/Interpreting-Model-Output-In-R
# If you want to learn more about statistics, let me know. There's a 
# good textbook I can recommend.

# add the regression line, or a line approximating the running average
abline(fit)

# Now, let's take a look at all three RTR categories
# "Par" sets up the plot window to show three plots in 1 column (mfrow)
# mar is margins
par(mfrow=c(3,1),mar=c(4,4,2,1)) 

# Let's add the plot we already did
with(df, plot(Total_RTR, UOF_only)) # scatter plot
title(main = "UOF vs Total RTR incidents") # adds title
abline(h=median(df$UOF_only), lty=2, lwd=2) 
abline(v=median(df$Total_RTR), lwd=2, col="red") 
abline(lm(df$UOF_only~df$Total_RTR))

# now SOF 
with(df, plot(Total_RTR, SOF_only)) # scatter plot
title(main = "SOF vs Total RTR incidents") # adds title
abline(h=median(df$SOF_only), lty=2, lwd=2) 
abline(v=median(df$Total_RTR), lwd=2, col="red") 
abline(lm(df$SOF_only~df$Total_RTR))

# finally, transitions
with(df, plot(Total_RTR, Transitions)) # scatter plot
title(main = "Transitions vs Total RTR incidents") # adds title
abline(h=median(df$Transitions), lty=2, lwd=2) 
abline(v=median(df$Total_RTR), lwd=2, col="red") 
abline(lm(df$Transitions~df$Total_RTR))

# You may need to make your plot window larger to see the results
# again, not enough data for any insights but it does appear
# that while all RTR increase about the same rate,
# there are not only more UOF incidents per quarter but
# there are more quarters with higher-than-average UOF incidents
# than SOF or transitions.

# there's a better way of doing multiple plots that we'll look at later
