# Scatterplot - life expectancy (y) v Fertility rate (x) by country
# Categorise by region

df <- read.csv("section 5/DemographicData.csv")
str(df)
summary(df)
head(df)
df$Birth.rate[df$Country.Name=="Angola"]

