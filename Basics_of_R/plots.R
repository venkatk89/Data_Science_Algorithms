# simple line plot
plot(x <- x, y <- x_1, type = 'o', xlab = "x-axis", ylab = "y-axis", main = "plot-title", sub = "sub title", asp = 1)



# plot with aspect ratio y/x = 4
plot(x <- train$PassengerId, y <- train$Fare, type = 'o', asp = 4)




# plot scatterplot and the regression line
x <- c(173, 169, 176, 166, 161, 164, 160, 158, 180, 187)
y <- c(80, 68, 72, 75, 70, 65, 62, 60, 85, 92)
mod1 <- lm(y ~ x)
plot(x, y, xlim=c(min(x)-5, max(x)+5), ylim=c(min(y)-10, max(y)+10), xlab = "x-axis", ylab = "y-axis", main = "plot-title", sub = " Slope = 0.9839     Intercept = -94")
abline(mod1, lwd=2)




# import library
library(ggplot2)




# bar graph
ggplot(train, aes(x = Pclass, fill = factor(Survived))) +
geom_bar() +                                                   # for bar graph
xlab("Pclass") +                                               # for x axis label
ylab("Total Count") +                                          # for y axis label
labs(fill = "Survived") +                                      # for scale like labelling
ggtitle("first_plot", subtitle = "abcb")                       # title of the plot

# pie chart
x <- c(24.32, 9.22, 40.01, 1.61, 18.33, 6.50)
y <- c("Domestic", "Commercial", "Industrial", "Traction", "Agriculture", "Misc.")
pie(x, labels = y, main="Energy Consumption in India in 2016-17")


