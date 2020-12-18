# mutual information, conditional mutual information and INFORMATION THEORY in general

library(infotheo)


# convert numeric variables into discrete variablet

discretize(input_1$Fare)


# get mutual information for all variables

mutinformation(output, discretize(input_1$Fare))

mutinformation(output, input_1$Pclass)

mutinformation(output, input_1$Sex)

mutinformation(output, input_1$SibSp)

mutinformation(output, input_1$Parch)

# higher the value, higher the predictability



# conditional mutual information : mutual information given the other feature

condinformation(output, input_1[ , c(1,2)])

condinformation(output, input_1[ , c(3,4)])

