## ----setup, echo=FALSE---------------------------------------------------
set.seed(3)
title="C. Clean"
gsIntroR::navigation_array(title)

## ----indexing_examp------------------------------------------------------
#Create a vector
x <- c(10:19)
x
#Positive indexing returns just the value in the ith place
x[7]
#Negative indexing returns all values except the value in the ith place
x[-3]
#Ranges work too
x[8:10]
#A vector can be used to index
#Can be numeric
x[c(2,6,10)]
#Can be boolean - will repeat the pattern 
x[c(TRUE,FALSE)]
#Can even get fancy
x[x %% 2 == 0]

## ----data_frame_index----------------------------------------------------
#Let's use one a data frame from the smwrData package

#Load the package and data frame:
library(smwrData)
data("PugetNitrate")

head(PugetNitrate)
#And grab a specific value
PugetNitrate[1,1]
#A whole column
nitrate_levels <- PugetNitrate[,7]
nitrate_levels
#A row
obs15<-PugetNitrate[15,]
obs15
#Many rows
obs3to7<-PugetNitrate[3:7,]
obs3to7

## ----more_data_frame_index-----------------------------------------------
#First, there are a couple of ways to use the column names
PugetNitrate$wellid
head(PugetNitrate["wellid"])
#Multiple colums
head(PugetNitrate[c("date","nitrate")])
#Now we can combine what we have seen to do some more complex queries
#Get all the data where nitrate concentration is greater than 10
high_nitrate <- PugetNitrate[PugetNitrate$nitrate > 10,]
head(high_nitrate)
#Or maybe we want just the nitrate concentrations for Bedrock geology
bedrock_nitrate <- PugetNitrate$nitrate[PugetNitrate$surfgeo == "BedRock"]
head(bedrock_nitrate)

## ----setup_dplyr,eval=FALSE----------------------------------------------
#  install.packages("dplyr")
#  library("dplyr")

## ----more_data_frame_dplyr-----------------------------------------------
#First, select some columns
dplyr_sel <- select(PugetNitrate, date, nitrate, surfgeo)
head(dplyr_sel)
#That's it.  Select one or many columns
#Now select some observations, like before
dplyr_high_nitrate <- filter(PugetNitrate, nitrate > 10)
head(dplyr_high_nitrate)
#Or maybe we want just the bedrock samples
bedrock_nitrate <- filter(PugetNitrate, surfgeo == "BedRock")
head(bedrock_nitrate)

## ----mutate_example------------------------------------------------------
#Add a column with well depth in kilometers instead of meters
PugetNitrate_newcolumn <- mutate(PugetNitrate, wellkm = wellmet/1000)
head(PugetNitrate_newcolumn)

## ----if_else_examp-------------------------------------------------------
x <- 2

# logical statement inside of () needs to return ONE logical value - TRUE or FALSE. TRUE means it will enter the following {}, FALSE means it won't.
if(x < 0){
  print("negative")
} 

# you can also specify something to do when the logical statement is FALSE by adding `else`
if(x < 0){
  print("negative")
} else {
  print("positive")
}

## ----if_else_functions---------------------------------------------------
y <- 1:7

# use "any" if you want to see if at least one of the values meets a condition
any(y > 5)

# use "!any" if you don't want any of the values to meet some condition (e.g. vector can't have negatives)
!any(y < 0) 

# use "all" when every value in a vector must meet a condition
all(y > 5)

# using these in the if-else statement
if(any(y < 0)){
  print("some values are negative")
} 

## ----if_else_examp2------------------------------------------------------
num <- 198

if(num > 0) {
  print("positive")
} else if (num < 0) {
  print("negative")
} else {
  print("zero")
}

## ----if_else_dplyr-------------------------------------------------------
# if the column "wellkm" (well depth in kilometers) does not exist, we want to add it
if(!'wellkm' %in% names(PugetNitrate)){
  mutate(PugetNitrate, wellkm = wellmet/1000)
} 

# if there are more than 1000 observations, we want to filter out older observations
if(nrow(PugetNitrate) > 1000){
  filter(PugetNitrate, date >= as.Date("1990-01-01"))
}

## ----ifelse_dplyr--------------------------------------------------------
#use mutate along with ifelse to add a new column
PugetNitrate_categorized <- mutate(PugetNitrate, nitrate_category = ifelse(nitrate > 1, "high", "low"))

## ----combine_commands----------------------------------------------------
#Intermediate data frames
#Select First: note the order of the output, neat too!
dplyr_bedrock_tmp1 <- select(PugetNitrate, surfgeo, date, nitrate)
dplyr_bedrock_tmp <- filter(dplyr_bedrock_tmp1, surfgeo == "BedRock")
head(dplyr_bedrock_tmp)

#Nested function
dplyr_bedrock_nest <- filter(
  select(PugetNitrate, surfgeo, date, nitrate),
  surfgeo == "BedRock")
head(dplyr_bedrock_nest)

#Pipes
dplyr_bedrock_pipe <- PugetNitrate %>% 
  select(surfgeo, date, nitrate) %>%
  filter(surfgeo == "BedRock")
head(dplyr_bedrock_pipe)

# Every function, including head(), can be chained
PugetNitrate %>% 
  select(surfgeo, date, nitrate) %>%
  filter(surfgeo == "BedRock") %>% 
  head()

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----bind_rows_examp-----------------------------------------------------
#Let's first create a new small example data.frame
bind_rows_df1 <- data.frame(a=1:3, b=c("a","b","c"), c=c(T,T,F), d=rnorm(3))
#Now an example df to add
bind_rows_df2 <- data.frame(a=10:12, b=c("x","y","z"), c=c(F,F,F), d=rnorm(3))
bind_rows_df <- bind_rows(bind_rows_df1, bind_rows_df2)
bind_rows_df

## ----merge_example-------------------------------------------------------
# Contrived data frame
bind_rows_df_merge_me <- data.frame(
  a=c(1,3,10,11,14,6,23), x=rnorm(7), 
  names=c("bob","joe","sue",NA,NA,"jeff",NA))

bind_rows_df_merge <- left_join(bind_rows_df, bind_rows_df_merge_me, by="a")
bind_rows_df_merge

## ----Exercise2, echo=FALSE-----------------------------------------------

## ----group_by_examp------------------------------------------------------
class(PugetNitrate)

# Group the data frame
PugetNitrate_grouped <- group_by(PugetNitrate, surfgeo)
class(PugetNitrate_grouped)

## ----summarize_examp-----------------------------------------------------
PugetNitrate_summary <- summarize(PugetNitrate_grouped, mean(nitrate), mean(wellmet))
PugetNitrate_summary

## ----arrange_example-----------------------------------------------------
data("TNLoads")
head(TNLoads)

#ascending order is default
head(arrange(TNLoads, LOGTN))
#descending
head(arrange(TNLoads, desc(LOGTN)))
#multiple columns: most nitrogen with lowest rainfall at top
head(arrange(TNLoads, desc(LOGTN), MSRAIN))

## ----slice_example-------------------------------------------------------
#grab rows 3 through 10
slice(TNLoads, 3:10)

## ----rowwise_examp-------------------------------------------------------
class(TNLoads)

TNLoads_byrow <- rowwise(TNLoads)
class(TNLoads_byrow)

#Add a column that totals landuse for each observation
landuse_sum <- mutate(TNLoads_byrow, landuse_total = sum(PRES, PNON, PCOMM, PIND))
head(landuse_sum)

## ----Exercise3, echo=FALSE-----------------------------------------------

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

