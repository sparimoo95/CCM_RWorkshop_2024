## CCM R Workshop Session 2: Data exploration

setwd("/Users/shireenparimoo/Documents/Teaching/R Workshop - June 2024/data/")


## 00. Load libraries ----------------------------------------------------

library(tidyverse) # we will use this library, which comes with its own syntax
library(jtools) # `theme_apa` for plotting
library(corrplot) # visualize correlations
library(stats)
library(sjPlot) # plot regression output

#
## 01. Import data ------------------------------------------------------

raw_df <- read.csv("framingham.csv", header = TRUE, sep = ",")

#


############################### DATA EXPLORATION ####################

## Explore data ---------------------------------------------------------

str(raw_df) # prints out the structure of the dataframe

# we can already tell that sex should be changed to a categorical variable, not kept as an integer
# what about education? it looks like education only ranges from 1-4
# let's take a closer look

count(raw_df, education) # counts the unique values in the `education` column of the `raw_df` data frame and their frequency

# OK, so education only has four values or missing data (NA) 
# this means that each number corresponds to some educational attainment (refer back to the dataset description)
# (e.g., did not complete high school, completed high school/GED, went to some university/college, graduated from university/college)
# as these are different types of education, we to treat this column as a categorical variable i.e., factor

# other notable columns that are currently set as integers (because they contain 1s and 0s)
# but are coded as binary outcomes (i.e., yes/no or TRUE/FALSE) include:
# currentSmoker, BPMeds, prevalentStroke, prevalentHyp, diabetes, and TenYearCHD
# these columns should be coded as factors as well

# might want to change the measurement variables (e.g., heartRate, sysBP, diaBP, totChol, and glucose to numeric)
# `BMI` is fine as numeric

# 02. Data preparation in base R -----------------------------------------

# first, create a new dataframe that essentially duplicates the raw dataframe
prepped_df_base <- as.data.frame(raw_df)

# change the class of selected variables to factors and numeric
# we can use `mutate_at()` to change the class of several variables at once
# the syntax is `mutate_at(df, c(variables), function)`
# function can be `factor` or `as.numeric`, in our case
# our factor variables: "male", "education", "currentSmoker", "BPMeds", "prevalentStroke", "prevalentHyp", "diabetes", "TenYearCHD"
# our numeric variables: "age", "cigsPerDay", "totChol", "sysBP", "diaBP", "heartRate", "glucose"
prepped_df_base <- mutate_at(df, variables, function)
prepped_df_base <- mutate_at(df, variables, function)

# create a new column for sex
prepped_df_base$sex <- ifelse() # `ifelse` is useful when you have a binary set of values as output 

# assign descriptive values to the education variable  
# `case_when` is useful/cleaner to use when there are multiple possible output values
# we want to replace the numbers with the following values:
# "< High School", "High School Graduate", "Some College", and "College Graduate"
prepped_df_base$education <- case_when()

str(prepped_df_base)

# education and sex have been changed to `chr`, but they are supposed to be categorical variables 
# change the class of the sex and education variables
prepped_df_base$sex <- as.factor(df$variable)
prepped_df_base$education <- as.factor(df$variable)

str(prepped_df_base) # everything looks good now

# create new data frames to select only a subset of the sample for later analyses 
# data frame 1: participants who have coronary heart disease in 10 years (i.e., `TenYearCHD == 1`)
# data frame 2: participants who do not have coronary heart disease in 10 years (i.e., `TenYearCHD == 0`)

# there are two ways to do this in base R: using `filter()` or using `subset()`
# 1. using `filter()` -- can be used to select rows containing specific values
prepped_df_base_chd <- filter(df, df$variable == value)
prepped_df_base_no_chd <- filter(df, df$variable == value)

# 2. using `subset()` -- can be used to select rows containing specific values AND specific columns 
prepped_df_base_chd2 <- subset(df, variable == value)
prepped_df_base_no_chd2 <- subset(df, variable == value)

# check that the two data frames are the same
all.equal(prepped_df_base_chd, prepped_df_base_chd2, check.attributes = FALSE) # row numbers are different between the data frames 
all.equal(prepped_df_base_no_chd, prepped_df_base_no_chd2, check.attributes = FALSE) # row numbers are different between the data frames 

## CHALLENGE: create a new data frames for male participants who develop CHD in 10 years 

#
# 02b. Data preparation using tidyr ----------------------------------------------------

# let's create a new dataframe where we make all those changes
# we will use the tidyverse library to do this

prepped_df_tidy <- raw_df %>%  # this is a pipe; it allows you to perform a sequence of actions on a single object
  # now let's first change some of the variables to factors and numerics
  # the mutate_at function will take a vector of the column names you want to change to factor 
  # and apply the `factor` function to those variables in the `prepped_df_tidy` dataframe
  mutate_at() %>% 
  mutate_at() %>% 
  # let's also change the values in the male and education columns to make them more descriptive
  # and convert them to factors all at once
  mutate(sex = as.factor(ifelse()),                              
         education = as.factor(case_when()))

# check that the dataframes created using tidyr and base R are identical
all.equal(prepped_df_base, prepped_df_tidy) # TRUE

# create new data frames for those with and without CHD in 10 years
prepped_df_chd <- prepped_df_tidy %>% 
  filter()

prepped_df_no_chd <- prepped_df_tidy %>% 
  filter()


# check that the prepped_df_chd and prepped_df_no_chd produced using tidyr are the 
# same as those produced using base R

all.equal(prepped_df_chd, prepped_df_base_chd) # TRUE
all.equal(prepped_df_no_chd, prepped_df_base_no_chd) # TRUE

## TIDYVERSE vs BASE R
# note that in base R, you have to continuously refer to the dataframe and variable names
# especially inside functions, whereas you can reference the dataframe using a `.` with tidyverse
# also note that you have to run multiple lines of code when using base R for each new change
# this can be accomplished in one go using tidyverse 

# for simplicity, I will create duplicate the above data frame as assign it to `prepped_df`

prepped_df <- as.data.frame(prepped_df_tidy)

#
