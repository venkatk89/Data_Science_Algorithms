# load libraries

library(ggplot2)
library(dplyr)
library(data.table)
library(mltools)
library(xgboost)


# load data

x_train <- read.csv("C:/Users/VENKATESH K/Desktop/flu_shot_learning/data/training_set_features.csv")
y_train <- read.csv("C:/Users/VENKATESH K/Desktop/flu_shot_learning/data/training_set_labels.csv")


x_test <- read.csv("C:/Users/VENKATESH K/Desktop/flu_shot_learning/data/test_set_features.csv")
submission <- read.csv("C:/Users/VENKATESH K/Desktop/flu_shot_learning/data/submission_format.csv")


# merge train dataset
train <- merge(x_train, y_train, by = "respondent_id")

# convert all columns (including dependent variables) to categorical variables
train <- sapply(train, as.factor)
train <- as.data.frame(train)

# change dependent variables (also id) to numeric variable
train$respondent_id <- as.numeric(train$respondent_id)
train$h1n1_vaccine <- as.numeric(train$h1n1_vaccine)
train$seasonal_vaccine <- as.numeric(train$seasonal_vaccine)


# all changes done to train dataset is also done to test dataset
test_id <- x_test$respondent_id

x_test <- sapply(x_test, as.factor)
x_test <- as.data.frame(x_test)
x_test$respondent_id <- test_id



# features segregation (based on the details availabe in problem description)

h1n1_features <- c("h1n1_concern", "h1n1_knowledge" ,
                   "doctor_recc_h1n1", "opinion_h1n1_vacc_effective",
                   "opinion_h1n1_risk", "opinion_h1n1_sick_from_vacc")

seasflu_features <- c("doctor_recc_seasonal", "opinion_seas_vacc_effective",
                      "opinion_seas_risk", "opinion_seas_sick_from_vacc")



behavioral_features <- c("behavioral_antiviral_meds", "behavioral_avoidance",
                         "behavioral_face_mask", "behavioral_wash_hands" ,
                         "behavioral_large_gatherings", "behavioral_outside_home" ,
                         "behavioral_touch_face")

health_features <- c("chronic_med_condition", "child_under_6_months", 
                     "health_worker", "health_insurance")



demo_features <- c("age_group"  ,"education" ,"race" ,"sex" ,"income_poverty" ,
                   "marital_status" ,"rent_or_own" ,"employment_status" ,
                   "hhs_geo_region" ,"census_msa" ,"household_adults"  ,
                   "household_children" , "employment_industry" ,
                   "employment_occupation")



# variables to use to predict h1n1 vaccination
h1n1_vars <- c(h1n1_features, behavioral_features, health_features, demo_features)

# variables to use to predict seasonal flu vaccination
seasflu_vars <- c(seasflu_features, behavioral_features, health_features, demo_features)


h1n1_train <- train[,h1n1_vars]
h1n1_y <- as.numeric(train$h1n1_vaccine) - 1
h1n1_test <- x_test[,h1n1_vars]

sesflu_train <- train[,seasflu_vars]
seasflu_y <- as.numeric(train$seasonal_vaccine) - 1
seasflu_test <- x_test[,seasflu_vars]


factor_features <- c(behavioral_features, demo_features, h1n1_features, health_features, seasflu_features)




# One Hot Encode variables
# NA are considered seperate levels
h1n1_train_1h <- one_hot(as.data.table(h1n1_train))
seasflu_train_1h <- one_hot(as.data.table(sesflu_train))






# model for h1n1 vaccine
h1n1_xgb_1 <- xgboost(data = data.matrix(h1n1_train_1h), 
                      label = h1n1_y, 
                      objective = "binary:logistic", 
                      eval_metric = "auc",
                      max.depth = 15,
                      #lambda = 0.1,
                      eta = 0.1, 
                      nround = 100, 
                      #subsample = 0.5, 
                      colsample_bytree = 0.5, 
                      #num_class = 12,
                      #nthread = 3,
                      verbose = 1
)



importance_matrix <- xgb.importance(colnames(data.matrix(h1n1_train_1h)), model = h1n1_xgb_1)
xgb.plot.importance(importance_matrix, rel_to_first = TRUE, xlab = "Relative importance", top_n = 20)






#model for seasonal flu vaccine
seasflu_xgb_1 <- xgboost(data = data.matrix(seasflu_train_1h), 
                         label = seasflu_y, 
                         objective = "binary:logistic", 
                         eval_metric = "auc",
                         max.depth = 15,
                         #lambda = 0.1,
                         eta = 0.1, 
                         nround = 100, 
                         #subsample = 0.5, 
                         colsample_bytree = 0.5, 
                         #num_class = 12,
                         #nthread = 3,
                         verbose = 1
)


importance_matrix <- xgb.importance(colnames(data.matrix(seasflu_train_1h)), model = seasflu_xgb_1)
xgb.plot.importance(importance_matrix, rel_to_first = TRUE, xlab = "Relative importance", top_n = 20)







# prediction

h1n1_test_1h <- one_hot(as.data.table(h1n1_test))
seasflu_test_1h <- one_hot(as.data.table(seasflu_test))



h1n1_pred <- predict(h1n1_xgb_1, as.matrix(h1n1_test_1h))
seasflu_pred <- predict(seasflu_xgb_1, as.matrix(seasflu_test_1h))




submission$respondent_id <- test_id
submission$h1n1_vaccine <- h1n1_pred
submission$seasonal_vaccine <- seasflu_pred


#write.csv(submission, "submission_1.csv", row.names = FALSE)

