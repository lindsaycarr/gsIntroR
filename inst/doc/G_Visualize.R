## ----setup, echo=FALSE---------------------------------------------------
title="G. Visualize - base"
gsIntroR::navigation_array(title)

## ----pch_col_examp-------------------------------------------------------
#Create two data frames using dplyr (estimated & erroneous flows)
library(dplyr)
intro_df_est <- filter(intro_df, Flow_Inst_cd == "E")
intro_df_est_QpH <- select(intro_df_est, Flow_Inst, DO_Inst)
intro_df_err <-filter(intro_df, Flow_Inst_cd == "X") 
intro_df_err_QpH <- select(intro_df_err, Flow_Inst, DO_Inst)

#Now, plot estimated and erroneous points in different colors
plot(intro_df_err_QpH$Flow_Inst, intro_df_err_QpH$DO_Inst, pch=16, col='#FF5034')
points(intro_df_est_QpH$Flow_Inst, intro_df_est_QpH$DO_Inst, pch=16, col='skyblue')

## ----par_example---------------------------------------------------------
#save par arguments before changing them
default_par <- par()

#change par
par(las=2, tck=0.01, bg="darkseagreen")
plot(intro_df_err_QpH$Flow_Inst, intro_df_err_QpH$DO_Inst, pch=6)

## ----legend_example------------------------------------------------------
#use the same plot and add a legend to illustrate color and point type
plot(intro_df_err_QpH$Flow_Inst, intro_df_err_QpH$DO_Inst, pch=16, col='#FF5034')
points(intro_df_est_QpH$Flow_Inst, intro_df_est_QpH$DO_Inst, pch=16, col='skyblue')

#add a legend
legend(x="topright", legend=c("Erroneous flows", "Estimated flows"),
       pch=16, col=c('#FF5034', 'skyblue'), title="Legend")

## ----add_features_example------------------------------------------------
#plot formulas using curve()
curve(x^2, from=0, to=10)
curve(sin(x), from=-pi, to=pi)

#plot rectangles or polygons
plot(1:15, c(1:7, 9.5, 9:15), type='l')
rect(xleft=6, xright=10, ybottom=5, ytop=11, density=5, col="orange")
polygon(x=c(2,3,4), y=c(2,6,2), col="lightgreen", border=NA)

## ----warning = FALSE, message = FALSE------------------------------------
library(dataRetrieval)
# Gather NWIS data:
P_site1 <- readNWISqw("01656960", parameterCd = "00665")
P_site2 <- readNWISqw("01656725", parameterCd = "00665")

## ----axis_example--------------------------------------------------------
plot(intro_df$Flow_Inst, intro_df$Wtemp_Inst, pch=20)
#add a second y-axis
axis(side=4)

#now log the x axis
plot(intro_df$Flow_Inst, intro_df$Wtemp_Inst,  pch=20, log='x')
#format the second y-axis to have tick marks at every concentration (not just every 5) & no labels
axis(side=4, at=1:20, labels=FALSE)
#add a second x-axis
axis(side=3) #this axis is also logged

## ----multiple_plots_example----------------------------------------------
layout_matrix <- matrix(c(1:4), nrow=2, ncol=2, byrow=TRUE)
layout(layout_matrix)

#four boxplots:
plot1 <- boxplot(intro_df$Flow_Inst ~ intro_df$site_no, ylab="Discharge, cfs", main="Discharge")
plot2 <- boxplot(intro_df$Wtemp_Inst ~ intro_df$site_no, ylab="Temperature, deg C", main="Water Temp")
plot3 <- boxplot(intro_df$pH_Inst ~ intro_df$site_no, ylab="pH", main="pH")
plot4 <- boxplot(intro_df$DO_Inst ~ intro_df$site_no, ylab="D.O. Concentration, mg/L", main="Dissolved Oxygen")

dev.off()

## ----save_eg, eval=FALSE-------------------------------------------------
#  png("do_vs_wtemp.png", width=5, height=6, res=300, units="in") # see ?png
#  plot(intro_df$Wtemp_Inst, intro_df$DO_Inst)
#  dev.off()

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

