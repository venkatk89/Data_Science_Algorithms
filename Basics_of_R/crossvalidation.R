library(caret)  #like scikit learn for R


set.seed(2345)

# Leverage caret to create 100(10 folds repeated 10 times) total folds, but ensure that the ratio of those
# that survived and perished in each fold matches the overall training set. This
# is known as stratified cross validation and generally provides better results.

cv.10.folds <- createMultiFolds(output, k = 10, times = 10)


# setting up caret's training object(traincontrol) to start the process
ctrl_1 <- trainControl(method = "repeatedcv", number = 10, repeats = 10, index = cv.10.folds)


# Set seed for reproducibility and train
set.seed(34324)
rf.cv <- train(x = input_1, y = output, method = "rf", tuneLength = 2,
                   ntree = 1000, trControl = ctrl_1)


# Check out results
rf.cv

