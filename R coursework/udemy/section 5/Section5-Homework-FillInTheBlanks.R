# Scatterplot - life expectancy (y) v Fertility rate (x) by country
# Categorise by region
# one for 1960, another for 2013
# read data in, combine with vectors
# how do both compare

#Set the Working Directory
getwd()
setwd("~/Desktop/R-work/R coursework/udemy/section 5")
getwd()

#Import the csv dataset
data <- read.csv("Section5-Homework-Data.csv")

#Explore the data
data
head(data)      #check top 6 rows
tail(data, n=7) #check bottom 7 rows
str(data)      #check the structure of the data frame
summary(data)      #check the summary of the data

#Did you pick up that there is more than one year in the data?
#From the challenge we know that there are two: 1960 and 2013

#Filter the dataframes
data1960 <- data[data$Year==1960,]
data2013 <- data[data$Year==2013,]

#Check row counts
nrow(data1960) #187 rows
nrow(data2013) #187 rows. Equal split.

#Create the additional dataframes
add1960 <- data.frame(Code=Country_Code, Life.Exp=Life_Expectancy_At_Birth_1960)
add2013 <- data.frame(Code=Country_Code, Life.Exp=Life_Expectancy_At_Birth_2013)

#Check summaries
summary(add1960)
summary(add2013)

?merge
#Merge the pairs of dataframes  
merged1960 <- merge(data1960, add1960, by.x="Country.Code", by.y="Code")
merged2013 <- merge(data2013, add2013, by.x="Country.Code", by.y="Code")

#Check the new structures
str(merged1960)
summary(merged1960)
str(merged2013)

#We can see an obsolete column in each of the merged dataframes
#Column "Year" is no longer required. Let's remove it
merged1960$Year <- NULL
merged2013$Year <- NULL

#Check structures again
str(merged1960)
str(merged2013)

#Visualization time
library(ggplot2)

?qplot
#Visualize the 1960 dataset
qplot(data=merged1960, x=Fertility.Rate, y=Life.Exp,
      color=Region,                               #colour
      size=I(5), 
      alpha=I(0.6),                               #transparency
      main="Life Expectancy vs Fertility (1960)", #title
      xlim = c(0, 10), ylim = c(15, 90)
   )

#Visualize the 2013 dataset
qplot(data=merged2013, x=Fertility.Rate, y=Life.Exp,
      color=Region,                               #colour
      size=I(5), 
      alpha=I(0.6),                               #transparency
      main="Life Expectancy vs Fertility (2013)", #title
      xlim = c(0, 10), ylim = c(15, 90)
)






