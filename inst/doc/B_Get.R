## ----setup, echo=FALSE---------------------------------------------------
title="B. Get"
gsIntroR::navigation_array(title)

## ----operators_console, eval=FALSE, echo=TRUE----------------------------
#  #A really powerful calculator!
#  1 + 1 #Add
#  10 - 4 #Subtract
#  3 * 2 #Multiply
#  3 ^ 3 #Exponents
#  100 / 10 #Divide
#  5 %% 2 #Modulus
#  5 > 2 #Greater than
#  4 < 5 #Less than
#  5 <= 5 #Less than or equal
#  8 >= 2 #Greater than or equal
#  2 == 2 #Equality: notice that it is TWO equal signs!
#  5 != 7 #Not Equals

## ----assignment_operator-------------------------------------------------
#Numeric assignment
x <- 5
x
y <- x + 1
y
z <- x + y
z
#Character
a <- "Bob"
a
b <- "Sue"
b
a2 <- "Larry"
a2

## ----useful_functions_workspace, eval=FALSE------------------------------
#  #List all objects in current workspace
#  ls()
#  ls(pattern="a")
#  
#  #Remove an object
#  rm(x)
#  
#  #Save your workspace
#  #Saves the whole thing to a file called lessonB.RData
#  save.image("lessonB.RData")
#  #Saves just the a and y objects to a file called lessonB_ay.RData
#  save(a, y, file="lessonB_ay.RData")

## ----useful_functions_directory, eval=FALSE------------------------------
#  #See the current directory
#  getwd()
#  
#  #Change the directory
#  setwd("temp")
#  
#  #List files and directories
#  list.files()

## ----Exercise1, echo=FALSE-----------------------------------------------

## ----na_examples, eval=FALSE---------------------------------------------
#  na.omit() #na.omit - removes them
#  na.exclude() #similar to omit, but has different behavior with some functions.
#  is.na() #Will tell you if a value is NA

## ------------------------------------------------------------------------
1 / 0
1 / Inf

## ------------------------------------------------------------------------
0 / 0
NaN

## ----use_c---------------------------------------------------------------
char_vector <- c("Joe", "Bob", "Sue")
num_vector <- c(1, 6, 99, -2)
logical_vector <- c(TRUE, FALSE, FALSE, TRUE, T, F)

## ----examine_vector------------------------------------------------------
#Print the vector
print(char_vector)
char_vector

#Examine the vector
typeof(char_vector)
length(logical_vector)
class(num_vector)
str(char_vector)

## ----add_to_vec----------------------------------------------------------
char_vector <- c(char_vector, "Jeff")
char_vector

## ----vector_shortcuts----------------------------------------------------
#Create a series
series <- 1:10
seq(10)
seq(1, 10, by = 0.1)

#Repeat values
fives <- rep(5, 10)
fives
laugh <- rep("Ha", 100)
laugh

## ----vectorized_examp----------------------------------------------------
#A numeric example
x <- 1:10
y <- 10:1
z <- x + y
z

#another one, with different lengths
a <- 1
b <- 1:10
c <- a + b
c

#A character example with paste()
first <- c("Buggs", "Elmer", "Pepe", "Foghorn")
last <- c("Bunny", "Fudd", "Le Pew", "Leghorn")
first_last <- paste(first, last)
first_last

## ----factor_examples-----------------------------------------------------
#An unordered factor
yn <- factor(c("yes", "no", "no", "yes", "yes"))
yn

#An ordered factor
lmh <- factor(c("high","high","low","medium","low","medium","high"),
              levels=c("low","medium","high"), ordered=TRUE)
lmh

## ----create_data_frame---------------------------------------------------
numbers <- c(1:26, NA)
lettersNew <- c(NA, letters) #letters is a special object available from base R
logical <- c(rep(TRUE, 13), NA, rep(FALSE, 13))
examp_df <- data.frame(lettersNew, numbers, logical, stringsAsFactors = FALSE)

## ----examine_data_frame--------------------------------------------------
#See the first 6 rows
head(examp_df)
#See the last 6 rows
tail(examp_df)
#See column names
names(examp_df)
#see row names
rownames(examp_df)
#Show structure of full data frame
str(examp_df)
#Show number of rows and colums
dim(examp_df)
nrow(examp_df)
ncol(examp_df)
#Get summary info
summary(examp_df)
#remove NA
na.omit(examp_df)

## ----list_examples-------------------------------------------------------
examp_list <- list(
  letters=c("x","y","z"),
  animals=c("cat","dog","bird","fish"),
  numbers=1:100,
  df=examp_df)
examp_list

## ----read_csv_examp------------------------------------------------------
# Read in the data and take a look at it
intro_df <- read.csv("data/course_NWISdata.csv")
head(intro_df)
str(intro_df)
dim(intro_df)
summary(intro_df)

## ---- eval=FALSE---------------------------------------------------------
#  str(read.csv("data/course_NWISdata.csv"))
#  str(read.csv("data/course_NWISdata.csv", stringsAsFactors=FALSE))

## ------------------------------------------------------------------------
intro_df <- read.csv("data/course_NWISdata.csv", stringsAsFactors = FALSE, colClasses = c("character", rep(NA, 6)))
str(intro_df)

## ----write.csv examp, eval=FALSE-----------------------------------------
#  write.table(intro_df, file = "example_data_frame.csv", sep=",")
#  # or
#  write.csv(intro_df, file="example_data_frame.csv")

## ----dataRetrievalExample, eval=FALSE------------------------------------
#  library(dataRetrieval)
#  # Gather NWIS data:
#  siteListPhos <- readNWISdata(
#    stateCd="FL", parameterCd="00665", drainAreaMin=400,
#    siteType="ST", service="site")
#  phosData <- readNWISqw(siteListPhos$site_no, parameterCd="00665")
#  head(phosData)

## ----Exercise2, echo=FALSE-----------------------------------------------

## ----echo=FALSE----------------------------------------------------------
gsIntroR::navigation_array(title)

