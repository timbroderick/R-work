#install_course_zip("swirl_courses-master/swirl_courses-master.zip", multi=TRUE, which_course="Open Intro")
install_course_zip("swirl_courses-master/swirl_courses-master.zip", multi=TRUE, which_course="Data Analysis")
0
#starting on data analysis, 1st lesson
library(swirl)
swirl()
Tim
3
1
1
1
1
1
2
3
2
3
1
4
4
2
1
2
# Completed first Exploratory data analysis: Principles of Analytic Gfx
# Next is 2: Exploratory Graphs
2
2
2
head(pollution)
dim(pollution)
summary(pollution$pm25)
1
2
quantile(ppm)
1
boxplot(ppm, col="blue")
3
abline(h=12) # annottates a plot with a line for a specific number
4
hist(ppm, col="green")
4
rug(ppm) # adds tick marks to histogram, showing density
low
high
hist(ppm, col="green",100)
3
rug(ppm)
hist(ppm, col="green")
abline(v=12, lwd=2)
# v = where to put vertical line, lwd = line weight
abline(v=median(ppm), col="magenta", lwd=4) 
names(pollution)
reg <- table(pollution$region) # subsets a matrices
reg
barplot(reg,col="wheat",main="Number of Counties in Each Region")
2
boxplot(pm25~region, data=pollution, col="red")
# setting up multiple plots in the plot window
# will have two rows and one column (mfrow. mar is the margins
par(mfrow=c(2,1),mar=c(4,4,2,1))
east <- subset(pollution, region == "east")
head(east)
hist(east$pm25, col = "green")
# creates a hist with a subset of west region, and pm25 column
hist(subset(pollution, region == "west")$pm25, col = "green")
with(pollution, plot(latitude, pm25) )
abline(h=12, lwd=2, lty = 2)
plot(pollution$latitude, ppm, col=pollution$region)
1
abline(h=12, lwd=2, lty=2)
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
west <- subset(pollution, region == "west")
plot(west$latitude, west$pm25, main="West")
plot(east$latitude, east$pm25, main="East")
4
1
4
1
3
2
# Finished 2. Next is 3: Graphics Devices in R
library(swirl)
swirl()
Tim
3
1

?Devices

dev.cur() # open the device (screen)
pdf(file="myplot.pdf") # first create the PDF
with(faithful, plot(eruptions, waiting)) # then the plot
title(main="Old Faithful Geyser data") # add a title
dev.copy(png, file="geyserplot.png")
dev.off() # Then turn off dev and you can view the plot
dev.cur()

# 3rd ADA course done. Next is 4: Plotting systems
library(swirl)
swirl()
tim
3
1
4
4
4
head(cars)
# base plot functions
with(cars, plot(speed, dist))
text(mean(cars$speed), max(cars$dist), "SWIRL rules!")
# Lattice plot function
head(state)
table(state$region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(2,2) )
1
# ggplot2
head(mpg)
dim(mpg)
table(mpg$model)
qplot(displ, hwy, data = mpg)
3
2
4
2
1
4
2
3
1
# End 4, starting 5: Base plotting system
library(swirl)
swirl()
Tim
3
1
5
head(airquality)
range(airquality$Ozone, na.rm = TRUE)
hist(airquality$Ozone)
1
table(airquality$Month)
boxplot(Ozone~Month, airquality, xlab="Month", ylab="Ozone (ppb)",col.axis="blue",col.lab = "red")
title(main = "Ozone and Wind in New York City")

with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in New York City")
# basic plotting fuctions found in ?par
length(par())
names(par())
par()$pin
4
par("fg")
1
1
4
par("pch")
3
par("lty")
1
3
plot(airquality$Wind, airquality$Ozone, type = "n")
title(main = "Wind and Ozone in NYC")
may <- subset(airquality, Month==5)
points(may$Wind,may$Ozone,col="blue",pch=17)
notmay <- subset(airquality, Month!=5)
?points
points(notmay$Wind,notmay$Ozone,col="red",pch=8)
legend("topright", pch = c(17,8), col = c("blue","red"), legend = c("May", "Other Months"))
?line
abline(v=median(airquality$Wind), lty=2, lwd=2)
# side by side plots
par(mfrow=c(1,2) )
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Ozone, airquality$Solar.R, main = "Ozone and Solar Radiation")
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
plot(airquality$Solar.R, airquality$Ozone, main = "Ozone and Solar Radiation")
plot(airquality$Temp, airquality$Ozone, main = "Ozone and Temperature")
mtext("Ozone and Weather in New York City", outer = TRUE)
2
3
0

# End 5, starting 6: Lattice graphics library

library(swirl)
swirl()
Tim
3
1
6
# Lattice is implemented using two packages. The first is called, not
# surprisingly, lattice, and it contains code for producing Trellis
# graphics. Some of the functions in this package are the higher level
# functions which you, the user, would call. These include xyplot,
# bwplot, and levelplot.
# The lattice system, as the base does, provides several different
# plotting functions. These include xyplot for creating scatterplots,
# bwplot for box-and-whiskers plots or boxplots, and histogram for
# histograms. 
4
2
head(airquality)
xyplot(Ozone~Wind, airquality, col="red", pch=8, main="Big Apple Data")

# plots the relationship between Wind and Ozone, by month

xyplot(Ozone~Wind | as.factor(Month), data = airquality, layout = c(5,1))

1

xyplot(Ozone~Wind | Month, data = airquality, layout = c(5,1))

p <- xyplot(Ozone~Wind,data=airquality)
p
names(p)
mynames[myfull]
p[["formula"]]
p[["x.limits"]]
table(f)
xyplot( y~x|f, layout = c(2,1))
v1
v2
myedit("plot1.R")
source(pathtofile("plot1.R"), local=TRUE)
2
myedit("plot2.R")
source(pathtofile("plot2.R"), local = TRUE)
2
str(diamonds)
table(diamonds$color)
table(diamonds$color, diamonds$cut)
myedit("myLabels.R")
source(pathtofile("myLabels.R"), local=TRUE)
# plots price v carat, but each panel is color and cut
# So top left is price v carat by a certain color and cut
xyplot(price~carat | color*cut, data = diamonds, strip = FALSE, pch = 20, xlab = myxlab, ylab = myylab, main = mymain)
xyplot(price~carat | color*cut, data = diamonds, pch = 20, xlab = myxlab, ylab = myylab, main = mymain)
# strip = true labels each panel
1

# that was 6, Lattice plotting system - very cool
# now 7, working with colors
library(swirl)
swirl()
Tim
3
1
7
2
sample(colors(),10)
sink()
pal <- colorRamp(c("red","blue"))
pal(0)
1
1
pal(1)
2
2
2
pal(seq(0,1,len=6))
p1 <- colorRampPalette(c("red","blue"))
p1(2)
p1(6)
0xcc
p2 <- colorRampPalette(c("red","yellow"))
p2(2)
p2(10)
showMe(p1(20))
showMe(p2(20))
showMe(p2(2))
p1
?fun(rgb)
?fun
?rgb
4
p3 <- colorRampPalette(c("blue","green"),alpha=.5)
p3(5)
plot(x, y, pch=19, col=rgb(0,.5,.5,.3))
cols <- brewer.pal(3, "BuGn")
showMe(cols)
pal <- colorRampPalette(cols)
showMe(pal(20))
image(volcano, col = p1(20))
1
4
1
2
2
1
2
1
3
3
swirl()
tim
3
1
# Finished 7 colors, now starting 8 - GGplot2
0
0
library(swirl)
swirl()
Tim
3
1
8
4
1
2
1
2
str(mpg)
qplot(displ, hwy, data=mpg, color=drv, geom=c("point","smooth"))
qplot(y=hwy, data=mpg, color=drv)
summary(myhigh)
myhigh
qplot(drv,hwy,data=mpg,geom="boxplot",color=manufacturer)
qplot(hwy,data=mpg,fill=drv)
qplot(displ,hwy,data=mpg,facets=.~drv)
qplot(hwy,data=mpg,facets=drv~., binwidth=2)
# End ggplot part 1 (8), starting ggplot part 2 (9)