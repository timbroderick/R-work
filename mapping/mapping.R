# Introduction ------------

# demo of R sytax
x <- 1:400
y <- sin(x / 10) * exp(x * -0.01)
plot(x, y)

# check libraries
library(dplyr) # installed
library(tidyr) # installed
library(ggmap)
library(rgeos)
library(rgdal)
library(maptools)
library(tmap)
library(ggthemes)

qplot(x,y) + geom_smooth(method = "lm")

# Loading shapefiles

lnd <- readOGR(dsn = "data/london_sport.shp")

# divides things into slots geodata in one, data in another etc
# Access it with @, not $
head(lnd@data, n = 10)
summary(lnd@data)

mean(lnd$Partic_Per) # access columns within data the same way
mean(lnd$Pop_2001) # not reading population as a number

# change it be numeric
lnd$Pop_2001 <- as.numeric(as.character(lnd$Pop_2001))

# check class
sapply(lnd@data, class)
summary(lnd@data)

# check the projection
lnd@proj4string

plot(lnd) # wow, it's mapped

# subsetting
# select rows of lnd@data where sports participation is less than 13
lnd@data[lnd$Partic_Per < 15,]

lnd@data[1:2,1:3] # first two rows, first three columns

