# Random forest

library(randomForest)

input <- train[,c(3,5,7,8,10,12)]   #train input
output <- as.factor(train$Survived) # if output is num it does regression, so for classification output should be factor.



#random forest takes random samples based on seed value and build ntree no. of decession trees



#building the model
set.seed(1234)                                                                  # if you are comparing models same seed will only make sense.
rf_1 <- randomForest(x = input, y = output, importance = TRUE, ntree = 1000)    # importance tracks things and ntree is no.of trees to be trained.
varImpPlot(rf_1)     #  plots each columns predictivity                         # the more right the columns point is the more important it is.



# getting model info
rf_1
rf_2
summary(rf_1)
# oob estimate gives the out of bound error, Eout considering the points that are not taken
# confusion matrix gives percentage error for each class by mentioning no. of correct and wrong classification 



#attempt to build better model
input_1 <- train[,c(3,5,7,8,10)]
set.seed(1234)                                                                 # if you are comparing models same seed implies only features.
rf_2 <- randomForest(x = input_1, y = output, importance = TRUE, ntree = 1000) # make changes and not the process of building forest.  
varImpPlot(rf_2)


#test input
test_input <- test[,c(2,4,6,7,9)]



#make predictions based on model
test_output <- predict(rf_2, test_input)
table(test_output)



#make an output dataframe
template$Survived <- test_output


#write a csv file to submit
write.csv(template, "gender_submission.csv", row.names = FALSE)


