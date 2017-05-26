# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names
names(df)

?plot
xrange <- c(1,12)
yrange <- c(0,60)

plot(xrange, yrange, type="n", axes=FALSE,
     xlab = "Year, Quarter", ylab = "Incidents",
     main = "Total RTR incidents")

lines(df$Total_RTR_incidents, type = "o", col = "red", lwd=2)
lines(df$SOF_only, type = "l", col = "orange", lwd=2)
lines(df$UOF_only, type = "l", col = "blue", lwd=2)
lines(df$Total_transitions, type = "l", col = "darkgreen", lwd=2)

#?axis
axis(1, las=1, at=2*0:xrange[2], labels=FALSE)
#axis(1, at=1:5, lab=c("Mon","Tue","Wed","Thu","Fri"))

axis(2, las=1, at=10*0:yrange[2])



# -----------

# Define 2 vectors
cars <- c(1, 3, 6, 4, 9)
trucks <- c(2, 5, 4, 5, 12)

# Calculate range from 0 to max value of cars and trucks
g_range <- range(0, cars, trucks)

# Graph autos using y axis that ranges from 0 to max 
# value in cars or trucks vector.  Turn off axes and 
# annotations (axis labels) so we can specify them ourself
plot(cars, type="o", col="blue", ylim=g_range, 
     axes=FALSE, ann=FALSE)

# Make x axis using Mon-Fri labels
axis(1, at=1:5, lab=c("Mon","Tue","Wed","Thu","Fri"))

# Make y axis with horizontal labels that display ticks at 
# every 4 marks. 4*0:g_range[2] is equivalent to c(0,4,8,12).
axis(2, las=1, at=4*0:g_range[2])

# Create box around plot
box()

# Graph trucks with red dashed line and square points
lines(trucks, type="o", pch=22, lty=2, col="red")

# Create a title with a red, bold/italic font
title(main="Autos", col.main="red", font.main=4)

# Label the x and y axes with dark green text
title(xlab="Days", col.lab=rgb(0,0.5,0))
title(ylab="Total", col.lab=rgb(0,0.5,0))

# Create a legend at (1, g_range[2]) that is slightly smaller 
# (cex) and uses the same line colors and points used by 
# the actual plots 
legend(1, g_range[2], c("cars","trucks"), cex=0.8, 
       col=c("blue","red"), pch=21:22, lty=1:2)

