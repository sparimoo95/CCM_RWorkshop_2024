## CCM R Workshop Session 2: Correlations

setwd("/Users/shireenparimoo/Documents/Teaching/R Workshop - June 2024/data/")

############################### CORRELATIONS ###########################


# A) Calculate correlations --------------------------------------

# just get the r
cor(x, y, use = "na.or.complete")

# perform a correlation test to test for statistical significance
cor.test(x, y, use = "na.or.complete")

# formula syntax: (we will re-visit this for other statistical tests)
cor.test(~ x + y, data = df, use = "na.or.complete")

# by default, `cor.test()` performs a pearson correlation
# you can also specify the type of correlation using the `method` argument
# other useful arguments include `conf.level` to specify the confidence level for the confidence intervals

# B) Visualize correlations -----------------------------------------------

### visualize correlations --> line

ggplot(prepped_df, aes(x = x, y = y)) +
  # add a black correlation line with SE intervals around it using `geom_smooth()`
  geom_smooth() +
  # `method` allows you to specify the smoothing method; we will use 'lm'
  # `se = TRUE` adds 95% confidence intervals around the line
  # you can also add individual datapoints to the figure using `geom_point()`
  # geom_point(alpha = 0.5, color = "purple4", position = "jitter", size = 1) + 
  theme_apa(x.font.size = 20, y.font.size = 20) +
  xlab("Age") + ylab("Systolic BP") 

#

# C) Correlation matrices --------------------------------------------------------

# `corrplot()` can be used to plot correlation matrices 
corrplot(prepped_df) # this is throwing an error because the dataframe has non-numeric variables in it

# create a new data frame with just the numeric variables
# numeric variables include: age, cigsPerDay, totChol, sysBP, diaBP, BMI, heartRate, glucose
# there are multiple ways to do this
# 1. using `select()` with tidyverse
numeric_vars_df1 <- prepped_df %>% 
  select()

# or base R
numeric_vars_df2 <- select(df, c(variables))

# check that the two dataframes are the same
all.equal(numeric_vars_df1, numeric_vars_df2) # TRUE

# 2. using `subset()` 
numeric_vars_df3 <- subset(df, select = c(variables))

all.equal(numeric_vars_df1, numeric_vars_df3) # TRUE

# 3. by indexing columns 
numeric_vars_df4 <- prepped_df[ , c(2,5,10:15)]

all.equal(numeric_vars_df1, numeric_vars_df4) # TRUE 

#

# D) Visualize correlation matrix -----------------------------------------

### plot a correlation matrix for all continuous variables

# 1. create a correlation matrix
corr_matrix <- cor(numeric_vars_df1)
corr_matrix # lots of NA values... likely because there is some missing data in the data frame

corr_matrix <- cor(numeric_vars_df1, use = "na.or.complete")
corr_matrix

# 2. plot it!
corrplot(corr_matrix) # default output; size and color of the circles indicates size of the correlation
corrplot(corr_matrix, method = "number") # show correlation values; number AND color both indicate size of the correlation
corrplot(corr_matrix, method = "color") # fills in the squares; color indicates size of the correlation

# more options are available when you type `?corrplot` into the console (or in the script)

#

