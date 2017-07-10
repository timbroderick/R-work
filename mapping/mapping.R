# This is the mapping tutoral found at
# https://github.com/Robinlovelace/Creating-maps-in-R/blob/master/README.md

#---------------------------------
# Part 1: Introduction

# demo of R sytax
x <- 1:400
y <- sin(x / 10) * exp(x * -0.01)
plot(x, y)

# check libraries
library(dplyr) # for working with data
library(tidyr) # for working with data
library(rgeos) # needed for ggplot
library(rgdal)
library(maptools)
library(tmap)
library(RColorBrewer) # for my color ramp
library(ggmap)

qplot(x,y) + geom_smooth(method = "lm")

# --------------------
# Part II: Spatial data in R

# Loading shapefiles

lnd <- readOGR(dsn = "data/london_sport.shp")

# divides things into slots geodata in one, data in another etc
# Access it with @, not $
head(lnd@data, n = 10)
summary(lnd@data)

mean(lnd$Partic_Per) # access columns within data the same way
# Below will not work
# mean(lnd$Pop_2001) 
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

# Select zones where sports participation is between 20 and 25%
sel <- lnd$Partic_Per > 20 & lnd$Partic_Per < 25
# Plot only shows selected areas
plot(lnd[sel, ])
# test output of previous selection 
head(sel) 

# plot the london_sport object
# col is color
plot(lnd, col = "lightgrey") 
# select areas where % participation is more than 25
# and 2001 pop is greater than the median for all
sel <- lnd$Partic_Per > 25 & lnd$Pop_2001 > 216505
# add selected zones to map
plot(lnd[ sel, ], col = "turquoise", add = TRUE) 

head(lnd@data, n=35)

# ------------------------------------------
# Challenge. Select areas within 10 km of London center

lnd_cent = gCentroid(lnd) # finds center of map
lnd_cent
class(lnd_cent)

# Finds centerpoints of all features by row number
lnd_cents = gCentroid(lnd, byid = T)

lnd_central = lnd[lnd_cent,]
lnd_central

# start the map
plot(lnd, col = "lightgrey")

# Add a marker for all the centerpoints
plot(lnd_cents, add = T)

# create a buffer 
cent_buffer = gBuffer(lnd_cent, width = 10000) # 10 km = 10000 meters

# select the centerpoints of the features
# from lnd_cents that intersect the buffer
cents_central = lnd_cents[cent_buffer,]
plot(cents_central, add = T, col = "red")

lnd_near_cent = lnd[cents_central,]
plot(lnd_near_cent, add = T, col = "blue")

# add a circle for the buffer zone
plot(cent_buffer, add = T, lwd = 4) # lwd is line width
# and add the centerpoints back in
plot(cents_central, add = T, col = "red")


# Here's some misc code -----
plot(lnd, col = "lightgrey")
# This adds the centermost item, 
# along with a point for the center
plot(lnd_central, add = T, col = "blue")
points(lnd_cent, col = "red") # adds an open circle

# This would select all the items that touch the buffer zone
# not just the ones with centerpoints in the zone
lnd_near_cent = lnd[cent_buffer,]
plot(lnd_near_cent, add = T, col = "light blue")
# grab the centerpoints of all these
lnd_nears = gCentroid(lnd_near_cent, byid = T)
# add the points
plot(lnd_nears, add = T, col = "red")


# --------------------------------
# --------------------------------
# Use the center points (x = 1, y = 2) of the map 
# to find the four quadrants of london
easting_lnd <- coordinates(gCentroid(lnd))[[1]]
easting_lnd # finds center left/right (east/west)
northing_lnd <- coordinates(gCentroid(lnd))[[2]]
northing_lnd # finds center top/bottom (north/south)

# arguments to test whether or not a coordinate is east or 
# north of the center of the map. Results in true or false
# if greater than, then is east/north
east <- sapply(coordinates(lnd)[,1], function(x) x > easting_lnd)
north <- sapply(coordinates(lnd)[,2], function(x) x > northing_lnd)
#east and north are true/false vectors for each row

# now use the same thing but less than east and north centroid
west <- sapply(coordinates(lnd)[,1], function(x) x < easting_lnd)
south <- sapply(coordinates(lnd)[,2], function(x) x < northing_lnd)

# test if the coordinate is east and north of the centre
lnd$quadrant <- "unknown" # prevent NAs in result
# basically, if true, put this word in column quadrant
lnd$quadrant[east & north] <- "northeast" 
lnd$quadrant[west & north] <- "northwest"
lnd$quadrant[east & south] <- "southeast"
lnd$quadrant[west & south] <- "southwest"

head(lnd@data)

plot(lnd, col = "lightgrey") 
NE <- lnd$quadrant == "northeast"
NW <- lnd$quadrant == "northwest"
SE <- lnd$quadrant == "southeast"
SW <- lnd$quadrant == "southwest"
# add selected zones to map
plot(lnd[ NE, ], col = "seagreen1", add = TRUE) 
plot(lnd[ NW, ], col = "yellow", add = TRUE) 
plot(lnd[ SE, ], col = "plum2", add = TRUE) 
plot(lnd[ SW, ], col = "salmon", add = TRUE) 
llgridlines(lnd, lty=3)
dev.off() # clear all plots

# format map as challenged
plot(lnd, col = "lightgrey") 
plot(lnd[ NE, ], col = "seagreen1", lwd = 6, add = TRUE) 
plot(lnd[ NE, ], col = "seagreen1", add = TRUE) 
plot(lnd[ NW, ], col = "yellow", lwd = 6, add = TRUE) 
plot(lnd[ NW, ], col = "yellow", add = TRUE) 
plot(lnd[ SE, ], col = "plum2", lwd = 6, add = TRUE) 
plot(lnd[ SE, ], col = "plum2", add = TRUE) 
plot(lnd[ SW, ], col = "salmon", lwd = 6, add = TRUE) 
plot(lnd[ SW, ], col = "salmon", add = TRUE) 
dev.off()

# ------------------------
# Part III: Creating and manipulating spatial data

# R objects can be created by entering the name of the 
# class we want to make. vector and data.frame objects 
# for example, can be created as follows:
vec <- vector(mode = "numeric", length = 3)
df <- data.frame(x = 1:3, y = c(1/2, 2/3, 3/4))

# The same logic applies to spatial data. 
# The input must be a numeric matrix or data.frame:
sp1 <- SpatialPoints(coords = df)
class(sp1)
sp1
plot(sp1)

# add dataframe data to specific object
spdf <- SpatialPointsDataFrame(sp1, data = df)
class(spdf)

# below won't work as it's trying to add a vector
# sp2 <- SpatialPoints(coords = vec)

# ----------
# Setting or correcting projections
proj4string(lnd) <- NA_character_ # remove CRS information from lnd
proj4string(lnd) <- CRS("+init=epsg:27700") # assign a new CRS
EPSG <- make_EPSG() # create data frame of available EPSG codes
EPSG[grepl("WGS 84$", EPSG$note), ] # search for WGS 84 code 
lnd84 <- spTransform(lnd, CRS("+init=epsg:4326")) # reproject
# Save lnd84 object (we will use it in Part IV)
saveRDS(object = lnd84, file = "data/lnd84.Rds")
rm(lnd84) # remove the lnd object
# we will load it back in later with readRDS(file = "data/lnd84.Rds")

dev.off()
#----------------
# Attribute joins

lnd <- readOGR("data/london_sport.shp")
plot(lnd) # plot the lnd object
nrow(lnd) # return the number of rows 

summary(lnd@data)
lnd$Pop_2001 <- as.numeric(as.character(lnd$Pop_2001))
summary(lnd@data)

# Create and look at new crime_data object
crime_data <- read.csv("data/mps-recordedcrime-borough.csv", stringsAsFactors = FALSE)
head(crime_data$CrimeType) # information about crime type

# Get all the "Theft & Handling" crimes and save into crime_theft
crime_theft <- crime_data[crime_data$CrimeType == "Theft & Handling", ]
head(crime_theft, n=12) 

# Group by district, sum crime count, save into crime_ag
# CrimeCounty by Bourough, FUNction = sum, data source = crime_theft
crime_ag <- aggregate(CrimeCount ~ Borough, FUN = sum, data = crime_theft)
# view aggregated crime data
head(crime_ag, n = 12)
summary(crime_ag)

# let's see if we can join by borough name
lnd$name %in% crime_ag$Borough
# Return rows which do not match
lnd$name[!lnd$name %in% crime_ag$Borough]

# Return Borough name that's not in lnd
crime_ag$Borough[!crime_ag$Borough %in% lnd$name]

# what's in that row
crime_ag[25,]

# Now join
lnd@data <- left_join(lnd@data, crime_ag, by = c('name' = 'Borough'))

# Now using tmap library we can examine things
# https://cran.r-project.org/web/packages/tmap/vignettes/tmap-nutshell.html
qtm(lnd, "CrimeCount") # plot the basic map
?qtm

qtm(lnd, "CrimeCount", fill.n=9, fill.palette="div", fill.auto.palette.mapping=FALSE, 
fill.title="Crime count", fill.id="name", format="World", style="gray")
vignette("tmap-nutshell")

dev.off()

qtm(shp = lnd, fill = "Partic_Per", fill.palette = "Blues")

qtm(shp = lnd, fill = c("Partic_Per", "Pop_2001", "CrimeCount"), 
    fill.palette = "Blues", fill.style="quantile", ncol = 3, 
    format="World", style="gray") 


qtm(shp = lnd, fill = c("Partic_Per", "Pop_2001", "CrimeCount"), 
    fill.palette = colorRampPalette(c("white","blue"))(5), 
    fill.style="quantile", ncol = 3, 
    format="World", style="gray")


?tmap_style
?RColorBrewer
brewer.pal.info
display.brewer.pal(5, "BrBG")
display.brewer.all()
brewer.pal(5, "BrBG")
?tm_fill

myramp <- colorRampPalette(c("#a6611a", "#dfc27d", "#ffffcc", "#80cdc1", "#018571"))(5)

tmmap <- tm_shape(lnd) + 
  tm_fill(col = c("Partic_Per", "Pop_2001", "CrimeCount"), 
          palette = "div", 
          auto.palette.mapping = FALSE,
          style = "quantile") + 
  tm_borders(alpha=.5) +
  tm_layout( bg.color = "white", 
             aes.palette = list(seq = "YlOrBr", div = myramp, cat = "Set3"),
             frame = F,
             legend.outside=T,
             legend.outside.position = "left"
             )
tmmap

tmmap <- tm_shape(lnd) + 
  tm_fill(col = "CrimeCount", 
          palette = "div", 
          auto.palette.mapping = FALSE,
          style = "quantile") + 
  tm_borders(col="black") +
  tm_layout( bg.color = "white", 
             aes.palette = list(seq = "YlOrBr", div = myramp, cat = "Set3"),
             frame = F,
             legend.outside=T,
             legend.outside.position = "right"
  )
tmmap

save_tmap(tmmap, filename="test.pdf")


# using ggplot to map
library(ggplot2)
library(ggmap)
library(ggthemes)

# working with ggplot means the data has to be saved in a 
# different way. 
head(lnd@data, n = 10)
class(lnd)

# Using maptools or rgeos, fortify transforms the shapefile
# into a dataframe
lnd_f <- fortify(lnd)
# let's look at the dataframe
head(lnd_f, n = 5) 
tail(lnd_f,n =5)
# Fortify looks like it takes each polygon in a shapefile
# and changes it to a groupable set of points
# groupable based on ID
summary(lnd_f)

class(lnd_f) 
dim(lnd_f) 
object.size(lnd_f) 
names(lnd_f) 

# Once we have this dataframe, we have to rejoin the 
# data associated with it.
# first, give lnd@data a new row id whose content
# is the row number, starting at 0
lnd$id <- row.names(lnd) 
head(lnd@data, n = 33)
# lnd$id will joing with lnd_f$id
lnd_f <- left_join(lnd_f, lnd@data)

head(lnd_f, n=5)

# now we can map using ggplot2

myramp <- colorRampPalette(c("#a6611a", "#dfc27d", "#ffffcc", "#80cdc1", "#018571"))(5)


map <- ggplot(lnd_f, 
              aes(long, lat, group = group, fill = Partic_Per)) +
  geom_polygon() + coord_equal() +
  theme_fivethirtyeight()

map <- map + labs(
  title="London sports participation", # your headline
  subtitle="subtitle here",
  caption="\nNote: Location of caption",
  fill = "% participation")


map <- map + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.title=element_text(size=16),
  legend.text=element_text(size=12),
  plot.caption=element_text(size=14, hjust=0),
  legend.position="top", 
  legend.direction="horizontal",
  axis.text.x=element_blank(),
  axis.text.y=element_blank()
  )

map

# work the quantile using this tutorial
# https://timogrossenbacher.ch/2016/12/beautiful-thematic-maps-with-ggplot2-only/#discrete-classes-with-quantile-scale