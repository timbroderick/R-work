# Rstats

### What's here

* R graphics - these are guides created with R markdown that go through how to create basic plots with R, create publication-ready plots with ggplot2 and some mapping. Includes markdown files, R scripts and all the data to create the examples. 

* R coursework - Files where I'm learning how to do things with R stats.Currently going through the basic Swirl course while viewing "R programming A-Z" at Udemy. FWIW, they seem to compliment each other quite well.

* mapping - Experiments with mapping with R

* resources - misc. tutorial resources

* completed - completed and published graphics. I intend to do HTML guides for these as well - for now, they're annotated in the script.

### Installing R

To get R, go to 
https://www.r-project.org/ 

Once that's installed, get the free version of R-studio here 
https://www.rstudio.com/ 
You can run R without R-studio. But R-studio is a friendlier interface for R, and most people recommend it.

Be sure to install the versions compatible with your operating system, especially version number.

### Learning R

Swirl is a set of interactive - free - tutorials that will take you through the basics of learning R and R-studio.  http://swirlstats.com/  To install it, type: `install.packages("swirl")` in the R console. It'll download and install it for you. 

To run swirl, type: `library(swirl)` and that will activate the tutorials.

I'm also going through this Udemy class: https://www.udemy.com/r-programming/ I find it to be a nice compliment to the swirl tutorials.

If you've never done a Udemy class, the first time you go to their website and look at a specific class, it'll offer that class to you for a drastically reduced price. This r-programming class was only $10. 

### Other resources - graphics

Find annotated scripts in folder R Graphics that start with basic plotting in R and progress through to plots using ggplot2. The point with these is to produce various chart types suitable for print or online - and for online, specifically viewable on mobile devices.

I found these tutorials invaluable for developing our R scripts for graphics
http://t-redactyl.io/tag/r-graphing-tutorials.html

This is an excellent introduction to R for reporters. 
https://paldhous.github.io/NICAR/2017/r-analysis.html
This was taught at NICAR 2017, but the step-by-step worksheet is fairly easy to follow.

Want to see how 538 does their graphics? They use R, and they're putting all their code online for free. Here's a description of what they're doing:
https://cran.r-project.org/web/packages/fivethirtyeight/vignettes/fivethirtyeight.html

And here's the R scripts and datasets they examined
https://github.com/rudeboybert/fivethirtyeight/tree/master/data-raw

Here's the book on data science and R, with one of the authors being the person who created the visualization library ggplo2
http://r4ds.had.co.nz/

Here's a free book on advanced R:
http://adv-r.had.co.nz/

David Montgomery of the Pioneer Press shared this analysis of police data, from working the data to visualizing it: https://github.com/pioneerpress/code/tree/master/st-anthony-police

He's constantly doing little things to develop his skills - just like an athlete will work out every day. Here's where he has that, some of it fun:
https://github.com/dhmontgomery/personal-work


### Other resources - mapping

There's a way bigger challenge doing maps in R, especially if you don't have experience in GIS at all. My annotated scripts on this are in folder mapping. The focus on here is to create exloratory chloropleth maps with your choice of color palattes. To also have these able to be exported for print or online would be gravy.

Here's an extensive online tutorial to get started with mapping and R: https://github.com/Robinlovelace/Creating-maps-in-R/blob/master/README.md
It had some rough parts, but I worked through it and my annotations may help:  https://github.com/dailyherald/R-work/blob/master/mapping/mapping.R

This was a good compliment to the above: http://www.computerworld.com/article/3038270/data-analytics/create-maps-in-r-in-10-fairly-easy-steps.html

Another step by step here: https://reubenfb.github.io/mapping_in_r/presentation.html#/

This is just plain beautiful to look at, but it also has good information on working your data so you can do chloropleth maps with custom breaks: https://timogrossenbacher.ch/2016/12/beautiful-thematic-maps-with-ggplot2-only/#discrete-classes-with-quantile-scale

This may be a good compliment to the above: http://www.kevjohnson.org/making-maps-in-r/

More info on the scales package: https://www.rdocumentation.org/packages/scales/versions/0.4.1

Looks like the Financial Times is going to start sharing R tutorials:
https://github.com/ft-interactive/R-tutorials
The first one up is on joining data to shapefiles. FYI, shapefiles are one of the ways mapping information is stored. So, for instance, we have shapefiles for all the counties in Illinois that can be used to show average income by county or median age. 

### Other resources - advanced

I took this one on doing interactives with R at NICAR 2017. I would say it's a little advanced, but it used things we use here at the DH for our interactive maps and graphics.  
https://paldhous.github.io/NICAR/2017/r-to-javascript.html

This is a weekend project - take some time on a weekend and just go through this as an exercise: Andrew Ba Tran examines police stun gun use in Connecticut. He works the data, and examines it visually with charts and maps all generated in R. This was for a NICAR session. https://trendct.github.io/data/2016/06/stun-guns/

This is amazing: Washington Post shared all the data and R scripts they used to break this major story: "Jared Kushner and his partners used a program meant for job-starved areas to build a luxury skyscraper "
https://github.com/wpinvestigative/kushner_eb5_census

