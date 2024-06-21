## CCM R Workshop Session 2: Regressions

setwd("/Users/shireenparimoo/Documents/Teaching/R Workshop - June 2024/data/")

############################### REGRESSIONS ############################### 




# A) Main effects --------------------------------------------------

## Continuous variables
# Do age and the number of cigarettes smoked per day contribute to blood pressure?

main_effects_model1 <- lm(outcome ~ predictor1 + predictor2, data = df)
summary() # use `summary()` to see coefficients, standard errors, and p-values

# plot the significant main effects 
# main effect of predictor
plot_model(model, 
           type = "pred", # provides estimated marginal effects predicted by the model (after accounting for effects of the other variables in the model)
           terms = "predictor",
           axis.title = c("X", "Y"),
           title = "Main effect of predictor on blood pressure") + theme_apa()

## Categorical variables
# Are smoking status and use of BP medications related to cholesterol levels?

main_effects_model2 <- lm(outcome ~ predictor1 + predictor2, data = df)
summary() ## interpretation of the output 

# plot the significant main effects
# 1. main effect of predictor1
plot_model(model, 
           type = "pred",
           terms = "predictor1",
           axis.title = c("X", "Y"),
           title = "Main effect of predictor1 on cholesterol levels") + theme_apa()

# 2. main effect of predictor 2
plot_model(model, 
           type = "pred",
           terms = "predictor2",
           axis.title = c("X", "Y"),
           title = "Main effect of predictor2 on cholesterol levels") + theme_apa()

## Categorical and continuous variables 
# CHALLENGE: Are sex and cholesterol levels related to blood pressure?


#

# B) Interactions ---------------------------

## Between categorical and continuous variables
# How are sex and cholesterol levels related to blood pressure?

interactions_model3 <- lm(outcome ~ predictor1 * predictor2, data = prepped_df)
summary()

plot_model(interactions_model3, 
           type = "pred",
           terms = c("predictor1", "predictor2")) + theme_apa()
#

## CHALLENGE: how are age, hypertension, and history of stroke related to cholesterol levels? 










