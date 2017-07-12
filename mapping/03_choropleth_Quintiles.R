# check libraries
library(readr)
library(rgdal)
library(dplyr)
library(RColorBrewer) # for my color ramp
library(viridis)
library(scales)
library(ggplot2)
library(ggmap)
library(ggthemes)

ill_f <- read.csv("ill_f.csv", stringsAsFactors = FALSE)
head(ill_f)
summary(ill_f)
names(ill_f)

summary(ill_f$chg_total)
quantile(ill_f$chg_total, probs = seq(0, 1, .2))

# --------------
# define quantiles for data
no_classes <- 6
labels <- c()

quantiles <- quantile(ill_f$chg_total, 
                      probs = seq(0, 1, length.out = no_classes + 1))

# here I define custom labels (the default ones would be ugly)
labels <- c()
for(idx in 1:length(quantiles)){
  labels <- c(labels, paste0(round(quantiles[idx], 2), 
                             " to ", 
                             round(quantiles[idx + 1], 2)))
}
# I need to remove the last label 
# because that would be something like "66.62 - NA"
labels <- labels[1:length(labels)-1]

# here I actually create a new 
# variable on the dataset with the quantiles
ill_f$chg_total_quantiles <- cut(ill_f$chg_total, 
                                     breaks = quantiles, 
                                     labels = labels, 
                                     include.lowest = T)


# ------------
# define theme as a function

theme_map <- function(...) {
  theme_fivethirtyeight() +
    theme(
      plot.background = element_rect(fill = "white"),
      plot.title = element_text(size = 24),
      plot.subtitle = element_text(size = 16),
      plot.caption=element_text(size=12, hjust=0),
      legend.position="right", 
      legend.direction="vertical",
      legend.background = element_rect(fill = "white"),
      legend.title=element_text(size=12),
      legend.text=element_text(size=10),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      panel.grid.major = element_blank(),
      panel.background = element_blank(),
      ...
    )
}

# --------------

# map by quintile using ggplot2
map <- ggplot(ill_f, 
              aes(long, lat, group = group, fill = chg_total_quantiles)
              ) +
  geom_polygon( color = "white", size = 0.15) + coord_map() + theme_map()

map <- map + labs(
  title="Experimental mapping", # your headline
  subtitle="Playing with choropleth maps\n using R and census data",
  caption="\nSource: Census.gov",
  fill = "legend")

# using viridis color scale
map <- map + theme(legend.position = "right") +
  scale_fill_viridis(option = "D",# A, B, C or D
                     direction=1,
                     discrete = T,
                     #breaks = pretty_breaks(n=7),
                     name = "Legend",
                     guide = guide_legend(
                       keyheight = unit(5, units = "mm"),
                       title.position = 'top',
                       reverse = T
                       )
                     )
# next work with manual scale
# or play with putting legend below
map

dev.off()
?scale_color_viridis
?scale_fill_gradient2
?scale_fill_distiller
