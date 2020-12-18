library(sparklyr)

spark_install(version = "2.1.0")

sc <- spark_connect(master = "local")

library(dplyr)
library(ggplot2)
library(DBI)




iris_tbl <- copy_to(sc, iris)
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")

#shows the number of tibbles in the spark connection
src_tbls(sc)

# filter by departure delay and print the first few records
flights_tbl %>% filter(dep_delay == 2)

#class(flights_tbl)




# data visualization
delay <- flights_tbl %>% 
  group_by(tailnum) %>%
  summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
  filter(count > 20, dist < 2000, !is.na(delay)) %>%
  collect

# collect: will retrieve data into a local tibble: since we are using clusters and Spark SQL and all




# plot delays

ggplot(delay, aes(dist, delay)) +
  geom_point(aes(col = count)) +
  geom_smooth(color = 'black', fill = 'dark green') +
  theme_classic() +
  scale_size_area(max_size = 2) +
  scale_color_gradient2(low = 'white', high = 'red', mid = "light yellow")


iris_data <- iris



# data manipulation

batting_tbl %>%
  select(playerID, yearID, teamID, G, AB:H) %>%
  arrange(playerID, yearID, teamID) %>%
  group_by(playerID) %>%
  filter(min_rank(desc(H)) <= 2 & H > 0)


# using sql queries in sparf dataframe
iris_preview <- dbGetQuery(sc, "SELECT * FROM iris LIMIT 10")
iris_preview

dbGetQuery(sc, "SELECT * FROM flights LIMIT 15")
# sc is the connection to spark. it is kinda used as the schema in which the tables are present


# machine learning with SPARK

# copy mtcars into spark
mtcars_tbl <- copy_to(sc, mtcars)

src_tbls(sc)

# transform our data set, and then partition into 'training', 'test'
partitions <- mtcars_tbl %>%
  filter(hp >= 100) %>%
  mutate(cyl8 = cyl == 8) %>%
  sdf_partition(training = 0.5, test = 0.5, seed = 1099)

# fit a linear model to the training dataset
fit <- partitions$training %>%
  ml_linear_regression(response = "mpg", features = c("wt", "cyl"))
fit


summary(fit)
