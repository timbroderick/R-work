# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names
names(df)

# let's start with a basic line chart
plot(df$Total_RTR_incidents, type="b",
     xlab = "Year, Quarter", 
     ylab = "Incidents",
     main = "Total RTR incidents")

# right off the bat, there's a problem with the 
# year, quarter labels. it's taking the index number
# of the row and we can't assign labels in the basic plot
# We also can't set x and y ranges

# To overcome this, we have to build the chart
# in steps

# first we set the x and y range
# x range equal the number of rows in Year_Quarter
# NROW all caps counts those

xrange <- range(1,NROW(df$Year_Quarter))
xrange
# then we need the greater of either SOF, UOF or Transitions
# Range finds that for us
yrange <- range(0,df$SOF_only,df$UOF_only,df$Total_transitions)
yrange

# set up the plot with x and y range, n = no chart type
# and axes = false
plot(xrange, yrange, type="n", axes=FALSE,
     xlab = "Year, Quarter", ylab = "Incidents",
     main = "Total RTR incidents")

# add the lines individually
# line type is b, or lines and dots
# pch is a filled dot, lwd is line size of 2 (1 is default)
lines(df$SOF_only, type = "b", pch=19, col = "orange", lwd=2)
lines(df$UOF_only, type = "b", pch=19, col = "blue", lwd=2)
lines(df$Total_transitions, type = "b", pch=19, col = "darkgreen", lwd=2)

# now add the axis - x first (1)
# las = 1 (labels horizontal)
# at is the number of ticks, which is the second number in
# xrange. So ticks from 1 to 12
axis(1, las=1, at=1:xrange[2], 
     tck = .05, # set the ticks to be inside plot
     # Since we're creating custom labels, we need 12 of them
     # so "" at 1, then 2014 2Q and etc
     # notice we can split the lines with \n
     # and the x label adjusts down to accomodate
     lab=c("","2014\n2Q","","2014\n4Q","","2015\n2Q","","2015\n4Q","","2016\n2Q","","2016\n4Q") )
# for our y axis, set it to count by 5 for the range
# of yrange. LAS labels horizontal. ticks all the way 
# across (1) and the line type as dots lty=3
axis(2, las=1, at=5*0:yrange[2], tck = 1, lty=3)

# Create a legend at top, left (x=1, y=yrange)
# (cex) makes it 80% of the base size
legend(1, yrange[2], c("SOF Only","UOF only", "Transition"), 
       cex=0.8, col=c("Orange","blue","darkgreen"), pch=19, lwd=2)

#----Set up plot for print and online --------
dev.cur()
# note that we had to make the width wider than 4
# to accomodate the x labels
#pdf(file="myplotLines.pdf", width = 6, height = 4) 
png(filename = "myplotlines.png",width = 600, height = 400, units = "px")
#-----Insert plot here -------------

plot(xrange, yrange, type="n", axes=FALSE,
     xlab = "Year, Quarter", ylab = "Incidents",
     main = "Total RTR incidents")
lines(df$SOF_only, type = "b", pch=19, col = "orange", lwd=2)
lines(df$UOF_only, type = "b", pch=19, col = "blue", lwd=2)
lines(df$Total_transitions, type = "b", pch=19, col = "darkgreen", lwd=2)
axis(1, las=1, at=1:xrange[2], tck = .05, lab=c("","2014\n2Q","","2014\n4Q","","2015\n2Q","","2015\n4Q","","2016\n2Q","","2016\n4Q") )
axis(2, las=1, at=5*0:yrange[2], tck = 1, lty=3)
legend(1, yrange[2], c("SOF Only","UOF only", "Transition"), 
       cex=0.8, col=c("Orange","blue","darkgreen"), pch=19, lwd=2)


#----- End plot --------------
dev.off() 


