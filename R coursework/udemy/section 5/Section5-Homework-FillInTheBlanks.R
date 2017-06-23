#Set the Working Directory
getwd()
setwd("_")
getwd()

#Import the csv dataset
data <- _("Section5-Homework-Data.csv")

#Explore the data
data
_(data)      #check top 6 rows
_(data, _=7) #check bottom 7 rows
_(data)      #check the structure of the data frame
_(data)      #check the summary of the data

#Did you pick up that there is more than one year in the data?
#From the challenge we know that there are two: 1960 and 2013

#Filter the dataframes
data1960 <- data[data$_==1960,]
data2013 <- __________

#Check row counts
_(data1960) #187 rows
_(data2013) #187 rows. Equal split.

#Create the additional dataframes
add1960 <- _(Code=_, Life.Exp=_)
add2013 <- _(_=_, _=_)

#Check summaries
_(add1960)
_(add2013)

#Merge the pairs of dataframes  
merged1960 <- _(data1960, add1960, _="Country.Code", _="Code")
merged2013 <- _(_, _, _=_, _=_)

#Check the new structures
_(merged1960)
_(merged2013)

#We can see an obsolete column in each of the merged dataframes
#Column "Year" is no longer required. Let's remove it
merged1960$_ <- _
___ <- _

#Check structures again
_(merged1960)
_(merged2013)

#Visualization time
library(_)

#Visualize the 1960 dataset
_(_=merged1960, _=Fertility.Rate, _=Life.Exp,
      _=Region,                               #colour
      size=_(5), 
      _=_(0.6),                               #transparency
      _="Life Expectancy vs Fertility (1960)" #title
   )

#Visualize the 2013 dataset
_





