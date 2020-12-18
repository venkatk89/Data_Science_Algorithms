# library for CART (Classification And Regression Trees)
library(rpart)

#better version of plot.rpart i.e to visualize the tree
library(rpart.plot)

set.seed(1234)

#build a tree
tree_1 <- rpart(output ~ input_1$Pclass + input_1$Sex + input_1$SibSp + input_1$Parch + input_1$Fare)

# visualize the tree
prp(tree_1, type = 0, extra = 1, under = TRUE, varlen = 0)


# plot function in rpart is not effective
#par(mfrow = c(1,2), xpd = NA) # otherwise on some devices the text is clipped
#plot(tree_1)
#text(tree_1, use.n = TRUE)
