# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names
names(df)

# Simple bar chart - note we made it horizontal.
# column charts are vertical, but also harder
# to make x labels work.

#--------
# let's take a look at some graphical paramenters (par)
?par
par(las=1) # make label text always horizontal. 
# Set the margins to adjust for the labels
# margin goes bottom, left, top, right
par(mar=c(5,5,2,2)) # mar is in lines, mai in inches
par(pin=c(4,2.75)) # size of plot in inches
# all of the above applies to all the plots we're doing

#-----------

# for cex, 1 = 100%
# first a simple bar chart for all RTR incidents
barplot(df$Total_RTR, horiz=TRUE, 
        names.arg = df$Year_Quarter, cex.names=0.8,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col="blue")
# -----------

# Next, let's try a stacked bar plot
# stacked charts take multiple values and
# stack the bars on top of each other.
# so what we're doing is taking total RTR incidents
# from above and showing the portion of the total
# by SOF, UOF and transitions


# But first we have to work the data a little
# We have to put the three sets into a matrix.
# BUT - and this is where it's tricky, 
# we're going to make each column equal to a quarter
# and the rows equal to the three sets
# To do that, we'll load the data into a matrix
# and then transpose it

# Load the data into the matrix
counts2 <- matrix(c(df$SOF_only,df$UOF_only,df$Transitions),ncol=3)
counts2
# name the columns
colnames(counts2)=c("SOF_only","UOF_only","Transitions")
# name the rows by the year/quarter
rownames(counts2)=df$Year_Quarter
counts2

# now, let's transpose it using "t"
counts <- t(counts2)
counts


# Now let's do the barplot, adding a legend to the bottom
# Try it with counts and counts2 to see what happenss

barplot(counts, horiz=TRUE, cex.names=0.8,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col=c("darkgreen","darkblue","red"),
        legend = rownames(counts),
        args.legend = list(x ='bottomright', inset=0.01)
)
        
# Finally, adding "beside" changes a stacked chart
# into a grouped chart, with the bars next to each other
barplot(counts, horiz=TRUE, cex.names=0.8,
        beside=TRUE,
        main="RTR incidents by year, quarter",
        xlab = "Number of incidents",
        col=c("darkgreen","darkblue","red"),
        legend = rownames(counts),
        args.legend = list(x ='bottomright', inset=0.01)
)

# which is better - stacked or grouped? 
# depends on your data and what you want to show
# but now it's easy to try them both