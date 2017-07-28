# The code in this file is described 
# in the pdf and html files of the same name

library(readr)
library(tidyr)

df <- read_csv("dfCrime.csv")

head(df)

# Before we can start working with ggplot we need to make the data long, not wide
# using the tidyr library, developed especially for this purpose

dfsort <-df[order(df$Year_Quarter),]
head(dfsort)

# add column containing the row number. We can use this to sort later
dfsort$sort <- seq.int(nrow(dfsort)) 
head(dfsort)

dfsub <- gather(dfsort, set, value, 7:9, factor_key=TRUE)

# Let's make the items in set more readable for labeling purposes
# Can also use this to set an order to the levels
dfsub$set <- factor(dfsub$set, levels = c("Transitions","SOF_only","UOF_only"),
                 labels = c("Transitions","Show of force","Use of force" ))

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