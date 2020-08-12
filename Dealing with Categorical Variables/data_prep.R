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


#uncomment the following line to write data
#write.csv(train, "train.csv", row.names = FALSE)




# features segregation

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



# uncomment following lines to write data to local memory

#write.csv(h1n1_train, "h1n1_train.csv", row.names = FALSE)
#write.csv(sesflu_train, "seas_train.csv", row.names = FALSE)
#write.csv(h1n1_test, "h1n1_test.csv", row.names = FALSE)
#write.csv(seasflu_test, "seas_test.csv", row.names = FALSE)
#write.csv(test_id, "test_id.csv", row.names = FALSE)




