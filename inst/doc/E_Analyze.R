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
#Filter so that there are only two Flow_Inst_cd groups
#You might have to load dplyr
library(dplyr)
err_est_df <- filter(intro_df, Flow_Inst_cd %in% c("X", "E"))
t.test(err_est_df$Flow_Inst ~ err_est_df$Flow_Inst_cd)

## ----corr_examp,message=FALSE,warning=FALSE------------------------------
#A simple correlation
cor(intro_df$Wtemp_Inst, intro_df$DO_Inst, use="complete.obs")
#And a test of that correlation
cor.test(intro_df$Wtemp_Inst, intro_df$DO_Inst)

#A data frame as input to cor returns a correlation matrix
#Can't just do cor(intro_df) because intro_df has non-numeric columns:
# cor(intro_df)
# use dplyr to select the numeric columns of intro_df
intro_df_onlynumeric <- select(intro_df, -site_no, -dateTime, -Flow_Inst_cd)  
cor(intro_df_onlynumeric, use="complete.obs")

## ----lm_examp------------------------------------------------------------
lm(pH_Inst ~ Flow_Inst, data=intro_df)
#Not much info, so save to object and use summary
lm_gwq1 <- lm(pH_Inst ~ Flow_Inst, data=intro_df)
summary(lm_gwq1)
#And now a multiple linear regression
lm_gwq2 <- lm(pH_Inst ~ Flow_Inst + DO_Inst + Wtemp_Inst, data=intro_df)
summary(lm_gwq2)

## ----abline_examp_lm-----------------------------------------------------
plot(intro_df$Flow_Inst, intro_df$pH_Inst)
#abline accepts a linear model object as input
#linear model is done with lm, and uses a formula as input
abline(lm(pH_Inst ~ Flow_Inst, data=intro_df))

## ----abline_examp--------------------------------------------------------
plot(intro_df$Wtemp_Inst, intro_df$DO_Inst)
#horizontal line at specified y value
abline(h=11)
#a vertical line
abline(v=15)
#Line with a slope and intercept
abline(7, 0.5)

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

