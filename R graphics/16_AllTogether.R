# Let's start by taking a look at the data 

library(readr)
df <- read_csv("ElginUOF.csv")
summary(df)


# What we're looking at is three years of data, by quarter,
# showing how many times officers had to use physical force
# to restrain suspects, how many times they used a taser or gun
# and how many times an officer or suspect was injured

# This isn't a big dataset - there are very few rows and columns
# But that means it's also easy to understand what we're seeing
# When you start working with data that has 100s of rows and columns
# these same techniques are going to be vital to understanding 
# what you have

# Right off the bat, I can see I need to create a column that
# only has years. I don't know if I'm going to use it or not, 
# but I want it.

# first I sort the data by the Year_Quarter
df[order(df$Year_Quarter),]
df

# let's create a vector of only the years and load it into a matrix
elgYears <- c(2014,2014,2014,2014,2015,2015,2015,2015,2016,2016,2016,2016)
years <- matrix(elgYears,12,1)
years

# Now let's bind the years matrix with our df so we have a column of just years
df <- cbind(years,df)

# look at df and you can see that we've got a column of years now

#--------
# There are some interesting columns in there, but I want to answer
# a question: As use of physical force increased, do injuries for officers
# and suspects also increase?

# In order to work with this, I'm going to need to create a new 
# dataset and create at least one new column

# Let's create the new column. For Response to resistance, we have
# show of force only, which is basically a warning
# use of force only, which is an officer using physical technique
# like a hold, in response to resistance
# and then transition, which includes both showing and using
# But we don't have total instances where force was used.
# to do that, we need to add up transition and use of force
# and put that into a new column, we'll call it force

df$force <- df$UOF_only + df$Total_transitions
# Check DF and we can see it's at the end
# you can do that by clicking on the dataframe in
# Environment tab

# now let's create our dataset
names(df)
dfLook <- subset(df, select = c("years","Year_Quarter","force","Total_officer","Total_suspect"))
dfLook

# cool, but I've thought of another thing. Total injuries
# include major and minor injuries. Let's add those to our new df

dfLook$Officer_major <- df$Officer_mayor
dfLook$Suspect_major <- df$Suspect_major

# Now we have a smaller chunk of data to work with. let's save it
write_csv(dfLook,"dfLook.csv")

# Putting data you want to examine into its own df
# makes it far easier to manage. Now using summary we
# can see, for instance, that suspects get hurt more often than
# than officers, but offers have experience major
# injuries slightly more often.

summary(dfLook)

# let's use ggplot2 to do some visualizations
library(ggplot2)
library(ggthemes)


# -----
# Looking at force vs. Officer data

qplot(force,Total_officer,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="officer injuried") + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(Officer_major))
# using qplot, we're looking to see if there's 
# a relationship between force incidents and
# number of times officers are injured
# But in this case, we've divided the data by
# whether an officer had a major injury. In our data
# either only one person was injured in a quarter or
# no officers were. So the labels of the two charts are
# 0 for none and 1 for one injury
# Take a moment to see if you get this. If we had a quarter
# where there were two injuries, we'd have a third chart with
# the dot for that quarter in it. 
# but as we can see here, major injuries occured with
# relatively low number os of force incidents.
# So more force incidents did not lead to more major injuries


qplot(force,Total_officer,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="officer injuried") + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(years))
# here we use years as the factor to split the data
# into three charts. In this case, we can see
# that as time went on there were more incidents but
# no obvious pattern of increase

# the dark area associated with the trend line is 
# the 95% confidence interval. That's a prediction that
# if more data was added, 95% of it would likely fall
# within that area. As you can see, the area is pretty
# wide so there's not a lot of use in that prediction

# let's do one last exploratory chart. Let's use 
# both major injuries and year as factors

qplot(force,Total_officer,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="officer injuried") + 
  stat_smooth(method="lm") +
  facet_grid(factor(Officer_major) ~ factor(years))

# the more factors you add, the more complicated the chart
# In this case we divided the data by years
# and then for each year it was divided by major/minor injuries
# Be careful with this - it can get very hard to understand
# very quickly. But it can also provide some good insights.
# In this case, we can see the number of major injuries
# decreased from the first year and stayed low.
# Imagine if this were a dataset with thousands of numbers
# and you can see how valuable this function can be

# So let's look create the plot without any factors

# First let's take a closer look at the correlation
fit_officer <- lm(force ~ Total_officer, data = dfLook)
summary(fit_officer)

# Lots to uppack here. Honestly, I am not qualified to
# explain in detail these more advanced statistic measures. 
# What follows is a very over-simplified explanation. 
# Generally, you want ...
# A) your Adjusted R-square to be as close to 1.00 as possible
#    here it's -0.04986. Minus is fine - negative correlation
#    But, only about 4.9 percentof the observations can be explained by
#    the relationship between the two data sets.
#    So not much of a relationship
# B) the p-value to be less that 0.05. 

# HOWEVER: Don't expect too much out of these stats - we're using a very 
# small dataset so it's not going to be very informative and may even
# cause confusing results. Look at the portion labeled Coefficients:

# C) Std. Error and t value. You want the t values to be as large 
#    as possible versus the std errors. Neither are.
#    This is kind of like margin of error. If, for instance, a poll
#    says two candidates are at 51% vs. 49% and the margin of error is
#    five percentage points, that poll could be way off
# D) the Pr(>|t|) or p-value uses those T values and Error to compute the P-value
#    The top one is well under 0.05 (0.0081) which is good. It has ** which 
#    denotes ( under signif.codes) that it's close to zero (***) in whether
#    the result is random versus signifcant
#    But the bottom one is 0.5052 with is really bad!
# ------
# Statistics is a science. Our purpose in graphing these
# values out is to see how the data relates to the
# regression line and maybe spot outliers. We will seldom use 
# T values or R2 in our stories.
# But there's nothing wrong in knowing about these things. And in fact
# understanding when it's telling you that something's wrong can
# be very useful.
# Here's a link to a resource explaining what you see with the summary
# https://feliperego.github.io/blog/2015/10/23/Interpreting-Model-Output-In-R
# If you want to learn more about statistics, let me know. There's a 
# good textbook I can recommend.

# Now let's draw the plot as we would if we
# were going to use it in print or online
# At the very least, it'll be something that can be saved
# and emailed if you were discussing story angles with others

officer <- ggplot(dfLook) +
  aes(x=force, 
      y=Total_officer
  ) + 
  geom_point(stat="identity", 
             size = 3,
             shape=21,
             color="black",
             aes(
               fill=factor(years) ) # different colors for years
  ) +
  geom_smooth(method=lm) +
  theme_fivethirtyeight()

# add all the titles.
officer <- officer + 
  labs(
    title="Use of force and officer injuries", # your headline
    subtitle="There's not much connection between \nuse of physical force and officer injuries",
    x="USE OF FORCE INCIDENTS",
    y="INJURIES TO OFFICERS",
    caption="\nSource: Elgin police") +
  scale_y_continuous(breaks=c(seq(0,10,2)) )

officer <- officer + 
  theme(legend.position="top", 
        legend.direction="horizontal",
        legend.title = element_blank())

officer <- officer + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
)
officer

# as we can see, there's a very slight correlation
# between the number of force incidents and injuries to
# officers. But the line only goes up very slightly - it's
# almost flat. And the 95% confidence rate is very wide
# So we can see there's not a significant correlation

# However, that doesn't mean there's not a story. 
# Because we labeled the years, we can see that 
# as they've increased the number of times they use
# physical response to resistance, that increase didn't
# result in a measureable increase in injuries - major or minor
# And that's a positive outcome.


# -----
# Now, in the space below, try looking at 
# use of force and injuries to suspects