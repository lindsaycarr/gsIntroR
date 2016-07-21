## ----setup, echo=FALSE---------------------------------------------------
title="H. Visualize - ggplot2"
gsIntroR::navigation_array(title)

## ----ggplot_install, message=FALSE---------------------------------------
# install.packages("ggplot2") # if needed
library(ggplot2)
library(dplyr)

## ----ggplot_examp--------------------------------------------------------
# aes() are the "aesthetics" info.  When you simply add the x and y
# that can seem a bit of a confusing term.  You also use aes() to 
# change color, shape, size etc. of some items
qtemp_gg <- ggplot(data=intro_df, aes(x=Flow_Inst, y=Wtemp_Inst))
qtemp_gg

## ----points_examp--------------------------------------------------------
#Different syntax than you are used to
qtemp_gg + geom_point()

#This too can be saved to an object
qtemp_scatter <- qtemp_gg + geom_point()

#Call it to create the plot
qtemp_scatter

## ----ion_labels----------------------------------------------------------
qtemp_scatter <- qtemp_scatter +
  labs(title="Water temperature vs Flow",
       x="Discharge, cfs", y="Water temperature, deg C")
# same thing, different commands
qtemp_scatter <- qtemp_scatter +
  ggtitle("Water temperature vs Flow") +
  xlab("Discharge, cfs") + ylab("Water temperature, deg C")
qtemp_scatter

## ----ion_colors----------------------------------------------------------
qtemp_scatter <- qtemp_scatter +
  geom_point(aes(color=Flow_Inst_cd, shape=site_no), size=2)
qtemp_scatter

## ----ion_loess-----------------------------------------------------------
qtemp_scatter + geom_smooth()

## ----ion_lm--------------------------------------------------------------
qtemp_scatter + geom_smooth(method="lm")

## ----ion_lm_groups-------------------------------------------------------
qtemp_scatter + geom_smooth(method="lm", aes(group=site_no))

## ----ion_lm_color--------------------------------------------------------
qtemp_scatter + geom_smooth(method="lm", aes(color=Flow_Inst_cd, fill=Flow_Inst_cd))

## ----gg_box_examp--------------------------------------------------------
ggplot(data=intro_df, aes(x=site_no, y=DO_Inst)) + geom_boxplot()

## ----gg_hist_examp-------------------------------------------------------
ggplot(data=intro_df, aes(x=pH_Inst))+ geom_histogram()

## ----gg_bar_examp2-------------------------------------------------------
intro_df_grouped <- group_by(intro_df, site_no)
intro_df_flow_mean <- summarize(intro_df_grouped, mean_flow=mean(Flow_Inst, na.rm=TRUE))
ggplot(intro_df_flow_mean, aes(x=site_no, y=mean_flow)) +
  geom_bar(stat="identity")

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----themes_examp--------------------------------------------------------
qtemp_scatter <- ggplot(data=intro_df, aes(x=Flow_Inst, y=Wtemp_Inst)) +
  geom_point(aes(color=Flow_Inst_cd, shape=site_no))
qtemp_scatter

## ----themes_examp_custom-------------------------------------------------
qtemp_scatter_base <- qtemp_scatter + 
  theme(panel.background = element_blank(), 
        panel.grid = element_blank(),
        panel.border = element_rect(fill = NA),
        text = element_text(family="serif", color="blue", size=15))
qtemp_scatter_base

## ----themes_examp_stock--------------------------------------------------
qtemp_scatter + theme_bw()
qtemp_scatter + theme_classic()

## ----themes_examp_polished-----------------------------------------------
#Now Let's start over, with some new colors and regression lines
qtemp_scatter_polished <- ggplot(data=intro_df, aes(x=Flow_Inst, y=Wtemp_Inst)) +
  geom_point(aes(color=Flow_Inst_cd, shape=site_no)) +
  stat_smooth(method="lm", aes(color=Flow_Inst_cd)) + 
  theme_bw(15, "serif") +
  theme(text=element_text(color="slategray"), panel.grid = element_blank()) +
  labs(title="Relationship between Water temperature and Discharge",
       x="Discharge, cfs", y="Water temp, deg C")

qtemp_scatter_polished 

## ----ggsave_examp, eval=FALSE--------------------------------------------
#  #Save as jpg, with 600dpi, and set width and height (see ?ggsave)
#  ggsave(plot=qtemp_scatter_polished, file="Fig1.jpg", dpi=600, width=8, height=5)
#  #Save as PDF
#  ggsave(plot=qtemp_scatter_polished, file="Fig1.pdf")

## ----Exercise2, echo=FALSE-----------------------------------------------

## ----facet_grid_example--------------------------------------------------
#Return to Water temp vs Flow scatter plot
qtemp <- ggplot(data=intro_df, aes(x=Flow_Inst, y=Wtemp_Inst)) +
  geom_point() 
qtemp

# Faceting with one variable 
# site_no = row faceting
# . = no column faceting
qtemp + facet_grid(site_no ~ .)

# Faceting with two variables
#site_no = row faceting
#Flow_Inst_cd = column faceting
qtemp + facet_grid(site_no ~ Flow_Inst_cd)

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

