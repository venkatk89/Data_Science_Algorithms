# DATA VISUALIZATION

# dummy data
x <- c(173, 169, 176, 166, 161, 164, 160, 158, 180, 187)
y <- c(80, 68, 72, 75, 70, 65, 62, 60, 85, 92)

# simple line plot
plot(x,y)


# plot scatterplot and the regression line
mod1 <- lm(y ~ x)
plot(x, y, 
     xlim=c(min(x)-5, max(x)+5), ylim=c(min(y)-10, max(y)+10), 
     xlab = "x-axis", ylab = "y-axis", 
     main = "plot-title", sub = " Slope = 0.9839     Intercept = -94")
abline(mod1, lwd=2)


# pie chart
x <- c(24.32, 9.22, 40.01, 1.61, 18.33, 6.50)
y <- c("Domestic", "Commercial", "Industrial", "Traction", "Agriculture", "Misc.")
pie(x, labels = y, main="Energy Consumption in India in 2016-17")



# Using ggplot package for better data visualiation

# library to obtain data
library(gapminder) 

# library for data manipulation
library(dplyr)

# library for better plotting
library(ggplot2)



# LINE PLOT
# Summarizing the mean gdpPercap by year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(meanGdpPercap = mean(gdpPercap))

# Creating a line plot showing the change in meanGdpPercap over time
ggplot(by_year, aes(x = year, y = meanGdpPercap)) +
  geom_line() +
  expand_limits(y = 0)

# Summarizing the median gdpPercap by year & continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(meanGdpPercap = mean(gdpPercap))

# Creating a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(x = year, y = meanGdpPercap, color = continent)) +
  geom_line() +
  expand_limits(y = 0)




# BAR PLOT
# Summarizing the mean gdpPercap by year and continent in 1997
by_continent <- gapminder %>%
  filter(year == 1997) %>%
  group_by(continent) %>%
  summarize(meanGdpPercap = mean(gdpPercap))

# Creating a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x = continent, y = meanGdpPercap)) +
  geom_col()

# Filtering for observations in the Asia in 1997
asia_1997 <- gapminder %>%
  filter(year == 1997, continent == "Asia")

# Creating a bar plot of gdpPercap by country
ggplot(asia_1997, aes(x = country, y = gdpPercap)) +
  geom_col() + 
  theme(axis.text.x = element_text(angle = 60, hjust = 1))





# HISTOGRAM
gapminder_1997 <- gapminder %>%
  filter(year == 1997)

# Creating a histogram of population (pop)
ggplot(gapminder_1997, aes(x = pop)) +
  geom_histogram()

# Creating a histogram of population (pop), with x on a log scale
ggplot(gapminder_1997, aes(x = pop)) +
  geom_histogram() +
  scale_x_log10()




# BOX PLOT
gapminder_1997 <- gapminder %>%
  filter(year == 1997)

# Creating a boxplot comparing gdpPercap among continents
ggplot(gapminder_1997, aes(y = gdpPercap, x = continent)) +
  geom_boxplot() +
  scale_y_log10()