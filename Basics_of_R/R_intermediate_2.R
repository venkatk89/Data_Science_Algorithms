# CONTROL FLOW

# me, other_199, and previous_4 are available in your workspace

# Merge me and other_199: my_class
my_class <- c(me, other_199)

# cbind() my_class and previous_4: last_5
last_5 <- cbind(my_class, previous_4)

# Name last_5 appropriately
nms <- paste0("year_", 1:5)
colnames(last_5) <- nms

# Build histogram of my_class
hist(my_class)

# Generate summary of last_5
summary(last_5)

# Build boxplot of last_5
boxplot(last_5)

# Is your grade equal to 72?
me == 72

# Which grades in your class are higher than 75?
my_class > 75

# Which grades in the last 5 years are below or equal to 64?
last_5 <= 64

# How many grades in your class are higher than 75?
sum(my_class > 75)

# How many students in your class scored strictly higher than you?
sum(my_class > me)

# What's the proportion of grades below or equal to 64 in the last 5 years?
sum(last_5 <= 64) / sum(last_5 > 0)

# Is your grade greater than 87 and smaller than or equal to 89?
me > 87 & me <= 89

# Which grades in your class are below 60 or above 90?
my_class > 90 | my_class < 60

# What's the proportion of grades in your class that is average?
sum(my_class >= 70 & my_class <= 85) / sum(my_class > 0)

# How many students in the last 5 years had a grade of 80 or 90?
sum(last_5 ==80 | last_5 == 90)

#Note that the else part should come on the same line as the closing bracket of the if statement! If you don't do this, R will not understand your code!

# Define n_smart
n_smart <- sum(my_class >= 80)

# Code the if-else construct
if(n_smart > 50){
  print("smart class")
}else{
  print("rather average")
}

# Define prop_less
prop_less <- sum(my_class < me) / sum(my_class > 0)

# Code the control construct
if(prop_less > 0.9){
  print("you're among the best 10 percent")
}else if(prop_less > 0.8){
  print("you're among the best 20 percent")
}else{
  print("need more analysis")
}

# Create top_grades
top_grades <- my_class[which(my_class >= 85)]

# Create worst_grades
worst_grades <- my_class[which(my_class < 65)]

# Write conditional statement
if(length(top_grades) > length(worst_grades)){
  print("top grades prevail")
}

#############################################################################################################################################

# LOOPS

# Print the structure of logs
str(logs)

# Use list subsetting to print the details part of 11th logs entry
logs[[11]]$details

# Print the class of the timestamp component of the first entry
class(logs[[1]]$timestamp)

# Initialize the iterator i to be 1
i <- 1

# Code the while loop
while ( logs[[i]]$success == TRUE) {
  print(i)
  i <- i+1
}

# logs is available in your workspace

# Initialize i and found
i <- 1
found <- FALSE

# Code the while loop
while (found == FALSE) {
  if (logs[[i]]$success == FALSE && logs[[i]]$details$location == "waste") {
    print("found")
    found <- TRUE
  } else {
    print("still looking")
    i <- i+1
  }
}

# Code a for loop that prints the timestamp of each log
for (log in logs) {
  print(log$timestamp)
}

# Finish the for loop: add date element for each entry
for (i in 1:length(logs)) {
  logs[[i]]$date <- as.Date(logs[[i]]$timestamp) 
}

# Print first 6 elements in logs
head(logs)

# Intialize empty list: failures
failures <- list()

# Finish the for loop: add each failure to failures
for (log in logs) {
  if (log$success == FALSE) {
    failures <- c(failures, list(log))
  }
}

# Display the structure of failures
str(failures)

######################################################################################################################################################

# FUNCTIONS

# Call max() on timestamps
max(timestamps)

# What is the date of the latest timestamp?
as.Date(max(timestamps))

# logs is available in your workspace

# Add default value for property argument
extract_info <- function(x, property = "success") {
  info <- c()
  for (log in x) {
    info <- c(info, log[[property]])
  }
  return(info)
}

# Call extract_info() on logs, don't specify property
extract_info(logs)

# Call extract_info() on logs, set property to "timestamp"
extract_info(logs, 'timestamp')

# logs is available in your workspace

# Add default value for property argument
extract_info <- function(x, property = "success") {
  info <- c()
  for (log in x) {
    info <- c(info, log[[property]])
  }
  return(info)
}

# Call extract_info() on logs, don't specify property
extract_info(logs)

# Call extract_info() on logs, set property to "timestamp"
extract_info(logs, 'timestamp')



# Adapt extract_info():
# - add argument with default value
# - change function body
extract_info <- function(x, property = "success", include_all = TRUE) {
  info <- c()
  for (log in x) {
    
    # add if construct around the line below
    if(include_all || !log$succes){
      info <- c(info, log[[property]])
    }
    
    
  }
  return(info)
}

# Call extract_info() on logs, no additional arguments
extract_info(logs)

# Call extract_info() on logs, set include_all to FALSE
extract_info(logs, include_all = FALSE)

# logs is available in your workspace

# Defition of the extract_info() function
extract_info <- function(x, property = "success", include_all = TRUE) {
  info <- c()
  for (log in x) {
    if (include_all || !log$success) {
      info <- c(info, log[[property]])
    }
  }
  return(info)
}

# Generate vector of messages
extract_info(logs, property = c("details", "message"))

# Generate vector of locations for failed log entries
extract_info(logs, property =  c("details", "location"), include_all = FALSE)

# logs is available in your workspace

# Write the function compute_fail_pct
compute_fail_pct <- function(x){
  count <- 0
  for(log in x){
    if(!log$success)
      count <- count + 1
  }
  return(100*count / length(x))
}


# Call compute_fail_pct() on logs
compute_fail_pct(logs)



####################################################################################################################################################

# APPLY

# Call length() on each element of logs
lapply(logs, length)

# Call class() on each element of logs
lapply(logs, class)

# Define get_timestamp()
get_timestamp <- function(x) {
  return(x$timestamp)
}

# Apply get_timestamp() over all elements in logs
lapply(logs, get_timestamp)

# Alternate
# Have lapply() use an anonymous function
lapply(logs, function(x) {x$timestamp} )


# Another Alternate
#you can assign `[[` to the FUN argument to lapply()
# Replace the anonymous function with `[[` 
lapply(logs, '[[', a = 'timestamp' )


# SAPPLY

# logs is available in your workspace

# Call length() on each element of logs using sapply()
sapply(logs, length)

# Definition of get_timestamp
get_timestamp <- function(x) {
  x$timestamp
}

# Get vector of log entries' timestamps
sapply(logs, get_timestamp)

# Implement function get_failure_loc
get_failure_loc <- function(x) {
  if (x$success == TRUE) {
    return(NULL)
  } else {
    return(x$details$location)
  }
}

# Use sapply() to call get_failure_loc on logs
sapply(logs, get_failure_loc)   # output is a list and not a vector

# vapply

# Convert the sapply call to vapply
vapply(logs, length, integer(1))

# Convert the sapply call to vapply
vapply(logs, `[[`, logical(1), "success")

# Return vector with uppercase version of message elements in log entries
toupper(vapply(logs, function(log){return(log$details$message)}, character(1)))

##################################################################################################################################3

#UTILITIES

#titanic

# Import titanic from csv
titanic <- read.csv("titanic.csv")

# Call dim on titanic
dim(titanic)

# Generate histogram of Age column
hist(titanic$Age)

# Print out total value of fares
print(sum(titanic$Fare))

# Print out proportion of passengers that survived
sum(titanic$Survived) / nrow(titanic)

# Extract the name column from titanic
pass_names <- titanic$Name

# Create the logical vectror is_man
is_man <- grepl(", Mr\\.", pass_names)

# Count the number of men
sum(is_man)

# Count number of men based on gender
sum(titanic$Sex == "male")

# Create titles
titles <- gsub("^.*, (.*?)\\..*$", "\\1", pass_names)

#With ^ and $ we signify the start and end of the string. Next, we have two .* parts in there: wildcards for the last name and first names. 
#With , (.*?)\\. we use a similar pattern as before, but the parentheses allow us to re-use whatever is matched inside the parentheses in our replacement.

# Call unique() on titles
unique(titles)

titles <- paste(",", c("Mr\\.", "Master", "Don", "Rev", "Dr\\.", "Major", "Sir", "Col", "Capt", "Jonkheer"))

# Finish the vapply() command
hits <- vapply(titles,
               FUN = grepl,
               FUN.VALUE = logical(length(pass_names)),
               pass_names)

# Calculate the sum() of hits
sum(hits)

# Count number of men based on gender
sum(titanic$Sex == "male")

# pass_names is available in your workspace

convert_name <- function(name) {
  # women: take name from inside parentheses
  if (grepl("\\(.*?\\)", name)) {
    gsub("^.*?\\((.*?)\\)$", "\\1", name)
    # men: take name before comma and after title
  } else {
    # Finish the gsub() function
    gsub("^(.*?),\\s[a-zA-Z\\.]*?\\s(.*?)$", "\\2 \\1", name)
  }
}

# Call convert_name on name
clean_pass_names <- vapply(pass_names, FUN = convert_name,
                           FUN.VALUE = character(1), USE.NAMES = FALSE)

# Print out clean_pass_names
clean_pass_names

# titanic, dob1 and dob2 are preloaded

# Have a look at head() of dob1 and dob2
head(dob1)
head(dob2)

# titanic, dob1 and dob2 are preloaded
dob1d <- as.Date(dob1)
dob2d <- as.Date(dob2, format = "%B %d, %Y")
birth_dates <- c(dob1d, dob2d)
disaster_date <- as.Date("1912-04-15")

# Add birth_dates to titanic (column Birth)
titanic$Birth <- birth_dates

# Create subset: survivors
survivors <- subset(titanic, Survived == 1)

# Calculate average age of survivors
mean((disaster_date - survivors$Birth), na.rm = TRUE)










