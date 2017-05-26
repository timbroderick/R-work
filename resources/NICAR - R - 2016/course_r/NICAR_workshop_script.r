

#####################################################################################################
#
#                                       ____________________________
#                                      !\_________________________/!\
#                                      !!                         !! \
#                                      !!C:\> GETTING STARTED     !!  \
#                                      !!         WITH R          !!  !
#                                      !!           ie            !!  !
#                                      !!     HOW TO OVERCOME     !!  !
#                                      !!        YOUR FEAR        !!  !
#                                      !!            &            !!  !
#                                      !!     LEARN TO LOVE R     !!  /
#                                      !!_________________________!! /
#                                      !/_________________________\!/
#                                       __\_________________/__/!_  )
#                                       !_______________________!/   )
#                                       |________________________|  (__
#                                       /oooo  oooo  oooo  oooo /!   _  )_
#                                     /ooooooooooooooooooooooo/ /  (_)_(_)
#                                    /ooooooooooooooooooooooo/ /    (o o)
#                                   /o=_____________________/_/    ==\o/==



############# SECTION 1. WELCOME TO R STUDIO #############

##### Understanding What You See #####

#The easiest way to get started in R studio is to understand the four pane set up you see in front of you. 

#Upper left: The Source, where you will find the script you are working on (or reading) and your data
#tables (known as data frames).

#Upper right: 1) Environment, which is your workspace showing all the data you have loaded up, and 
#2) History, which shows what commands you have run. Very important to note that you can and should 
#save your environment and your history from time to time in case R gets overwhelmed and decides 
#to shut down. Or at least save a script so you can recreate your environment.

#Lower left: Console, which is your active command line.

#Lower right: 1) Files (which files are in your working directory), 2) Plots (any graphics you make), 
# 3) Packages (your installed and activated packages), 4) Viewer (to look at web content)
# and 5) Help (your best friend). 

##### How to get help (more resources at the end) ######

#There are two functions you can use to get help (the responses will show up in lower right). 
#We are using the function mean in order to show how (to run commands from script select command + return):

?mean
# or
help(mean)

### How to run code (two ways):

#Select the text and then hit the RUN button.
x = c(1,2,3,4,5)

#Put your cursor on the row and then hit COMMAND + RETURN
mean(x)

############# SECTION 2. UNDERSTANDING THE BASIC ELEMENTS OF R #############

##### Understanding the data elements #####

#R has multiple named data structures and elements:

#### Object: most basic element, includes variables, data, functions you make, results, etc, 
# are kept in the active memory of your computer as objects -- you can find them in 
# your workspace ("Environment")

# What does an object look like?
# In R, everything is an object. So whatever you assign to a vector, a data frame, a function, those
# are all objects.

# The best method to get the internal structure of an object is str():
?str
x = c(1,2,3)
y = c("a","b","c")
str(x)
str(y)

z = c("1","2","3")
str(z)


#will print out all of your objects.
objects() 
#or
ls() 

rm(z)

objects()
rm(x) #This will remove any objects in your workspace.
rm(list = ls()) #This will remove everything in your workspace.

## Assigning variables:

# HOW TO ASSIGN:

#You can use = or the fancy (and time consuming) <-/-> for assigning varibles. This means that something IS SET as something else. For example:

x = 1
x
x <- 2
x
3 -> x
x

# HOW TO EQUATE:

#Using ==, you set up a LOGICAL that essentially asks the computer "Is this true?" For example:

x = 3
x
x == 3
x == 2

### The Class: Of course, there are different types of objects in R, and each object has a class.

x = c(1,2,3)
y = c("a","b","c")
class(x)
class(y)

z = c("1","2","3")
class(z)
# There are many kinds of classes, for example:
# "character"
# "complex"
# "double"
# "expression"
# "integer"
# "list"
# "logical"
# "numeric"
# "single"
# "raw"

### Vector: simplest type of data structure, just an ordered collection of objects.
#assigning a to a set of numbers with function c():
?c

#This fucntion enables you to combine values into a vector or list:
a = c(10,20,30,40,50) 
a
#assigning b to a set of numbers with function c()
b =  c(2,3,6,8,10) 
b

#You can also do basic math with vectors:
c = 2*a + 3 - b
c

#Can also apply some simple mathmatical functions to vectors:
# maximum:
max(c) 

# minimum:
min(c) 

# length of the vector in values:
range(c)

#number of elements:
length(c) 

#sum all the elements:
sum(c) 

#product of all the elements:
prod(c) 

#gives you the average:
mean(c) 

#gives you the median
median(c) 

#sorts the data in increasing order ***more on sorting down below
sort(c) 
#--------------------------------------
  
# Generating sequences can also be an important part of working with R:
#generates a sequence between 1 and 30:
1:30 

#gives you the same thing:
a = seq(1:30) 
a

#also gives you the same thing:
seq(from=1, to=50) 

#can also tell it what the increment should be:
seq(from=1, to=50, by=2) 

#gives you a sequence based on length.:
seq(from=1, by=3, length=30) 

x = c(1,2,"a","b")
x
# You can also generate sequences with repeated objects:
# repeating elements 1-5 over and over again.
rep(a, times=4) 

# repeating elements in a row
rep(a, each=6) 

# R is also great for working with logical data (TRUE and FALSE). They are created by conditions (<.<=,>,>=,==).
d = a < 30
d

### Vectors with characters:
# You can build vectors not only with numbers but strings or characters as well using the double or single 
# matched quotes. 

a = c("this","is", "a", "character", "vector", "!")
a

?paste
b = paste(c("this","a", "vector"),c("is","character","!"), sep=" ")
b

#Vectors are "atomic" structures, meaning that they all have the same mode or type (numeric, complex,
#logical, character, etc...). The only exception is NA. 
x = c(T, F, "hello", 2)
str(x)

y = c(TRUE,F,F,T,T)
str(y)

z = c(1,2,3,4,5)
str(z)

w = c(1i,2,3,4,5)
str(w)

###Other data structures:
#Matrices or Arrays: multi-dimensional vectors.
?matrix
matrix(c(1, 2, 3, 4, 5), nrow=3, ncol=5) 
matrix(c(1, 2, 3, 4, 5), nrow=5, ncol=3) 

#Factors: this should be used for categorical data.
factor(1:20, labels = "category_")

#Lists: vector where the data need not be the same mode (not atomic)
?list
x = list(1, "two", T, 3i)
x
str(x)

#Data frames: your basic table. One row per observational unit.
?data.frame
new_df = as.data.frame(matrix(c(1, 2, 3, 4, 5), nrow=3, ncol=5))
?as.data.frame
View(new_df)

##How would you create your own data frame of data:

#Let's say that we want to make a table of left/right-handed individuals by gender:
#We have 4 left-handed men, 6 left-handed women, 5 right-handed men, and 4 right-handed women:

##The numbers fill out columns first and then the rows. 
new_df = as.data.frame(matrix(c(4, 5, 6, 4), nrow=2, ncol=2))
names(new_df)[1] = "male"
names(new_df)[2] = "female"
rownames(new_df)[1] = "left"
rownames(new_df)[2] = "right"
View(new_df)


#Functions: they are objects as well and can be built and stored (but there are many useful prefab ones)
myMeanFunction <- function(set){
  x = mean(set) - 1
  return(x)
}
g = c(1,2,3,4,5,10,50)
myMeanFunction(g)
mean(g)

##### Working with Missing Values #####

#R is very good at dealing with missing values, but you need to know how to deal with them to use this to
#your advantage.

x = c(NA,2,3,NA,5)
is.na(x)
!is.na(x)

#NAs will not generate an error in a vector and is automatically recognized as NA

###Other NA actions:
#takes out the NAs and tells you where they were
?na.omit
na.omit(x) 
#takes out the NAs and tells you where they were
na.exclude(x) 
#prints all data, even NAs
na.pass(x) 
#will not print out if data is missing.
na.fail(x) 

#How that works with data frames:
new_df = as.data.frame(matrix( c(1, 2, 3, 4, 5), nrow=3, ncol=5))
View(new_df)
new_df[1,1] = NA
new_df[3,5] = NA
new_df
na.omit(new_df)
na.exclude(new_df)
na.pass(new_df)
na.fail(new_df)


#You can also exclude NAs when you're running functions
x
#removes nas for the function
mean(x, na.rm=TRUE) 
#If you don't remove the NAs then it returns NA.
mean(x)
#summarizes, and shows how many NAs.
summary(x) 
#sorts data, putting your NAs at the end.
sort(x,na.last = TRUE) 

##### A few other math functions before we get to working with data:
y = c(-1.3,2,10.75)
y
# Absolute value:
abs(y)

# round up to the next highest integer.
ceiling(y)

# round down the lowest integer.
floor(y)

#round but specify the digits:
round(y, digits=1)

#Expand grid can create a data frame with all the given possibilities. 
?expand.grid
expand.grid(math=c(500,800), verbal=c(600, 700), gender=c("Male", "Female"))

#Selects a random sample.
?sample
sample(1:100, 1)
sample(state.name, 10)

############# SECTION 3. LOADING IN THE DATA ###############################

#Yes, you can use R as a GIANT CALCULATOR. But that would be a waste. Let's finally play with some data, 
#shall we?

#For this workshop, I've already created your project file, but next time you boot up R and you're starting
#a new project, make sure that you select File > New Project. Save it in a directory.

#Also, to create a new script (like the one you are reading), File > New > R Script.

#You should document your code with this so you can re-run things if the base data changes. 

##### SETTING THE WORKING DIRECTORY #####

#First things first, you have to set the working directory to tell your program where your main folder
#is with all your data (csv, xls, dat, scripts, project files, etc...)

setwd("~/NICAR/Course_R") #If you don't know the path, find the folder in the files pane. Then
#go to dropdown Session > Set Working Directory > To Files Pane Location. This will also show you the path.

#You can check your working directory if you think you're in the wrong place:
getwd()


##### Reading data into R from a file #####

##From a CSV (best file type to read in with R):
rm(list = ls())
education_data_raw = read.csv("NICAR_education_data/NICAR_education_data_RAW.csv", header = T, strip.white = T, sep=",")
View(education_data_raw)

##Other important arguments that you can add to it:
#1. header - is there a header? T or F
#2. sep = "," - what is separating the data; for csv, it's ","
#3. quote = "\"'" - how do quotes appear in the strings (here it is single quote)
#4. dec = "." - what does the decimal look like.
#5. row.names = c(x,x,x,etc...) - you can set row names if you like.
#6. col.names = c(x,x,x,etc...) - you can reset the column names. 
#7. stringsAsFactors = TRUE or FALSE - you can set the strings to character mode instead of factor (default is factor)
#8. na.strings = "NA" - what does NA look like.
#9. colClasses = c(x,x,x,etc) - set the type of data in each column.
#10. nrows = 100 - sets the number of rows.
#11. skip = 10 - sets how many rows you want to skip at the beginning.
#12. fill = TRUE or FALSE - if rows have different number of columns, this will fill the rest with blanks.
#13. strip.white = TRUE or FALSE - strip the white spaces from the columns


##From a tab delim. file:
delim_table = read.delim(filename, header=TRUE, sep="\t") #this is just an example.

##From an XLS:
require("xlsx")
ceos_raw_from_xlsx = read.xlsx("top_100_ceos.xlsx", 1, header=TRUE) #read first sheet from this xlsx
View(ceos_raw_from_xlsx)

##From a DAT file:
?read.table() #works with many file formats

##Read Fixed Width Formatted Files:
?read.fwf()

### For more on importing files, check out: http://cran.r-project.org/doc/manuals/r-release/R-data.html

############# SECTION 4. BASIC DATA CLEANING #############

#Once you have your data loaded in, check that it has the number of variables 
#and observations that you expect.

#And then you can start reviewing the various columns.
#this will show the first 1000 rows of a data frame:
View(education_data_raw)
head(education_data_raw,2)
head(education_data_raw,5)
tail(education_data_raw,2)

#look at the headers:
names(education_data_raw)

#number of variables:
length(education_data_raw) 

#Next, take a look at the structure of the data frame.
str(education_data_raw) 

#School name has a strange column name (with the ...) so lets change it.
names(education_data_raw)[3] = "SCHOOL_NAME"
names(education_data_raw)

#Check out only a column of the data with "$"
education_data_raw$SCHOOL_NAME

##Check out only a column of the data with the column number
education_data_raw[3]

##Check out only a column of the data with the column number
education_data_raw[,3]

##Check out only a row of the data with the row number
education_data_raw[3,]

##Check out Amridge University percent pell students.
education_data_raw[3,7]

#It appears that aside from ID, UNITID, CONTROl, PREDDEG , everything was read in as a factor. 
#We're going to have to change the column type to match the data. 

#Certain things should remain factors (anything we want to be categorical, like gender or state or industry).
#This will make it easier to analyze later. 

##First let's rename the data we're working with:

education_data_clean = education_data_raw

#Let's change a few variables to numeric or character (this will force anything that is not numeric to NA!):
education_data_clean$SCHOOL_NAME = as.character(education_data_clean$SCHOOL_NAME)
education_data_clean$UGDS = as.numeric(education_data_clean$UGDS)
education_data_clean$PCTPELL = as.numeric(education_data_clean$PCTPELL)
education_data_clean$CDR3 = as.numeric(education_data_clean$CDR3)

#Take a look at the structure:
str(education_data_clean$PCTPELL)

##Why didn't that work? Well, that's the issue with factors, it stores the observations differently than you might expect. 

##Let's try again. First, let's remake the data:
education_data_clean = education_data_raw

#Try converting again:
education_data_clean$SCHOOL_NAME = as.character(education_data_clean$SCHOOL_NAME)
education_data_clean$UGDS = as.numeric(as.character(education_data_clean$UGDS))
education_data_clean$PCTPELL = as.numeric(as.character(education_data_clean$PCTPELL))
education_data_clean$CDR3 = as.numeric(as.character(education_data_clean$CDR3))

#Take a look at the strutcure
str(education_data_clean$PCTPELL)
summary(education_data_clean$PCTPELL)

#Find and replace text:
?gsub
head(summary(education_data_clean$GRAD_DEBT_MDN),5)

##Let's take out the privacy suppression and name it something else, or make it NA:
#First convert this to character:
education_data_clean$GRAD_DEBT_MDN = as.character(education_data_clean$GRAD_DEBT_MDN)

#Then replace the privacysuppressed with unknown:
education_data_clean$GRAD_DEBT_MDN = gsub("PrivacySuppressed", "Unknown",education_data_clean$GRAD_DEBT_MDN)

#Take a look at what comes out:
summary(education_data_clean$GRAD_DEBT_MDN)
education_data_clean$GRAD_DEBT_MDN = as.numeric(education_data_clean$GRAD_DEBT_MDN)
mean(education_data_clean$GRAD_DEBT_MDN, na.rm = TRUE)

##How to convert multiple columns at the same time:
names(education_data_clean)
str(education_data_clean)
cols.num <- c(6:41)
education_data_clean[cols.num] <- sapply(education_data_clean[cols.num],as.character)
str(education_data_clean)
education_data_clean[cols.num] <- sapply(education_data_clean[cols.num],as.numeric)
warnings()
str(education_data_clean)
cols.num <- c(4:5)
education_data_clean[cols.num] <- sapply(education_data_clean[cols.num],as.character)
summary(education_data_clean$CONTROL)
str(education_data_clean)

##### Some other great functions for cleaning data #####

#Substring: Extract or replace substrings in a character vector.
?substr
d = c("All your base  are belong to us.")
d
e = substr(d, 1,10)
e

#Searching for a pattern.
?grep
grep("base", d, ignore.case = TRUE)
grepl("base", d, ignore.case = TRUE)

#Find and replace:
?sub
sub("base","cats",d)

#Find and replace (global):
?gsub
gsub("base", "dogs",d)

#String split:
strsplit(d, "  ")

#Make upper case:
toupper(d)

#Make lower case:
tolower(d)

#Adding on another column:
?cbind

#Adding on rows:
?rbind

#Merging data frames by a common column (often known as join):
?merge

#####Some other ways to sort/summarize data:
##Look at a summary of all the variables:
summary(education_data_clean)
summary(as.factor(education_data_clean$CONTROL))

## SUMMARY will give you an overall breakdown of your data. 

## For values that are characters, you will just see the number of observations.

## For numbers, you will see the minimum, the 1st quartile, the median, the mean, the 3rd quartile, and the max. 
## This is incredibly helpful for understanding the distribution. 

##### Sorting your data will help you understand it better. #####

## Sorting by one variable:
sorted_data_schools = education_data_clean[order(education_data_clean$SCHOOL_NAME),] 
head(sorted_data_schools)

sorted_data_control = education_data_clean[order(education_data_clean$CONTROL),]
head(sorted_data_control)

##The latest versions of R also have sorting in the data frame itself.


##### PLYR/DPLYR: incredibly powerful tools from the R legend, Hadley Wickham. 
install.packages("plyr")
require("plyr")
install.packages("dplyr")
require("dplyr")

#Read the documentation: https://cran.r-project.org/web/packages/dplyr/dplyr.pdf
#Even better, read the CHEAT SHEET: https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

#a) How to join with DPLYR:

#First let's create some subsets so that we can join them back together:
education_data_1 = education_data_clean[1:10,2:3]
education_data_2 = education_data_clean[1:10,c(2,7)]
education_data_1
education_data_2

#Then you can left_join, right_join, inner_join, etc...
education_data_JOINED = left_join(education_data_1,education_data_2,by="UNITID")
education_data_JOINED

?bind_rows
?bind_cols

#b) How to filter with DPLYR:

##You can filter for non-profit private schools that predominantly offer bachelors and that have a percentage of pell students less than 20 percent:
head(filter(education_data_clean, CONTROL == 2,  PCTPELL < .2, PREDDEG == 3))
head(filter(education_data_clean, CONTROL == 2 | CONTROL == 1,  PCTPELL < .2, PREDDEG == 3 ))

##You can also slice a bit of your data based on rows:
slice(education_data_clean, 1000:1003)

##You can arrange data which is like filter except it changes the order:
head(arrange(education_data_clean, UGDS))
head(arrange(education_data_clean, desc(UGDS)))

##Selecting columns:
names(education_data_clean)
head(select(education_data_clean, UNITID, SCHOOL_NAME, ADM_RATE))
head(select(education_data_clean, UNITID, SCHOOL_NAME:ADM_RATE))
head(select(education_data_clean, UNITID:COSTT4_A, -(UGDS:ADM_RATE)))

##Distinct variables:
nrow(distinct(select(education_data_clean, SCHOOL_NAME)))
nrow(education_data_clean)

##Create new columns with mutate:

#Create a debt to cost over 4 years:
head(mutate(education_data_clean,
       debt_cost_ratio = GRAD_DEBT_MDN/(4*COSTT4_A)))

#Create a debt to earnings ratio:
head(mutate(education_data_clean,
            debt_earnings_ratio = GRAD_DEBT_MDN10YR/(md_earn_wne_p10/12)))

##Let's save this one to work with later:
education_data_clean = mutate(education_data_clean,
                              debt_earnings_ratio = GRAD_DEBT_MDN10YR/(md_earn_wne_p10/12))

##Group data by category:
#First group by type of school (1 - public school, 2 - nonprofit private school, 3 - for-profit school)
by_control <- group_by(education_data_clean, CONTROL)

school_type <- summarise(by_control,
                    count = n(),
                   mean_debt = mean(GRAD_DEBT_MDN, na.rm = TRUE),
                   mean_cost = mean(na.omit(COSTT4_A)))
school_type

#First group by type of school (1 - public school, 2 - nonprofit private school, 3 - for-profit school) and then the preddeg (0 - unclassified, 1 - certificate program,
# 2 - associates degrees, 3 - bachelor's degree, 4-graduate degree):
by_control <- group_by(education_data_clean, CONTROL, PREDDEG)

school_type <- summarise(by_control,
                         count = n(),
                         mean_debt = mean(GRAD_DEBT_MDN, na.rm = TRUE),
                         mean_cost = mean(na.omit(COSTT4_A)))
school_type

## Data cleaning with R is an art, but it's not hard to get pretty decent at it. I highly suggest
## taking a look at this short guide: 
## http://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf


################# VISUALIZING YOUR DATA:

install.packages("ggplot2")
library("ggplot2")

##A great resource: http://www.noamross.net/blog/2012/10/5/ggplot-introduction.html 


### Histograms with GGPLOT:

##Looking at the frequency of pctpell:
ggplot(education_data_clean, aes(x=PCTPELL)) + geom_histogram(binwidth=.05,col=I("black"))

##Looking at the frequency of percentage of students with loans:
ggplot(education_data_clean, aes(x=PCTFLOAN)) + geom_histogram(binwidth=.05,col=I("black"))

##Looking at a histogram of completion rates:
ggplot(education_data_clean, aes(x=C150_4)) + geom_histogram(binwidth=.05,col=I("black"))

### DENSITY CHARTS (kind of like a probability curve):
##Breaking down schools by public/nonprofit private/for-profit private AND pctpell:
ggplot(education_data_clean, aes(PCTPELL, colour = CONTROL, fill = CONTROL)) +
  geom_density(alpha = 0.3) 

##Breaking down schools by what is the predominant degree:
ggplot(education_data_clean, aes(PCTPELL, colour = PREDDEG, fill = PREDDEG)) +
  geom_density(alpha = 0.3) 


#### BARPLOTS:

#Count of schools that are public/nonprofit/for-profit:
ggplot(education_data_clean, aes(x = factor(CONTROL))) + geom_bar(stat = "count")

##Average percentage of pell students by type of school:
ggplot(education_data_clean,aes(x=factor(CONTROL), y=PCTPELL)) + stat_summary(fun.y=mean, geom="bar") + ylim(0,1)

##Looking at debt broken down by type of school and degree:
plot1<-ggplot(education_data_clean,aes(x=factor(CONTROL),y=GRAD_DEBT_MDN,fill=factor(PREDDEG)), color=factor(PREDDEG)) +  
  stat_summary(fun.y=mean,position=position_dodge(),geom="bar") 
plot1

#### SCATTERPLOTS:

##Looking at cost by percent pell:
p1 <- ggplot(education_data_clean, aes(x = COSTT4_A, y = PCTPELL))
p1 + geom_point(color="blue") 

##Looking at cost by percent pell but breaking it down by the type of school:
p1+ geom_point(aes(color = CONTROL))  

##Looking at cost by percent pell but breaking it down by the type of school and the size of the school:
p1+ geom_point(aes(color = CONTROL, size = UGDS))  

##Adding a regression line:
p1 + geom_point(color="blue") +geom_smooth(method = "lm", se = TRUE) 

##Adding multiple regression lines:
p1 + geom_point(aes(color = CONTROL)) + geom_smooth(aes(color=factor(CONTROL)),method = "lm", se = TRUE) 


############# SECTION 6. REMINDERS FOR WHEN YOU GET STUCK############# 

# 1. R is case sensitive: If a package or variable has a name, the case matters!

# 2. Errors are common so get used to using help and ? as well as the online communities 
# so you can figure out what you want.

# 3. Commands can be separated by a newline or a semi-colon (‘;’)
##EX: 
x = 3+4 ; y = x*2 ; y

# 4. Comments can be made with hashtags(#) and these lines will not run in your console.

# 5. If you don't finish a command in the console, you will see a plus-sign (+) until you finish it!
##EX:
x = (1 +3) - (2*4
)

# 6. You must install packages before you use them. Once they are installed, you have to require or 
#load them.
##EX:
install.packages("ggplot2")
require("ggplot2")

# 7. To run code from the scripts, hold down command and hit return. For multiple lines, select all
#the lines, hold command and hit return.

# 8. R has some built in data sets that you can play with to get better (see package "datasets") and for a
# complete list > library(help = datasets)

# 9. When you get stuck and something is not working how you expect it to work, take a look at the types 
#of data you are trying to work with (use summary and str). These can be great diagnostic tools at 
#the beginning because not all functions work with all types of data.

# 10. SAVE ALL YOUR WORK. Obviously.

# 11. Get stuck? Refresh R! 
.rs.restartR()

############# SECTION 7. HOW TO GET HELP ############# 

# The main R site: http://cran.r-project.org/
# This has everything from guides to R updates. It also has a comprehensive list of packages and lots
# of great tips on how to use R. 

# Official R Language Definition: http://cran.r-project.org/doc/manuals/r-release/R-lang.html

# An In-Depth Introduction to R: http://cran.r-project.org/doc/contrib/usingR.pdf

# Using R for Intro Stats: http://cran.r-project.org/doc/contrib/Verzani-SimpleR.pdf

# Quick R: http://www.statmethods.net/

# R Documentation Search: http://www.rdocumentation.org/

# R-bloggers: find out awesome things people are doing with R http://www.r-bloggers.com/

# Coursera Course on R: https://www.coursera.org/course/rprog

# Princeton Guide to R: http://libguides.princeton.edu/dss/R

# UCLA Guide to R: http://www.ats.ucla.edu/stat/r/sk/books_usingr.htm

# Stack overflow: http://stackoverflow.com/

# Annie's Tipsheet: https://goo.gl/0i0j3X





##################################### GOOD LUCK AND LOVE R ############################################


