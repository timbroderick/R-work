#getwd()
setwd("/Users/jeff/Desktop/R stats/projects/discipline")
getwd()

#install.packages("svglite")
#turns on ggplot2 and svglite
library(ggplot2)
library(svglite)

disc = read.csv("2015Discipline.csv", header = T, strip.white = T, sep=",")
#View(disc)
dem = read.csv("DistsDemographics.csv", header = T, strip.white = T, sep=",")
#str(disc)
colnames(disc)[1] = "distID"
enroll = read.csv("distEnroll.csv", header = T, strip.white = T, sep=",")

# join demographics and enrollment numbers for districts
dfdem = merge( dem,
            enroll,
            by = "distID",
            all.x = TRUE)

# Join the demographics with discipline numbers
df = merge( dfdem,
           disc,
           by = "distID",
           all.x = TRUE)

# drops an extra column
df$District.y = NULL # drops a column from a dataframe
#View(df)

# Creates a column to show cases as percent of district enrollment
df["total_perc"] = NA
df$total_perc = round ( ( (df$total / df$distEnroll) * 100 ), digits = 1)
#View(df)

#write.csv(df, file = "df.csv", row.names=FALSE, na="")

# get summary stats of final dataframe
summary(df)

View(df)

ggplot(data=df, aes(df$Out_of_school)) + geom_histogram()


# Here's a scatter with regression/confidence, 
# using a color range (top.colors) with three colors
# also uses \n to break the title into multiple lines
ggplot(df, aes(x=df$IS_perc, y=df$OOS_perc)) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "red", low = topo.colors(3)) + 
  geom_smooth(method=lm ) + 
  ggtitle("In school vs. \nOut of school") +
  labs(x="In school",y="Out of school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=18, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=16)) 
ggsave(filename="inVout.svg", plot = last_plot(), device = "svg", width=6, height=4)
ggsave(filename="inVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)

# perc In school vs low income
ggplot( df, aes( x=df$lowInc_district, y=df$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("Low income vs. In school") +
  labs(x="% Low income",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="lowVin.svg", plot = last_plot(), device = "svg", width=6, height=4)
ggsave(filename="lowVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)

#colors() #get color names

# perc out school vs low income
ggplot( df, aes( x=df$lowInc_district, y=df$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("Low income vs. Out of school") +
  labs(x="% Low income",y="% Out school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="lowVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc in school vs white
ggplot( df, aes( x=df$white_district, y=df$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("White vs. In school") +
  labs(x="% white",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="whiteVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc out school vs white
ggplot( df, aes( x=df$white_district, y=df$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("White vs. Out of school") +
  labs(x="% white",y="% Out school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="whiteVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc in school vs black
ggplot( df, aes( x=df$black_district, y=df$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("Black vs. In school") +
  labs(x="% black",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="blackVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc out school vs black
ggplot( df, aes( x=df$black_district, y=df$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("Black vs. Out of school") +
  labs(x="% Black",y="% Out school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="blackVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc in school vs hispanic
ggplot( df, aes( x=df$hispanic_district, y=df$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("Hispanic vs. In school") +
  labs(x="% hispanic",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="hispVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc out school vs hispanic
ggplot( df, aes( x=df$hispanic_district, y=df$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("Hispanic vs. Out of school") +
  labs(x="% Hispanic",y="% Out school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="hispVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


dhdists = read.csv("DHdists.csv", colClasses=c(rep("factor",2)))
View(dhdists)

dhdf = merge( dhdists,
            df,
            by = "distID",
            all.x = TRUE)

write.csv(dhdf, file = "dhdf.csv", row.names=FALSE, na="")

View(dhdf)

# Here's a scatter with regression/confidence
ggplot(dhdf, aes(x=dhdf$IS_perc, y=dhdf$OOS_perc)) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH In school vs. Out of school") +
  labs(x="% In school",y="% Out school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHinVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc In school vs low income
ggplot( dhdf, aes( x=dhdf$lowInc_district, y=dhdf$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH low income vs. In school") +
  labs(x="% low income",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHlowVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc out school vs low income
ggplot( dhdf, aes( x=dhdf$lowInc_district, y=dhdf$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH low income vs. Out of school") +
  labs(x="% low income",y="% Out school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHlowVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc in school vs white
ggplot( dhdf, aes( x=dhdf$white_district, y=dhdf$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH white vs. In school") +
  labs(x="% white",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHwhiteVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc out school vs white
ggplot( dhdf, aes( x=dhdf$white_district, y=dhdf$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH white vs. Out of school") +
  labs(x="% white",y="% Out school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHwhiteVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc in school vs black
ggplot( dhdf, aes( x=dhdf$black_district, y=dhdf$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH black vs. In school") +
  labs(x="% black",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHblackVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)


# perc out school vs black
ggplot( dhdf, aes( x=dhdf$black_district, y=dhdf$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH black vs. Out of school") +
  labs(x="% black",y="% Out of school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHblackVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)

# perc in school vs hispanic
ggplot( dhdf, aes( x=dhdf$hispanic_district, y=dhdf$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH hispanic vs. In school") +
  labs(x="% hispanic",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHhispVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)

# perc out school vs hispanic
ggplot( dhdf, aes( x=dhdf$hispanic_district, y=dhdf$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH hispanic vs. Out of school") +
  labs(x="% hispanic",y="% Out of school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHhispVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)

# Creates a column to add up black, hispanic and multi
dhdf["test_district"] = NA
dhdf$test_district =  dhdf$hispanic_district + dhdf$black_district + dhdf$multi_district
#View(dhdf)

# perc in school vs test sum
ggplot( dhdf, aes( x=dhdf$test_district, y=dhdf$IS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH non white/asian vs. In school") +
  labs(x="% non white/asian",y="% In school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHnonVin.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)

# perc out school vs test sum
ggplot( dhdf, aes( x=dhdf$test_district, y=dhdf$OOS_perc ) ) + 
  geom_point( aes(size=total_perc, colour = total_perc ) ) + 
  scale_colour_gradient(high = "springgreen4", low = "steelblue1") + 
  geom_smooth( method=lm, color="coral2" ) + 
  ggtitle("DH non white/asian vs. Out of school") +
  labs(x="% non white/asian",y="% Out of school") + 
  theme(plot.title = element_text(family = "Arial", color="#666666", face="bold", size=16, hjust=0)) + 
  theme(axis.title = element_text(family = "Arial", color="#666666", size=12)) 
ggsave(filename="DHnonVout.png", plot = last_plot(), device = "png", width=5, height=3.5, dpi = 150)
