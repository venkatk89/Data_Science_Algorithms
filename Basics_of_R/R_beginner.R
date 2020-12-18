# INTRO TO BASICS

# Declare variables of different types
my_numeric <- 42
my_character <- "universe"
my_logical <- FALSE 

# Check class of my_numeric
class(my_numeric)

# Check class of my_character
class(my_character)

# Check class of my_logical
class(my_logical)



####################################################

# VECTORS

#You can give a name to the elements of a vector with the names() function.
# Poker winnings from Monday to Friday
poker_vector <- c(140, -50, 20, -120, 240)

# Roulette winnings from Monday to Friday
roulette_vector <- c(-24, -50, 100, -350, 10)

# The variable days_vector
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

# Assign the names of the day to roulette_vector and poker_vector
names(poker_vector) <-   days_vector
names(roulette_vector) <- days_vector

# Assign to total_daily how much you won/lost on each day
total_daily <- poker_vector + roulette_vector

# sum(). It calculates the sum of all elements of a vector.
# Total winnings with poker
total_poker <- sum(poker_vector)

# Total winnings with roulette
total_roulette <-  sum(roulette_vector)

# Total winnings overall
total_week <- total_poker + total_roulette

# Print out total_week
total_week

# Check if you realized higher total gains in poker than in roulette 
total_poker > total_roulette # prints true

# Select poker results for Monday, Tuesday and Wednesday
poker_start <-  poker_vector[c("Monday", "Tuesday", "Wednesday")]

# Calculate the average of the elements in poker_start
mean(poker_start)

# Which days did you make money on poker?
selection_vector <- (poker_vector > 0)

# Print out selection_vector
selection_vector

# Select from poker_vector these days
poker_winning_days <- poker_vector[selection_vector]
#R knows what to do when you pass a logical vector in square brackets: it will only select the elements that correspond to TRUE in selection_vector.

#############################################################################

# MATRIX

# Construct a matrix with 3 rows that contain the numbers 1 up to 9
matrix(1:9, byrow =TRUE, nrow = 3)

# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

# Create box_office
# combine all values into one vector
box_office <- c(new_hope, empire_strikes, return_jedi)

# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, byrow = TRUE, nrow = 3)

# Vectors region and titles, used for naming
region <- c("US", "non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")

# Name the columns with region
rownames(star_wars_matrix) <- titles

# Name the rows with titles
colnames(star_wars_matrix) <- region

# Print out star_wars_matrix
star_wars_matrix

# Calculate worldwide box office figures
worldwide_vector <- rowSums(star_wars_matrix)

# Bind the new variable worldwide_vector as a column to star_wars_matrix
all_wars_matrix <- cbind(star_wars_matrix, worldwide_vector)

# all_wars_matrix is available in your workspace
all_wars_matrix

# Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]

# Average non-US revenue
mean(non_us_all)

# Select the non-US revenue for first two movies
non_us_some <- non_us_all[1:2]

# Average non-US revenue for first two movies
mean(non_us_some)

# all_wars_matrix and ticket_prices_matrix are available in your workspace
all_wars_matrix
ticket_prices_matrix

# Estimated number of visitors
visitors <- all_wars_matrix / ticket_prices_matrix

# US visitors
us_visitors <- visitors[,1]

# Average number of US visitors
mean(us_visitors)

################################################################

# FACTORS

# nominal factors
# Build factor_survey_vector with clean levels
survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector)
levels(factor_survey_vector) <- c("Female", "Male")

# Male
male <- factor_survey_vector[1]

# Female
female <- factor_survey_vector[2]

# Battle of the sexes: Male 'larger' than female?
male > female # NA is outputted as nominal factors can't be compared


# ordered factors

# Create speed_vector
speed_vector <- c("medium", "slow", "slow", "medium", "fast")

# Convert speed_vector to ordered factor vector
factor_speed_vector <- factor(speed_vector, ordered = TRUE, levels = c("slow", "medium", "fast"))

# Print factor_speed_vector
factor_speed_vector
summary(factor_speed_vector)

# Factor value for second data analyst
da2 <- factor_speed_vector[2]

# Factor value for fifth data analyst
da5 <- factor_speed_vector[5]

# Is data analyst 2 faster than data analyst 5?
da2 > da5 # false is the output as ordered factors can be compared

###############################################################################

#  DATAFRAMES

head(mtcars) # top elements to get a overview

str(mtcars)  # to get the structure or to get a overview

# Definition of vectors
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", 
          "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)

# Create a data frame from the vectors
planets_df <- data.frame(name, type, diameter, rotation, rings)

# Print out diameter of Mercury (row 1, column 3)
planets_df[1,3]

# Print out data for Mars (entire fourth row)
planets_df[4,]

# Select first 5 values of diameter column
planets_df[1:5, "diameter"]

# Select the rings variable from planets_df
rings_vector <- planets_df$rings

# Adapt the code to select all columns for planets with rings
planets_df[rings_vector, "name"]

# Select planets with diameter < 1
subset(planets_df, subset = diameter < 1)

# Use order() to create positions
positions <-  order(planets_df$diameter)

# Use positions to sort planets_df
planets_df[positions,]

#
#Vectors (one dimensional array): can hold numeric, character or logical values. The elements in a vector all have the same data type.

#Matrices (two dimensional array): can hold numeric, character or logical values. The elements in a matrix all have the same data type.

#Data frames (two-dimensional objects): can hold numeric, character or logical values. Within a column all elements have the same data type,
#but different columns can be of different data type.

#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. These objects can be matrices, vectors, data frames, even other lists, etc.
#It is not even required that these objects are related to each other in any way.
#

#####################################################################################################################

#LISTS

# Vector with numerics from 1 up to 10
my_vector <- 1:10 

# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)

# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]

# Adapt list() call to give the components names
my_list <- list(my_vector, my_matrix, my_df)
names(my_list) <- c("vec", "mat", "df")
# Print out my_list
my_list

# The variables mov, act and rev are available

# Finish the code to build shining_list
shining_list <- list(moviename = mov, actors = act, reviews = rev)

# Print out the vector representing the actors
shining_list$actors

# Print the second element of the vector representing the actors
shining_list[[2]][2]

# We forgot something; add the year to shining_list
shining_list_full <- c(shining_list, year = 1980)

# Have a look at shining_list_full
str(shining_list_full)


############################################################################################################################################################

# END OF CHAPTER

