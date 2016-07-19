## ----setup, echo=FALSE---------------------------------------------------
set.seed(5)
title="E. Analyze - base"
gsIntroR::navigation_array(title)

## ----ttest_examp---------------------------------------------------------
pop1 <- rnorm(30, mean=3, sd=2)
pop2 <- rnorm(30, mean=10, sd=5)
pop_ttest <- t.test(pop1, pop2)
pop_ttest

## ----ttest_formula_examp-------------------------------------------------
#Load the data package!
library(smwrData)

#Let's choose a prefabricated dataset, MiningIron 
data("MiningIron")
bind_rows(head(MiningIron), tail(MiningIron))

#Compare iron concentration between rock types
#There are two rock types, these serve as your two different populations 
#You cannot use this to compare more than two groups 
#Try using MineType instead of Rock and see what R tells you
t.test(MiningIron$Iron ~ MiningIron$Rock)

## ----corr_examp,message=FALSE,warning=FALSE------------------------------
#Use the UraniumTDS data set from smwrData
data("UraniumTDS")

#A simple correlation
cor(UraniumTDS$TDS, UraniumTDS$Uranium)
#And a test of that correlation
cor.test(UraniumTDS$TDS, UraniumTDS$Uranium)

#A data frame as input to cor returns a correlation matrix
#Can't just do cor(UraniumTDS) because UraniumTDS has non-numeric columns:
# cor(UraniumTDS)
library(dplyr) # use dplyr to select the numeric columns of UraniumTDS
UraniumTDS_onlynumeric <- select(UraniumTDS, -HCO3)  
cor(UraniumTDS_onlynumeric)

#This is especially useful for data frames with many columns that could correlate
#Create a correlation matrix for MiscGW (all columns are numeric)
data("MiscGW")
cor(MiscGW)

## ----lm_examp------------------------------------------------------------
data("MenomineeMajorIons") #from smwrData

lm(Magnesium ~ HCO3, data=MenomineeMajorIons)
#Not much info, so save to object and use summary
lm_gwq1 <- lm(Magnesium ~ HCO3, data=MenomineeMajorIons)
summary(lm_gwq1)
#And now a multiple linear regression
lm_gwq2 <- lm(Magnesium ~ HCO3 + Calcium + Sodium, data=MenomineeMajorIons)
summary(lm_gwq2)

## ----abline_examp_lm-----------------------------------------------------
plot(MenomineeMajorIons$HCO3, MenomineeMajorIons$Magnesium)
#abline accepts a linear model object as input
#linear model is done with lm, and uses a formula as input
abline(lm(Magnesium ~ HCO3, data=MenomineeMajorIons))

## ----abline_examp--------------------------------------------------------
plot(MenomineeMajorIons$Sulfate, MenomineeMajorIons$HCO3)
#horizontal line at specified y value
abline(h=140)
#a vertical line
abline(v=15)
#Line with a slope and intercept
abline(55, 6)

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

