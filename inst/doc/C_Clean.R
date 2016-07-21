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

#Take a look at the data frame
head(intro_df)
#And grab the first site_no
intro_df[1,1]
#Get a whole column
intro_df[,7]
#Get a single row
intro_df[15,]
#Grab multiple rows
intro_df[3:7,]

## ----more_data_frame_index-----------------------------------------------
#First, there are a couple of ways to use the column names
head(intro_df$site_no)
head(intro_df["site_no"])
head(intro_df[["site_no"]])
#Multiple colums
head(intro_df[c("dateTime","Flow_Inst")])
#Now we can combine what we have seen to do some more complex queries
#Get all the data where water temperature is greater than 15
high_temp <- intro_df[intro_df$Wtemp_Inst > 15,]
head(high_temp)
#Or maybe we want just the discharge that was estimated (code is "E")
estimated_q <- intro_df$Flow_Inst[intro_df$Flow_Inst_cd == "E"]
head(estimated_q)

## ----setup_dplyr,eval=FALSE----------------------------------------------
#  install.packages("dplyr")
#  library("dplyr")

## ----more_data_frame_dplyr-----------------------------------------------
#First, select some columns
dplyr_sel <- select(intro_df, site_no, dateTime, DO_Inst)
head(dplyr_sel)
#Now select some observations, like before
dplyr_high_temp <- filter(intro_df, Wtemp_Inst > 15)
head(dplyr_high_temp)
#Find just observations with estimated flows (as above)
dplyr_estimated_q <- filter(intro_df, Flow_Inst_cd == "E")
head(dplyr_estimated_q)

## ----mutate_example------------------------------------------------------
#Add a column with dissolved oxygen in mg/mL instead of mg/L
intro_df_newcolumn <- mutate(intro_df, DO_mgmL = DO_Inst/1000)
head(intro_df_newcolumn)

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
# if the column "DO_mgmL" (dissolved oxygen in mg/mL) does not exist, we want to add it
if(!'DO_mgmL' %in% names(intro_df)){
  mutate(intro_df, DO_mgmL = DO_Inst/1000)
} 

# if there are more than 1000 observations, we want to filter out high temperature observations
if(nrow(intro_df) > 1000){
  filter(intro_df, Wtemp_Inst >= 15)
}

## ----ifelse_dplyr--------------------------------------------------------
#use mutate along with ifelse to add a new column
intro_df_revised <- mutate(intro_df, Flow_revised = ifelse(Flow_Inst_cd == "X", NA, Flow_Inst))

## ----combine_commands----------------------------------------------------
#Intermediate data frames
dplyr_error_tmp1 <- select(intro_df, site_no, dateTime, Flow_Inst, Flow_Inst_cd)
dplyr_error_tmp <- filter(dplyr_error_tmp1, Flow_Inst_cd == "X")
head(dplyr_error_tmp)

#Nested function
dplyr_error_nest <- filter(
  select(intro_df, site_no, dateTime, Flow_Inst, Flow_Inst_cd),
  Flow_Inst_cd == "X")
head(dplyr_error_nest)

#Pipes
dplyr_error_pipe <- intro_df %>% 
  select(site_no, dateTime, Flow_Inst, Flow_Inst_cd) %>%
  filter(Flow_Inst_cd == "X")
head(dplyr_error_pipe)

# Every function, including head(), can be chained
intro_df %>% 
  select(site_no, dateTime, Flow_Inst, Flow_Inst_cd) %>%
  filter(Flow_Inst_cd == "X") %>% 
  head()

## ----pH_wrong_intro_df---------------------------------------------------
pH_df <- select(intro_df, pH_Inst)
pH_numeric_df <- mutate(pH_df, pH_Inst_numeric = as.numeric(pH_Inst))
filter(pH_numeric_df, is.na(pH_Inst_numeric), pH_Inst != "NA")

## ----cleaning_up_intro_df------------------------------------------------
intro_df <- mutate(intro_df, pH_Inst = as.numeric(pH_Inst))
summary(intro_df)

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----bind_rows_examp-----------------------------------------------------
#Let's first create a new small example data.frame
new_data <- data.frame(site_no=rep("00000001", 3), 
                       dateTime=c("2016-09-01 07:45:00", "2016-09-02 07:45:00", "2016-09-03 07:45:00"), 
                       Wtemp_Inst=c(14.0, 16.4, 16.0),
                       pH_Inst = c(7.8, 8.5, 8.3),
                       stringsAsFactors = FALSE)
head(new_data)
#Now add this to our existing df (intro_df)
bind_rows_df <- bind_rows(intro_df, new_data)
tail(bind_rows_df)

## ----merge_example-------------------------------------------------------
# DO and discharge data
forgotten_data <- data.frame(site_no=rep("00000001", 5),
                             dateTime=c("2016-09-01 07:45:00", "2016-09-02 07:45:00", "2016-09-03 07:45:00",
                                        "2016-09-04 07:45:00", "2016-09-05 07:45:00"),
                             DO_Inst=c(10.2,8.7,9.3,9.2,8.9),
                             Cl_conc=c(15.6,11.0,14.2,13.6,13.7),
                             Flow_Inst=c(25,54,67,60,59),
                             stringsAsFactors = FALSE)

left_join(new_data, forgotten_data, by=c("site_no", "dateTime"))


## ----Exercise2, echo=FALSE-----------------------------------------------

## ----group_by_examp------------------------------------------------------
class(intro_df)

# Group the data frame
intro_df_grouped <- group_by(intro_df, site_no)
class(intro_df_grouped)

## ----summarize_examp_NA--------------------------------------------------
intro_df_summary <- summarize(intro_df_grouped, mean(Flow_Inst), mean(Wtemp_Inst))
intro_df_summary

## ----summarize_examp-----------------------------------------------------
intro_df_summary <- summarize(intro_df_grouped, mean(Flow_Inst, na.rm=TRUE), mean(Wtemp_Inst, na.rm=TRUE))
intro_df_summary

## ----arrange_example-----------------------------------------------------
#ascending order is default
head(arrange(intro_df, DO_Inst))
#descending
head(arrange(intro_df, desc(DO_Inst)))
#multiple columns: lowest flow with highest temperature at top
head(arrange(intro_df, Flow_Inst, desc(Wtemp_Inst)))

## ----slice_example-------------------------------------------------------
#grab rows 3 through 10
slice(intro_df, 3:10)

## ----add_do_random-------------------------------------------------------
intro_df_2DO <- mutate(intro_df, DO_2 = runif(n=nrow(intro_df), min = 5.0, max = 18.0))
head(intro_df_2DO)

## ----no_rowwise_examp----------------------------------------------------
head(mutate(intro_df_2DO, max_DO = max(DO_Inst, DO_2)))

## ----rowwise_examp-------------------------------------------------------
class(intro_df_2DO)

intro_df_2DO_byrow <- rowwise(intro_df_2DO)
class(intro_df_2DO_byrow)

#Add a column that totals landuse for each observation
intro_df_DO_max <- mutate(intro_df_2DO_byrow, max_DO = max(DO_Inst, DO_2))
head(intro_df_DO_max)

## ----Exercise3, echo=FALSE-----------------------------------------------

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

