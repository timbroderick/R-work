# Continuing to work with the RTR data

library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

# Before we can start working with ggplot we need to make the data long, not wide
# using the tidyr library, developed especially for this purpose

library(tidyr)

dfsort <-df[order(df$Year_Quarter),]
head(dfsort)
# add column containing the row number. We can use this to sort later
dfsort$sort <- seq.int(nrow(dfsort)) 
head(dfsort)

dfsub <- gather(dfsort, set, value, 7:9, factor_key=TRUE)

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

dfrtr <- subset(dfsort, select = c("year","Year_Quarter","Total_RTR","sort"))

write_csv(dfrtr,"dfrtr.csv")

# Next: Bar charts