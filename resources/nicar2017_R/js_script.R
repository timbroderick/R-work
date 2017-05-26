# http://paldhous.github.io/NICAR/2017/r-to-javascript.html
# gallery.htmlwidgets.org


# load required packages
library(readr)
library(dplyr)
library(htmlwidgets)
library(highcharter)
library(RColorBrewer)
library(leaflet)
library(rgdal)
library(dygraphs)
library(quantmod)
library(DT)

# load data
nations <- read_csv("js_R/nations.csv") 

# process data
gdp_regions <- nations %>%
  mutate(gdp = gdp_percap * population,
         gdp_tn = gdp/1000000000000) %>%
  group_by(region, year) %>%
  summarize(total_gdp_tn = sum(gdp_tn, na.rm = TRUE))

# basic symbol-and-line chart, default settings
highchart() %>%
  hc_add_series_df(data = gdp_regions,
                   type = "line",
                   x = year,
                   y = total_gdp_tn, 
                   group = region)

# Customize the chart
# define color palette
cols <- brewer.pal(7, "Set1")

# And save it as an R object
gdp_regions_chart <- highchart() %>%
  hc_add_series_df(data = gdp_regions,
                   type = "line",
                   x = year,
                   y = total_gdp_tn, 
                   group = region) %>%
  hc_colors(cols) %>%
  hc_xAxis(title = list(text="Year")) %>%
  hc_yAxis(title = list(text="GDP ($ trillion)")) %>%
  hc_plotOptions(series = list(marker = list(symbol = "circle")))


# Save as a web page
saveWidget(gdp_regions_chart, "gdp_regions.html", selfcontained = FALSE, libdir = "src", background = "white")

#----------
# Leaflet maps

# make leaflet map centered on Jacksonville
leaflet() %>%
  setView(lng = -81.65, lat = 30.3, zoom = 11) %>%
  addTiles()

# make leaflet map centered on Jacksonville with Carto tiles
leaflet() %>%
  setView(lng = -81.65, lat = 30.3, zoom = 11) %>%
  addProviderTiles("CartoDB.Positron")

# Lets make an earthquake risk map
# First load in the data
# load seismic risk shapefile
seismic_risk <- readOGR("js_R/seismic_risk_clip", "seismic_risk_clip")

# load quakes data from USGS earthquakes API
quakes <- read_csv("http://earthquake.usgs.gov/fdsnws/event/1/query?starttime=1965-01-01T00:00:00&minmagnitude=6&format=csv&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&orderby=magnitude")

# view summary of seismic_risk data
summary(seismic_risk)

# set breaks for custom bins
breaks <- c(0,19,39,59,79,200)

# set palette
binpal <- colorBin("Reds", seismic_risk$ACC_VAL, breaks)

# make choropleth map of seismic risk
leaflet(seismic_risk) %>%
  setView(lng = -98.5795, lat = 39.828175, zoom = 4) %>%
  addProviderTiles("CartoDB.Positron") %>% 
  addPolygons(
    stroke = FALSE,
    fillOpacity = 0.7,
    smoothFactor = 0.1,
    color = ~binpal(ACC_VAL)
  )
#-------
#Dygraphs

# retrieve data for each company
google <- getSymbols("GOOG", src = "yahoo", auto.assign = FALSE)
facebook <- getSymbols("FB", src = "yahoo", auto.assign = FALSE)
amazon <- getSymbols("AMZN", src = "yahoo", auto.assign = FALSE)

# combine adjusted prices into a single xts object
companies <- cbind(google$GOOG.Adjusted, facebook$FB.Adjusted, amazon$AMZN.Adjusted)

# rename the variables, so that they displace nicely in the legend
names(companies) <- c("Google","Facebook","Amazon")

# draw a stock chart
dygraph(companies)

# customize the chart
dygraph(companies, ylab = "Adjusted close") %>%
  dyOptions(colors = brewer.pal(3, "Set1")) %>%
  dyRangeSelector() %>%
  dyAxis("x", drawGrid = FALSE)

# filter data for 2014 only
longevity <- nations %>%
  filter(year == 2014 & !is.na(life_expect)) %>%
  select(country, life_expect, income, region) %>%
  arrange(desc(life_expectancy))

# rename the variables for display in the table
names(longevity) <- c("Country","Income group","Region","Life expectancy")

# Make a table
datatable(longevity)

# Customize it as a datatable

datatable(longevity,  
          rownames = FALSE) %>% 
  formatStyle("Life expectancy",
              color = "red",
              fontWeight = "bold")