
# CONDITIONALS AND CONTROL FLOW

# TRUE == 1

#for string comparison, R determines the greater than relationship based on alphabetical order.

# Comparison of character strings
"raining" <= "raining dogs"    # output is true

# Comparison of logicals
TRUE > FALSE    # output is true

linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Popular days
linkedin > 15

# Quiet days
linkedin <= 5

# LinkedIn more popular than Facebook
linkedin > facebook

#matrix
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)

# When does views equal 13?
views == 13

# When is views less than or equal to 14?
views <= 14

linkedin <- c(16, 9, 13, 5, 2, 17, 14)
last <- tail(linkedin, 1)

# Is last under 5 or above 10?
last < 5 | last >10

# Is last between 15 (exclusive) and 20 (inclusive)?
last > 15 & last <= 20
# linkedin exceeds 10 but facebook below 10
facebook < 10 & linkedin > 10 

# When were one or both visited at least 12 times?
linkedin >= 12 | facebook >= 12

# When is views between 11 (exclusive) and 14 (inclusive)?
views > 11 & views <= 14

# li_df is pre-loaded in your workspace

# Select the second column, named day2, from li_df: second
second <- li_df$day2

# Build a logical vector, TRUE if value in second is extreme: extremes
extremes <- second > 25 | second < 5

# Count the number of TRUEs in extremes
sum <- sum(extremes)

# Solve it with a one-liner
sum

# conditional statements

# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else{
  print("Unknown medium")
}



# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
}else{
  print("Try to be more visible!")
}

#Again, It's important that the else if keywords comes on the same line as the closing bracket of the previous part of the control construct

# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else if (medium == "Facebook") {
  # Add code to print correct string when condition is TRUE
  print("Showing Facebook information")
} else {
  print("Unknown medium")
}

# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
} else if (num_views <= 15 & num_views > 10) {
  # Add code to print correct string when condition is TRUE
  print("Your number of views is average")
} else {
  print("Try to be more visible!")
}

##############################################################################################################################3

# LOOPS

# while loop

# Initialize the speed variable
speed <- 88

while (speed > 30) {
  print(paste("Your speed is", speed))
  
  # Break the while loop when speed exceeds 80
  if ( speed > 80) {
    break
  }
  
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

# for loop

# loop over vector
# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Loop version 1
for(l in linkedin){
  print(l)
}



# Loop version 2
for(a in c(1:length(linkedin))){
  print(linkedin[a])
}

# The tic-tac-toe matrix ttt has already been defined for you

# define the double for loop
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row",i,"and column",j,"the board contains",ttt[i,j]))
  }
}

# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Extend the for loop
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  
  # Add if statement with break
  if(li > 16){
    print("This is ridiculous, I'm outta here!")
    break
  }
  
  # Add if statement with next
  if(li < 5){
    print("This is too embarrassing!")
    next
  }
  
  print(li)
}

#########################################################################################################################3

# FUNCTIONS
#R passes arguments by value: an R function cannot change the variable that you input to that function

# Create a function pow_two()
pow_two <- function(a){
  return(a*a)
}


# Use the function
pow_two(12)

# Create a function sum_abs()
sum_abs <- function(a,b){
  abs(a) + abs(b)
}


# Use the function
sum_abs(-2, 3)

# function with no arguments
# Define the function hello()
hello <-function(){
  print("Hi there!")
  return(TRUE)
}



# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# The interpret() can be used inside interpret_all()
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Define the interpret_all() function
# views: vector with data to interpret
# return_sum: return total number of views on popular days?
interpret_all <- function(views, return_sum = TRUE) {
  count <- 0
  
  for (v in views) {
    count <- count + interpret(v)
  }
  
  if (return_sum) {
    return(count)
  } else {
    return(NULL)
  }
}

# Call the interpret_all() function on both linkedin and facebook
interpret_all(linkedin)
interpret_all(facebook)

################################################################################################################################################

# APPLY

# lapply

# The vector pioneers has already been created for you
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")

# Split names from birth year
split_math <- strsplit(pioneers, split = ":")

# Convert to lowercase strings: split_low
split_low <- lapply(split_math, tolower)     #!!!! no paranthesis after tolower !!!!#

# Write function select_first()
select_first <- function(x) {
  x[1]
}

# Apply select_first() over split_low: names
names <- lapply(split_low, select_first)

# names <- lapply(split_low, function(x){x[1]}) is also a valid way to execute this



# Generic select function
select_el <- function(x, index) {
  x[index]
}

# Use lapply() twice on split_low: names and years
names <- lapply(split_low, select_el, index =1)

years <- lapply(split_low, select_el, index =2)

# sapply
# temp has already been defined in the workspace

# Finish function definition of extremes_avg
extremes_avg <- function(x) {
  ( min(x) + max(x) ) / 2
}

# Apply extremes_avg() over temp using sapply()
sapply(temp, extremes_avg)

# Apply extremes_avg() over temp using lapply()
lapply(temp, extremes_avg)

# vapply --- the best among these according to me

# temp is already available in the workspace

# Definition of the basics() function
basics <- function(x) {
  c(min = min(x), mean = mean(x), median = median(x), max = max(x))
}

# Fix the error:
vapply(temp, basics, numeric(4))

# temp is already defined in the workspace

# Convert to vapply() expression
vapply(temp, max, numeric(1))

# Convert to vapply() expression
vapply(temp, function(x, y) { mean(x) > y }, y = 5, logical(1))


####################################################################################################################################################

# UTILITIES

# The errors vector has already been defined for you
errors <- c(1.9, -2.6, 4.0, -9.5, -3.4, 7.3)

# Sum of absolute rounded values of errors
sum(round(abs(errors)))

#
#seq(): Generate sequences, by specifying the from, to, and by arguments.
#rep(): Replicate elements of vectors and lists.
#sort(): Sort a vector in ascending order. Works on numerics, but also on character strings and logicals.
#rev(): Reverse the elements in a data structures for which reversal is defined.
#str(): Display the structure of any R object.
#append(): Merge vectors or lists.
#is.*(): Check for the class of an R object.
#as.*(): Convert an R object from one class to another.
#unlist(): Flatten (possibly embedded) lists to produce a vector.
#

# Create first sequence: seq1
seq1 <- seq(1, 500, by = 3)

# Create second sequence: seq2
seq2 <- seq(1200, 900, by = -7)

# Calculate total sum of the sequences
sum(seq1) + sum(seq2)

# The linkedin and facebook lists have already been created for you
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)

# Convert linkedin and facebook to a vector: li_vec and fb_vec
li_vec <- unlist(linkedin)
fb_vec <- unlist(facebook)

# Append fb_vec to li_vec: social_vec
social_vec <- append(li_vec, fb_vec)

# Sort social_vec
sort(social_vec, decreasing = TRUE)

###########

# grep() and grepl()

#grepl(), which returns TRUE when a pattern is found in the corresponding character string.
#grep(), which returns a vector of indices of the character strings that contains the pattern.

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl('edu', emails )

# Use grep() to match for "edu", save result to hits
hits <- grep('edu', emails)

# Subset emails using hits
emails[hits]

# Use grepl() to match for "edu"
grepl('@.*\\.edu$', emails )

# Use grep() to match for "edu", save result to hits
hits <- grep('@.*\\.edu$', emails)

# Subset emails using hits
emails[hits]

# sub() and gsub()

# Use sub() to convert the email domains to datacamp.edu
sub('@.*\\.edu$', '@datacamp.edu', emails)


# @, because a valid email must contain an at-sign.
# .*, which matches any character (.) zero or more times (*). Both the dot and the asterisk are metacharacters. You can use them to match any character between the at-sign and the ".edu" portion of an email address.
# \\.edu$, to match the ".edu" part of the email at the end of the string. The \\ part escapes the dot: it tells R that you want to use the . as an actual character.

# .*: A usual suspect! It can be read as "any character that is matched zero or more times".
# \\s: Match a space. The "s" is normally a character, escaping it (\\) makes it a metacharacter.
# [0-9]+: Match the numbers 0 to 9, at least once (+).
# ([0-9]+): The parentheses are used to make parts of the matching string available to define the replacement. The \\1 in the replacement argument of sub() gets set to the string that is captured by the regular expression [0-9]+.

#################

# Date and Time

# Get the current date: today
today <- Sys.Date()

# See what today looks like under the hood
unclass(today)

# Get the current time: now
now <- Sys.time()

# See what now looks like under the hood
unclass(now)

# Definition of character strings representing dates
str1 <- "May 23, '96"
str2 <- "2012-03-15"
str3 <- "30/January/2006"

# Convert the strings to dates: date1, date2, date3
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2, format = "%Y-%m-%d")
date3 <- as.Date(str3, format = "%d/%B/%Y")

# Convert dates to formatted strings
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")

# Definition of character strings representing times
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"

# Convert the strings to POSIXct objects: time1, time2
time1 <- as.POSIXct(str1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2, format = "%Y-%m-%d %T")

# Convert times to formatted strings
format(time1, "%M")
format(time2, "%I:%M%p")



# day1, day2, day3, day4 and day5 are already available in the workspace

# Difference between last and first pizza day
day5 - day1

# Create vector pizza
pizza <- c(day1, day2, day3, day4, day5)

# Create differences between consecutive pizza days: day_diff
day_diff <- diff(pizza)

# Average period between two consecutive pizza days
mean(day_diff)



# login and logout are already defined in the workspace
# Calculate the difference between login and logout: time_online
time_online <- logout - login

# Inspect the variable time_online
time_online

# Calculate the total time online
sum(time_online)

# Calculate the average time online
mean(time_online)

# Convert astro to vector of Date objects: astro_dates
astro_dates <- as.Date(astro, "%d-%b-%Y")

# Convert meteo to vector of Date objects: meteo_dates
meteo_dates <- as.Date(meteo, "%B %d, %y")

# Calculate the maximum absolute difference between astro_dates and meteo_dates
max(abs(astro_dates - meteo_dates))







