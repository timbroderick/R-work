# lesson 1
library("swirl")
ls()
rm(list=ls())
ls()
swirl()
num_vect <- c(0.5,55,-10,6)
tf<- num_vect<1
num_vect >= 6

# Lesson 2
1
my_char <- c("My", "name", "is")
my_char
paste(my_char, collapse=" ")
my_name <- c(my_char, "Tim")
my_name
paste(my_name, collapse=" ")
paste("Hello", "world!", sep = " ")
paste(1:3, c("X", "Y", "Z"), sep="")
paste(LETTERS, 1:4, sep= "-")
1

# lesson 3

library("swirl")
swirl()
Tim

1
1
3
1:20
pi:10
15:1
?':'
seq(1,20)
seq(0,10,by=0.5)
seq(5,10, length=30)
seq(5, 10, length=30)
my_swq <- seq(5, 10, length=30)
my_seq <- seq(5, 10, length=30)
length(my_se)
length(my_seq)
1:length(my_seq)
seq(along.with = my_seq)
seq_along(my_seq)
rep(0, times =40)
rep(c(0, 1, 2), times = 10)
rep(c(0, 1, 2), each = 10)
1
1
# start on vectors next, Lesson 4

library('swirl')
swirl()
Tim
1
4
num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1
2
tf
num_vect>= 6
2
2
2
my_char <- c("My", "name", "is")
my_char
paste(my_char, collapse = " ")
my_name <- c(my_char, "Tim")
my_name
paste(my_name, collapse = " ")
paste("Hello", "world!", sep = " ")
paste(LETTERS,1:4,sep = "-")
1
1

for(i in c("l","e","t","t","e","r","s")){
  print(i)
}
# Missing values is next (5)

library(swirl)
swirl()
Tim
1
5

x <- c(44, NA, 5, NA)
x * 3
y <- rnorm(1000)
z <- rep(NA, 1000)
my_data <- sample(c(y, z), 100)
my_na <- is.na(my_data)
print(my_na)
my_na
my_data == NA
sum(my_na)
print(my_data)
my_data
0/0
Inf - Inf
2
1
# Lesson 6 Subsetting Vectors
6
x
x[1:10]
4
3
1
x[is.na(x)]
y <- x[!is.na(x)] # This finds all the non NA values and puts them in a new vector
y
y[y > 0]
x[x >0]
x[!is.na(x) & x > 0]
x[c(3,5,7)]
x[0]
x[3000]
x[c(-2,-10)]
x[-c(2,10)]
vect <- c(foo = 11, bar =2, norf = NA)
vect
names(vect)
vect2 <- c(11,2,NA)
names(vect2) <- c("foo","bar","norf")
identical(vect,vect2)
2
vect["bar"]
vect[c("foo","bar")]
1
2
swirl()
Tim
1
# Next course 7: Matrices and Data Frames
0
0
Library(swirl)
library(swirl)
swirl()
Tim
1
7
my_vector <- c(1:20)
my_vector <- 1:20
my_vector
dim(my_vector)
length(my_vector)
dim(my_vector) <- c(4,5)
dim(my_vector)
attributes(my_vector)
my_vector
class(my_vector)
my_matrix <- my_vector
?matrix
my_matrix2 <- matrix(data = 1:20, nrow = 4, ncol = 5)
my_matrix2 <- matrix(1:20, 4, 5)
my_matrix2 <- matrix(1:20, 4, 5)
my_matrix2 <- matrix(1:20, nrow=4, ncol=5)
my_matrix2 <- matrix(1:20, nrow=4, ncol=5)
identical(my_matrix, my_matrix2)
patients <- c("Bill", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix)
my_data <- data.frame(patients, my_matrix)
my_data
class(my_data)
cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data) <-cnames
my_data
1
1

# Next section is 8, "logic"
0
0
library(swirl)
swirl()
Tim
1
8
True == True
TRUE == TRUE
(FALSE == TRUE) == FALSE
6==7
6 < 7
10 <= 10
2
3
5 != 7
(5 == 7) == !TRUE
!(5==7)
3
4
FALSE & FALSE
TRUE & c(TRUE, FALSE, FALSE)
TRUE && c(TRUE, FALSE, FALSE)
TRUE | c(TRUE, FALSE, FALSE)
TRUE || c(TRUE, FALSE, FALSE)
5 > 8 || 6!= 8 && 4 > 3.9
4
1
isTRUE(6>4)
2
identical('twins', 'twins')
4
xor(5 ==6, !FALSE)

which(ints > 7)

any(ints < 0)
all(ints > 0)
3
1
1
# next is 9, functions

11
119
Sys.Date()
mean(c(2,4,5))
boring_function("My first function!")
boring_function

my_mean(c(4,5,10))

remainder(5)
remainder(11, 5)
remainder(divisor = 11, num = 5)
remainder(4, div = 2)
args(remainder)

evaluate(sd, c(1.4, 3.6, 7.9, 8.8))

evaluate(function(x){x+1}, 6)
evaluate(function(x){x[1]}, c(8, 4, 0))
evaluate( function(x){x[length(x)]}, c(8,4,0) )
?paste

paste("Programming", "is", "fun!")

telegram("your", "rigid", "code", "is", "annoying")
mad_libs("f-uck", "f-uck", "f-uck")

"I" %p% "love" %p% "R!"
2


# Next is 10, lapply and sapply

library(swirl)
swirl()
tim
1
10

head(flags)
dim(flags)
viewinfo()
class(flags)
cls_list <- lapply(flags, class)
cls_list
class(cls_list)
as.character(cls_list)
cls_vect <- sapply(flags, class)
class(cls_vect)
sum(flags$orange)
flag_colors <- flags[, 11:17]
head(flag_colors)
lapply(flag_colors, sum)
sapply(flag_colors, sum)
sapply(flag_colors, mean)
flag_shapes <- flags[, 19:23]
lapply(flag_shapes, range)
shape_mat <- sapply(flag_shapes, range)
shape_mat
class(shape_mat)
unique(c(3,4,5,5,5,6,6))
unique_vals <- lapply(flags, unique)
unique
unique_vals
lapply(unique_vals, length)
sapply(unique_vals, length)
sapply(flags, length)
sapply(flags, unique)
lapply(unique_vals, function(elem) elem[2])
1
1
# next is 11: vapply and tapply

library(swirl)
swirl()
Tim
1
11
sapply(flags, unique)
vapply(flags, unique, numeric(1))
ok()
sapply(flags,class)
vapply(flags, class, character(1))
?tapply
table(flags$landmass)
table(flags$animate)
tapply(flags$animate, flags$landmass, mean)
tapply(flags$population, flags$red, summary)
3
tapply(flags$population, flags$landmass, summary)
3
1
1

# next 12 - looking at Data

library(swirl)
swirl()
tim
1
12

ls()
class(plants) # see's what the data is
dim(plants) # finds dimensions
nrow(plants) # finds number of rows
ncol(plants) # finds number of columns
object.size(plants) # size of the data set in memory used
names(plants) # returns vector of column names
head(plants) # looks at first six columns (with column names)
head(plants, 10) # looks at first 10 rows
tail(plants, 15)
summary(plants) # great look into the data
table(plants$Active_Growth_Period) # deeper summary look at single column
str(plants) # good general preview of the data
1
1

# Next is 13: Simulation

library(swirl)
swirl()
Tim
1
13
?sample
sample(2:12, 1, replace=TRUE)
sample(1:20, 10)
LETTERS
sample(LETTERS)
flips <- sample(c(0,1), 100, replace=TRUE, prob = c(0.3, 0.7))
flips
sum(flips)
?rbinom
rbinom(1, size = 100, prob = 0.7)
flips2 <- rbinom(100, 1, prob = 0.7)
flips2
sum(flips2)
?rnorm
rnorm(10)
rnorm(10, mean = 100, sd = 25)
?rpois
rpois(5, 10)
my_pois <- replicate(100, rpois(5, 10))
my_pois
cm <- colMeans(my_pois)
hist(cm)
1
1
# Next 14: Dates and Times

library(swirl) # This loads in the Swirl course
swirl() # This is how to activate Swirl
Tim
0

x = plants$Scientific_Name[1]
x
print(x)
library(swirl)
swirl()
Tim
1
14
d1 <- Sys.Date()
class(d1)
unclass(d1)
d1
d2 <- as.Date("1969-01-01")
unclass(d2)
t1 <- Sys.time()
t1
class(t1)
unclass(t1)
t2 <- as.POSIXlt(Sys.time())
class(t2)
t2
unclass(t2)
str(unclass(t2))
t2$min
weekdays(d1)
months(t1)
quarters(t2)
t3 <- "October 17, 1986 08:24"
t4 <- strptime(t3, "%B %d, %Y %H:%M")
t4
class(t4)
Sys.time() > t1
Sys.time() - t1
difftime(Sys.time(), t1, units = "days")
1
0

# Final beginning R tutorial - 15, data vis
library(swirl)
swirl()
tim
1
15
data(cars)
?cars
head(cars)
plot(cars)
?plot 
?par # additional paramenters for plot
plot(x = cars$speed, y = cars$dist, xlab = "Speed", ylab = "Stopping Distance")
plot(cars, main = "My Plot")
plot(cars, sub = "My Plot Subtitle")
plot(cars, col = 2)
plot(cars, xlim = c(10,15))
?points
plot(cars, pch = 2)
data(mtcars)
play()
summary(mtcars)
dim(mtcars)
nxt()
?boxplot
boxplot(formula = mpg ~ cyl, data = mtcars)
hist(mtcars$mpg)
2
2