# tsne plot reduces dimensions and plots the whole data in 2-d

library(Rtsne)
library(ggplot2)

train_1 <- cbind(input_1, output)

tsne <- Rtsne(train_1, check_duplicates = FALSE)


#plot using ggplot2
ggplot(NULL, aes(x = tsne$Y[ , 1], y = tsne$Y[ , 2], 
                 color = train_1$output)) +
  geom_point() +
  labs(color = "output") +
  ggtitle(" tsne plot for selected features")

# you can atchually use this Y[,1] and y[,2] as features in models!!