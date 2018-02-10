mov <- read.csv("Movie-Ratings.csv")
summary(mov)
str(mov)
colnames(mov) <- c("Film","Genre","CriticRating","AudienceRating","BudgetMillions","Year")
summary(mov)
str(mov)
mov$Year <- factor(mov$Year)
str(mov)

library(ggplot2)

p <- ggplot(data=mov) +
  aes(x=CriticRating, y=AudienceRating)

p + geom_point()

# can override previous values without 
# changing the value of p

p + geom_point(aes(x=BudgetMillions))

# mapping vs. setting

# you map a color to a variable
# and it shows up in a legend
p + geom_point(aes(color=Genre))

# you set a color without aes
# and no legend shows up
p + geom_point(color="dark green")

# here's mapping and setting
# you set a color and transparency without aes
# but map it by size, so the legend shows there
p + geom_point(aes(size=BudgetMillions),
               color="dark green",
               alpha=I(.5))


# histograms

s <- ggplot(data=mov) +
  aes(x=BudgetMillions)

s + geom_histogram(binwidth=10, 
                   aes(fill=Genre), 
                   color="White", size=0.25)
# density chart

s + geom_density(aes(fill=Genre),
                 position="stack",
                 color="White", size=0.25)


# statistical transformations

u <- ggplot(data=mov)
  
u + geom_point() + aes(x=CriticRating, 
                       y=AudienceRating,
                       color=Genre) +
  geom_smooth(fill=NA)

# box plots

bx <- ggplot(data=mov)

bx + geom_jitter(size=0.5) + 
  geom_boxplot(size=0.8) + 
  aes(x=Genre, y=AudienceRating,
      color=Genre, alpha=.5)

bx + geom_jitter(size=0.5) + 
  geom_boxplot(size=0.8) + 
  aes(x=Genre, y=CriticRating,
      color=Genre, alpha=.5)

# facets

ft <- ggplot(mov)

ft + geom_histogram(binwidth=10,
                    aes(x=BudgetMillions,
                        fill=Genre),
                    color="White",
                    size=0.3) +
  facet_grid(Genre~., scales="free")

#--------------
# sets x/y limits, cuts content
w <- ggplot(mov)

w + geom_point() +
  aes(x=CriticRating,
      y=AudienceRating,
      color=Genre,
      size=BudgetMillions,
      alpha=0.35) +
  facet_grid(Genre~Year) +
  geom_smooth() +
  ylim(0,100)


#------------
# zooms into chart, doesn't cut content
m <- ggplot(mov)

m + geom_histogram(binwidth = 10,
                   aes(x=BudgetMillions,
                       fill=Genre),
                   color="white",
                   size=0.3) +
  coord_cartesian(ylim=c(0,50))


w2 <- ggplot(mov)

w2 + geom_point() +
  aes(x=CriticRating,
      y=AudienceRating,
      color=Genre,
      size=BudgetMillions,
      alpha=0.35) +
  facet_grid(Genre~Year) +
  geom_smooth() +
  coord_cartesian(ylim=c(0,100) )

# themes _________________

o <- ggplot(mov) + geom_histogram(binwidth = 10,
                   aes(x=BudgetMillions,
                       fill=Genre),
                   color="white",
                   size=0.3)

o + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(color="Dark Green",
                                   size=20),
        axis.title.y = element_text(color="Red",
                                    size=20),
        axis.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1.2,1.1)) 
  
  
