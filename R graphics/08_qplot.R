# Continuing to work with the RTR data
library(readr)
df <- read_csv("dfCrime.csv")

# notice we loaded in the version of the data with the years column
# Let's get the colummn names and summary data
names(df)
summary(df)

library(ggplot2)
library(ggthemes)


#--------
# qplot is a way to do quick exploratory graphics with ggplot
# qplot(x, y, data=, shape=, size=, alpha=, 
# geom=, method=, formula=, facets=, xlim=, ylim= xlab=, 
# ylab=, main=)
# http://www.statmethods.net/advgraphs/ggplot2.html

# simple histogram
qplot(Total_RTR_incidents,
      data=df,
      alpha=.05, # sets transparency 
      fill=factor(years)
)

# simple density
qplot(Total_RTR_incidents, data=df, 
      geom="density",
      color=factor(years),
      fill=factor(years),
      linetype = factor(years),
      alpha=I(.5),
      main="Distribution of RTR incidents", 
      xlab="Total RTR incidents",
      ylab="Density")


# simple scatter, with trend line and 95% conf
qplot(y=Total_RTR_incidents,
      data=df
      ) + geom_smooth(method = "lm")

# simple scatter, with years by color
qplot(y=Total_RTR_incidents,
      data=df,
      color=factor(years)
)

# simple scatter with smoothed trend line
# requires x value
qplot(UOF_only,Total_RTR_incidents,
      data=df,
      geom=c("point","smooth")
)

# simple scatter, lines not smoothed
# and years as factor
qplot(UOF_only,Total_RTR_incidents,
      data=df,
      color=factor(years)
) + geom_smooth(method = "lm")#, se = FALSE) 
# se would hide 95% conf

# facet grid compares SOF and UOF
# But divides space by year
# and by number of Total RTR incidents (facets)
qplot(UOF_only,SOF_only,
      data=df, 
      color=factor(years),
      facets = Total_RTR_incidents~factor(years),
      xlab="UOF", ylab="SOF")

# box plot
qplot(factor(years), SOF_only, 
      data=df, 
      geom=c("boxplot", "jitter"),
      fill=factor(years), 
      alpha=.5,
      main="SOF by Year",
      xlab="Year", ylab="SOF")

# dot plot
qplot(factor(years), SOF_only, 
      data=df, 
      geom=c("dotplot"),
      fill=factor(years), 
      stackdir = "center", binaxis = "y",
      main="SOF by Year",
      xlab="Year", ylab="SOF")


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
