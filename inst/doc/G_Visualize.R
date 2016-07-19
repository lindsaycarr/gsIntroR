## ----setup, echo=FALSE---------------------------------------------------
title="G. Visualize - base"
gsIntroR::navigation_array(title)

## ----pch_col_examp-------------------------------------------------------
#Load the data package!
library(smwrData)

#Use the dataset MenomineeMajorIons from smwrData
data("MenomineeMajorIons")

#plot Magnesium vs Calcium (winter and summer different colors)
#Create two data frames using dplyr (winter & summer)
library(dplyr)
MenomineeMajorIons_winter <- filter(MenomineeMajorIons, season == "winter")
MenomineeMajorIons_winter_MgCa <- select(MenomineeMajorIons_winter, Magnesium, Calcium)
MenomineeMajorIons_summer <-filter(MenomineeMajorIons, season == "summer") 
MenomineeMajorIons_summer_MgCa <- select(MenomineeMajorIons_summer, Magnesium, Calcium)

#Now, plot winter and summer points in different colors
plot(MenomineeMajorIons_summer_MgCa$Calcium, MenomineeMajorIons_summer_MgCa$Magnesium, pch=16, col='#FF5034')
points(MenomineeMajorIons_winter_MgCa$Calcium, MenomineeMajorIons_winter_MgCa$Magnesium, pch=16, col='skyblue')

## ----par_example---------------------------------------------------------
par(las=2, tck=0.01, bg="darkseagreen")
plot(MenomineeMajorIons_summer_MgCa$Calcium, MenomineeMajorIons_summer_MgCa$Magnesium, pch=6)

## ----legend_example------------------------------------------------------
#use the same plot and add a legend to illustrate color and point type
plot(MenomineeMajorIons_summer_MgCa$Calcium, MenomineeMajorIons_summer_MgCa$Magnesium, pch=16, col='#FF5034')
points(MenomineeMajorIons_winter_MgCa$Calcium, MenomineeMajorIons_winter_MgCa$Magnesium, pch=16, col='skyblue')

#add a legend
legend(x="topright", legend=c("Summer", "Winter"),
       pch=16, col=c('#FF5034', 'skyblue'), title="Legend")

## ----add_features_example------------------------------------------------
#plot formulas using curve()
curve(x^2, from=0, to=10)
curve(sin(x), from=-pi, to=pi)

#plot rectangles or polygons
plot(1:15, c(1:7, 9.5, 9:15), type='l')
rect(xleft=6, xright=10, ybottom=5, ytop=11, density=5, col="orange")
polygon(x=c(2,3,4), y=c(2,6,2), col="lightgreen", border=NA)

#use symbols to plot circles (and more) based on data
#plot of Uranium concentration as a function of TDS w/ circle radii as high or low bicarbonate concentration
data("UraniumTDS")
x <- UraniumTDS$TDS
y <- UraniumTDS$Uranium
radii <- UraniumTDS$HCO3
symbols(x, y, circles = radii)

## ----warning = FALSE, message = FALSE------------------------------------
library(dataRetrieval)
# Gather NWIS data:
P_site1 <- readNWISqw("01656960", parameterCd = "00665")
P_site2 <- readNWISqw("01656725", parameterCd = "00665")

## ----axis_example--------------------------------------------------------
#plot Uranium vs total dissolved solids from the smwrData::UraniumTDS dataset
plot(UraniumTDS$TDS, UraniumTDS$Uranium, pch=20)
#add a second y-axis
axis(side=4)

#now log the x axis
plot(UraniumTDS$TDS, UraniumTDS$Uranium,  pch=20, log='x')
#format the second y-axis to have tick marks at every concentration (not just every 5) & no labels
axis(side=4, at=1:15, labels=FALSE)
#add a second x-axis
axis(side=3) #this axis is also logged

## ----multiple_plots_example----------------------------------------------
#use the smwrData dataset, "MenomineeMajorIons"

layout_matrix <- matrix(c(1:4), nrow=2, ncol=2, byrow=TRUE)
layout(layout_matrix)

#four boxplots:
plot1 <- plot(MenomineeMajorIons$season, MenomineeMajorIons$Magnesium, ylab="Concentration", main="Magnesium")
plot2 <- plot(MenomineeMajorIons$season, MenomineeMajorIons$Calcium, ylab="Concentration", main="Calcium")
plot3 <- plot(MenomineeMajorIons$season, MenomineeMajorIons$Chloride, ylab="Concentration", main="Chloride")
plot4 <- plot(MenomineeMajorIons$season, MenomineeMajorIons$Sulfate, ylab="Concentration", main="Sulfate")

## ----save_eg, eval=FALSE-------------------------------------------------
#  #Using the MiscGW dataset from smwrData
#  data("MiscGW")
#  ions_to_plot <- MenomineeMajorIons %>% select(Magnesium, Potassium, Chloride, Sulfate)
#  
#  png("gw_ion_pairs.png", width=5, height=6, res=300, units="in") # see ?png
#  plot(ions_to_plot)
#  dev.off()

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

