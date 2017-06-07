# Continuing to work with the RTR data

library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

# Before we can start working with ggplot
# we need to make the data long, not wide
# first grab the columns we want
dfUOF <- subset(df, select = c("years","Year_Quarter","UOF_only"))
dfSOF <- subset(df, select = c("years","Year_Quarter","SOF_only"))
dfTRAN <- subset(df, select = c("years","Year_Quarter","Total_transitions"))
# add columns for label purposes
dfUOF$force <- "UOF_only"
dfSOF$force <- "SOF_only"
dfTRAN$force <- "Total_transitions"
# now rename UOF SOF etc to common name
names(dfUOF)[names(dfUOF)=="UOF_only"] <- "value"
names(dfSOF)[names(dfSOF)=="SOF_only"] <- "value"
names(dfTRAN)[names(dfTRAN)=="Total_transitions"] <- "value"

# Now we can append the three data frames
dfsub <- rbind(dfUOF,dfSOF,dfTRAN)
dfsub
# let's save this 
write_csv(dfsub,"dfsubset.csv")

# Take a moment to compare df with dfsub
# This is one of the hardest parts of working with
# any of these programs - getting the data into the shape
# programs want it to be in.
# I know I'm very used to the excel way of working
# where there are multiple columns of data.
# Instead, R (and other programs that do this kind of thing)
# wants a single column of data with other columns that 
# describe the data.

# You'll encounter often this as you progress 
# so it's just a matter of getting used to it

# before we go on, let's create another subset, this time
# just with the total RTR data

# first grab the columns we want
dfrtr <- subset(df, select = c("years","Year_Quarter","Total_RTR_incidents"))
# and save it 
write_csv(dfrtr,"dfRTR.csv")

# Next: Bar charts