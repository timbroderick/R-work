# This is the file for follwing chapter 3
# of R for data analysis

# load libraries
library(tidyverse)

# looking at the mpg dataframe
# inherent in ggplot2

summary(mpg)

# compare displacement to hwy mileage

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

## Exercises for 3.2.4
ggplot(data = mpg) # an empty plot
# 234 rows and 11 columns
?mpg # drv is f = front-wheel drive, r = rear wheel drive, 4 = 4wd

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))

# class and drv hold characters, not numbers

# --------------------------------------
# section 3.3

# using color to highlight different classes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, 
                           color = class))

# other options are size = class, alpha or shape

# set the color specifically

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy),
                           color = "blue")

# 3.3.1 exercises

# code has color inside aes

summary(mpg)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, 
                           color = cyl))
# continuous variables will have a graduated scale
# vs categorical variables
# Works for color, size but not shape

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = hwy, y = hwy, 
                           color = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, 
                           colour = displ < 5))
# results in coloring dots true/false based on test

#-------------------------------------
# section 3.5 - Facets

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# facets display subplots of the data
# each class (compact, midsize) gets it's own
# chart, all over two rows

# The first argument of facet_wrap() should 
# be a formula, which you create with ~

# facet_grid allows two classes

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
# compares displacement with hwy mileage
# then facts on number of cylinders v type of 
# drive (4-wheel etc)

#------------------
# sect 3.5.1 excercises

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty, nrow = 2)
# faceting on a continuous variable results in
# a chart for each value in variable (large)

