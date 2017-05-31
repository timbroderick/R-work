# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

library(ggplot2)
library(ggthemes)

# need to make the data long, not wide
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

# stacked bars
pBar <- ggplot(dfsub, aes(Year_Quarter, value, fill = force)) + 
  geom_bar(position = "stack", stat="identity") + coord_flip()
pBar

# grouped bars
pBar2 <- ggplot(dfsub, aes(Year_Quarter, value, fill = force)) + 
  geom_bar(position = "dodge", stat="identity") + coord_flip()
pBar2

# line chart
pLine <- ggplot(dfsub, aes(Year_Quarter, value, group = force, col = force))
pLine + geom_point(stat="identity") + geom_line(stat="identity")

p1 <- ggplot() + geom_line(aes(y = value, x = Year_Quarter, group = force, colour = force),
                           data = dfsub, stat="identity")
p1
