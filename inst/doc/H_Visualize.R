## ----setup, echo=FALSE---------------------------------------------------
title="H. Visualize - ggplot2"
gsIntroR::navigation_array(title)

## ----ggplot_install, message=FALSE---------------------------------------
# install.packages("ggplot2") # if needed
library(ggplot2)
library(dplyr)

#Load the data package!
library(smwrData)

## ----ggplot_examp--------------------------------------------------------
# aes() are the "aesthetics" info.  When you simply add the x and y
# that can seem a bit of a confusing term.  You also use aes() to 
# change clor, shape, size etc. of some items
data("MenomineeMajorIons")
ion_gg <- ggplot(MenomineeMajorIons, aes(x=Magnesium, y=Potassium))
ion_gg

## ----points_examp--------------------------------------------------------
#Different syntax than you are used to
ion_gg + geom_point()

#This too can be saved to an object
ion_scatter <- ion_gg + geom_point()

#Call it to create the plot
ion_scatter

## ----ion_labels----------------------------------------------------------
ion_scatter <- ion_scatter +
  labs(title="Potassium vs Magnesium Concentrations in Menominee River",
       x="Magnesium Concentration", y="Potassium Concentration")
# same thing, different commands
ion_scatter <- ion_scatter +
  ggtitle("Potassium vs Magnesium Concentrations in Menominee River") +
  xlab("Magnesium Concentration") + ylab("Potassium Concentration")
ion_scatter

## ----ion_colors----------------------------------------------------------
ion_scatter <- ion_scatter +
  geom_point(aes(color=season, shape=season), size=5)
ion_scatter

## ----ion_loess-----------------------------------------------------------
ion_scatter_loess <- ion_scatter +
  geom_smooth()
ion_scatter_loess

## ----ion_lm--------------------------------------------------------------
ion_scatter_lm <- ion_scatter +
  geom_smooth(method="lm")
ion_scatter_lm

## ----ion_lm_groups-------------------------------------------------------
ion_scatter_lm_group <- ion_scatter +
  geom_smooth(method="lm", aes(group=season))
ion_scatter_lm_group

## ----ion_lm_color--------------------------------------------------------
ion_scatter_lm_color <- ion_scatter +
  geom_smooth(method="lm", aes(color=season, fill=season))
ion_scatter_lm_color

## ----gg_box_examp--------------------------------------------------------
ggplot(MenomineeMajorIons, aes(x=season, y=Sodium)) +
  geom_boxplot()

## ----gg_hist_examp-------------------------------------------------------
ggplot(MenomineeMajorIons, aes(x=Sodium))+
  geom_histogram(binwidth=1)

## ----gg_bar_examp2-------------------------------------------------------
data("MiningIron")

MiningIron_grouped <- group_by(MiningIron, MineType)
iron_minetype_mean <- summarize(MiningIron_grouped, mean_iron=mean(Iron))
ggplot(iron_minetype_mean, aes(x=MineType, y=mean_iron)) +
  geom_bar(stat="identity")

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----themes_examp--------------------------------------------------------
scatter_ions <- ggplot(MenomineeMajorIons, aes(x=Magnesium, y=Potassium)) +
  geom_point(aes(color=season, shape=season))
scatter_ions

## ----themes_examp_custom-------------------------------------------------
scatter_ions_base <- scatter_ions + 
  theme(panel.background = element_blank(), 
        panel.grid = element_blank(),
        panel.border = element_rect(fill = NA),
        text = element_text(family="serif", color="red", size=24))
scatter_ions_base

## ----themes_examp_stock--------------------------------------------------
scatter_ions + theme_bw()
scatter_ions + theme_classic()

## ----themes_examp_polished-----------------------------------------------
#Now Let's start over, with some new colors and regression lines
scatter_ions_polished <- ggplot(MenomineeMajorIons, aes(x=Magnesium, y=Potassium)) +
  geom_point(aes(color=season, shape=season)) +
  stat_smooth(method="lm", aes(color=season)) +
  scale_color_manual(
    breaks=c("summer", "winter"), 
    values=c("steelblue1", "sienna")) + 
  theme_classic(18, "serif") +
  theme(text=element_text(color="slategray")) +
  labs(title="Relationship between Potassium and Magnesium",
       x="Magnesium Concentration", y="Potassium Concentration")

scatter_ions_polished 

## ----ggsave_examp, eval=FALSE--------------------------------------------
#  #Save as jpg, with 600dpi, and set width and height (see ?ggsave)
#  ggsave(plot=scatter_ions_polished, file="Fig1.jpg", dpi=600, width=8, height=5)
#  #Save as PDF
#  ggsave(plot=scatter_ions_polished, file="Fig1.pdf")

## ----Exercise2, echo=FALSE-----------------------------------------------

## ----facet_grid_example--------------------------------------------------
#Return to Magnesium vs Potassium scatter plot
ions <- ggplot(MenomineeMajorIons, aes(x=Magnesium, y=Potassium)) +
  geom_point() 
ions

# Faceting with one variable 
# season = row faceting
# . = no column faceting
ions + facet_grid(season ~ .)

# Faceting with two variables (remark codes of "<" indicate the sample was below the detection limit)
#Nitrate.rmk = row faceting
#Fluoride.rmk = column faceting
ions + facet_grid(Nitrate.rmk ~ Fluoride.rmk)

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

