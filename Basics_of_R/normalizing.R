library(caret)

# Leverage caret's preProcess function to normalize data

preproc.data <- train[, c("Fare", "SibSp")] # numeric variable before preprocessing

preProc <- preProcess(preproc.data, method = c("center", "scale"))  #create a model

postproc.data <- predict(preProc, preproc.data)  #make the model normalize data

# preProcess in caret can do a lot of amazing things like imputing with mean, median, knn impute, normalize and a lot more