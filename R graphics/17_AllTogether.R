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

summary(dfLook)

# Putting data you want to examine into its own df
# makes it far easier to manage. Now using summary we
# can see, for instance, that suspects get hurt more often than
# than officers, but offers have experience major
# injuries slightly more often.



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

qplot(force,Total_officer,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="officer injuried") + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(years))

fit_officer <- lm(force ~ Total_officer, data = dfLook)
summary(fit_officer)

officer <- ggplot(dfLook) +
  aes(x=force, 
      y=Total_officer
  ) + 
  geom_point(stat="identity", 
             size = 3,
             shape=21,
             color="black",
             aes(
               fill=factor(years) )
  ) +
  geom_smooth(method=lm) +
  theme_fivethirtyeight()

# add all the titles.
officer <- officer + 
  labs(
    title="Use of force and officer injuries", # your headline
    subtitle="Subhead here",
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

# -----
# Looking at force vs. Suspect data

qplot(force,Total_suspect,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="Suspect injuried") + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(Suspect_major))

qplot(force,Total_suspect,
      data=dfLook, 
      xlab="UOF incidents", 
      ylab="Suspect injuried") + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(years))

fit_suspect <- lm(force ~ Total_suspect, data = dfLook)
summary(fit_suspect)

suspect <- ggplot(dfLook) +
  aes(x=force, 
      y=Total_suspect
  ) + 
  geom_point(stat="identity", 
             size = 3,
             shape=21,
             color="black",
             aes(
               fill=factor(years) )
  ) +
  geom_smooth(method=lm) +
  theme_fivethirtyeight()

# add all the titles.
suspect <- suspect + 
  labs(
    title="Use of force and suspect injuries", # your headline
    subtitle="Subhead here",
    x="USE OF FORCE INCIDENTS",
    y="INJURIES TO SUSPECTS",
    caption="\nSource: Elgin police") +
  scale_y_continuous(breaks=c(seq(0,18,2)) )

suspect <- suspect + 
  theme(legend.position="top", 
        legend.direction="horizontal",
        legend.title = element_blank())

suspect <- suspect + theme(
  plot.background = element_rect(fill = "white"),
  legend.background = element_rect(fill = "white"),
  plot.title = element_text(size = 32),
  plot.subtitle = element_text(size = 20),
  legend.text=element_text(size=16),
  axis.title=element_text(size=16, face="bold"),
  axis.text=element_text(size=14),
  plot.caption=element_text(size=14, hjust=0)
)
suspect
