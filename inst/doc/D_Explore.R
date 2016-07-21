## ----setup, echo=FALSE---------------------------------------------------
title="D. Explore"
gsIntroR::navigation_array(title)

## ----summary_data_example------------------------------------------------
summary(intro_df)

## ----range_examp---------------------------------------------------------
range(intro_df$Flow_Inst, na.rm=TRUE)

## ----iqr_examp-----------------------------------------------------------
IQR(intro_df$Wtemp_Inst, na.rm=TRUE)

## ----quantile_example----------------------------------------------------
quantile(intro_df$pH_Inst, na.rm=TRUE)

## ----quantile_probs_examp------------------------------------------------
quantile(intro_df$pH_Inst, probs=c(0.025, 0.975), na.rm=TRUE)

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----plot_examp----------------------------------------------------------
plot(intro_df$Wtemp_Inst, intro_df$DO_Inst)

## ----plot_examp_2--------------------------------------------------------
plot(intro_df$Wtemp_Inst, intro_df$DO_Inst,
     main="Changes in D.O. concentration as function of water temperature",
     xlab="Water temperature, deg C", ylab="Dissolved oxygen concentration, mg/L")

## ----pairs_examp---------------------------------------------------------
#get a data frame with only the measured values
intro_df_data <- select(intro_df, -site_no, -dateTime, -Flow_Inst_cd)
plot(intro_df_data)

## ----boxplot_examp-------------------------------------------------------
boxplot(intro_df$DO_Inst, main="Boxplot of D.O. Concentration", ylab="Concentration")

## ----boxplot_grps_examp--------------------------------------------------
boxplot(intro_df$DO_Inst ~ intro_df$site_no, 
        main="Boxplot of D.O. Concentration by Site", ylab="Concentration")

## ----base_hist_examp-----------------------------------------------------
hist(intro_df$pH_Inst)
hist(intro_df$pH_Inst, breaks=4)

## ----cdf_examp-----------------------------------------------------------
wtemp_ecdf <- ecdf(intro_df$Wtemp_Inst)
plot(wtemp_ecdf)

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

