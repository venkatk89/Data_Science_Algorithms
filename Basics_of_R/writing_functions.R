# Define ratio() function
ratio <- function(x, y) {
  return(x / y)
}

# Call ratio() with arguments 3 and 4
ratio(3,4)

# Rewrite the call to follow best practices
mean(c(1:9, NA),trim = 0.1,na.rm = TRUE)

# 2nd element in tricky_list
typeof(tricky_list[[2]])

# Element called x in tricky_list
typeof(tricky_list[["x"]])

# 2nd element inside the element called x in tricky_list
typeof(tricky_list[['x']][[2]])

# Guess where the regression model is stored
names(tricky_list)

# Use names() and str() on the model element
names(tricky_list$model)
str(tricky_list$model)

# Subset the coefficients element
tricky_list$model$coefficients

# Subset the wt element
tricky_list$model$coefficients[["wt"]]

# Replace the 1:ncol(df) sequence
for (i in seq_along(df)) {
  print(median(df[[i]]))
}

# Create new double vector: output
output <- vector("double", ncol(df))

# Alter the loop
for (i in seq_along(df)) {
  output[i] <- median(df[[i]])
}

# Print output
print(output)

########################################################################################33

# Define example vectors x and y
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)

# Count how many elements are missing in both x and y
sum(is.na(x) & is.na(y))

# Turn this snippet into a function: both_na()
both_na <- function(x , y){
  sum(is.na(x) & is.na(y))
}

replace_missings <- function(x, replacement) {
  is_miss <- is.na(x)
  x[is_miss] <- replacement
  
  # Rewrite to use message()
  message(sum(is_miss)," missings replaced by the value ", replacement)
  x
}

# Check your new function by running on df$z
df$z <- replace_missings(df$z, 0)

######################################################################################################

# Initialize output vector
output <- vector("double", ncol(df))  

# Fill in the body of the for loop
for (i in seq_along(df)) {            
  output[i] <- median(df[[i]])
}

# View the result
output


# Function
col_median <- function(df){
  output <- vector("double", ncol(df))  
  for (i in seq_along(df)) {            
    output[[i]] <- median(df[[i]])      
  }
  return(output)
}

# function with function as parameter
col_summary <- function(df, fun) {
  output <- vector("numeric", length(df))
  for (i in seq_along(df)) {
    output[[i]] <- fun(df[[i]])
  }
  output
}

col_median(df)
col_summary(df, fun = median)  # same results

# Find the column IQRs using col_summary()
col_summary(df, fun = IQR)




# Load the purrr package
library(purrr)

# Use map_dbl() to find column means
map_dbl(df, mean)

# Use map_dbl() to column medians
map_dbl(df, median)

# Find the mean of each column
map_dbl(planes, mean)

# Find the mean of each column, excluding missing values
map_dbl(planes, mean, na.rm = TRUE)

# Find the 5th percentile of each column, excluding missing values
map_dbl(planes, quantile, probs = 0.05, na.rm = TRUE)

# Find the columns that are numeric
map_lgl(df3, is.numeric)

# Find the type of each column
map_chr(df3, typeof)

# Find a summary of each column
map(df3, summary)

# Examine the structure of cyl
str(cyl)

# Extract the first element into four_cyls
four_cyls <- cyl[[1]]

# Fit a linear regression of mpg on wt using four_cyls
lm(four_cyls$mpg ~ four_cyls$wt)

# Rewrite to call an anonymous function
map(cyl, function(df) lm(mpg ~ wt, data = df))

# Rewrite to use the formula shortcut instead
map(cyl, ~lm(mpg ~ wt, data = .))

# Save the result from the previous exercise to the variable models
models <- map(cyl, ~ lm(mpg ~ wt, data = .))

# Use map and coef to get the coefficients for each model: coefs
coefs <- map(models, coef)

# Use string shortcut to extract the wt coefficient 
map(coefs, "wt")

# use map_dbl with the numeric shortcut to pull out the second element
map_dbl(coefs, 2)

# Define models (don't change)
models <- mtcars %>% 
  split(mtcars$cyl) %>%
  map(~ lm(mpg ~ wt, data = .))

# Rewrite to be a single command using pipes
models %>%
  map(summary) %>%
  map_dbl("r.squared")

###########################################################################################
# Create safe_readLines() by passing readLines() to safely()
safe_readLines <- safely(readLines)

# Call safe_readLines() on "http://example.org"
safe_readLines("http://example.org")

# Call safe_readLines() on "http://asdfasdasdkfjlda"
safe_readLines("http://asdfasdasdkfjlda")

# Define safe_readLines()
safe_readLines <- safely(readLines)

# Use the safe_readLines() function with map(): html
html <- map(urls, safe_readLines)

# Call str() on html
str(html)

# Extract the result from one of the successful elements
html$example[["result"]]

# Extract the error from the element that was unsuccessful
html$asdf[["error"]]

# Define safe_readLines() and html
safe_readLines <- safely(readLines)
html <- map(urls, safe_readLines)

# Examine the structure of transpose(html)
str(transpose(html))

# Extract the results: res
res <- transpose(html)[["result"]]

# Extract the errors: errs
errs <- transpose(html)[["error"]]

# Initialize some objects
safe_readLines <- safely(readLines)
html <- map(urls, safe_readLines)
res <- transpose(html)[["result"]]
errs <- transpose(html)[["error"]]

# Create a logical vector is_ok
is_ok <- map_lgl(errs, is_null)

# Extract the successful results
res[is_ok]

# Find the URLs that were unsuccessful
urls[!is_ok]


# Use map_dbl() to find column standard deviations
map_dbl(df, sd)


##


# Create a list n containing the values: 5, 10, and 20
n <- list(5,10,20)

# Call map() on n with rnorm() to simulate three samples
map(n, rnorm)

# Create a list mu containing the values: 1, 5, and 10
mu <- list(1, 5, 10)

# Edit to call map2() on n and mu with rnorm() to simulate three samples
map2(n, mu, rnorm)

# Create a sd list with the values: 0.1, 1 and 0.1
sd <- list(0.1, 1, 0.1)

# Edit this call to pmap() to iterate over the sd list as well
pmap(list(n, mu, sd), rnorm)

# Define list of functions
f <- list("rnorm", "runif", "rexp")

# Parameter list for rnorm()
rnorm_params <- list(mean = 10)

# Add a min element with value 0 and max element with value 5
runif_params <- list(min = 0, max = 5)

# Add a rate element with value 5
rexp_params <- list(rate = 5)

# Define params for each function
params <- list(
  rnorm_params,
  runif_params,
  rexp_params
)

# Call invoke_map() on f supplying params as the second argument
invoke_map(f, params, n = 5)

# Assign the simulated samples to sims
sims <- invoke_map(f, params, n = 50)

# Use walk() to make a histogram of each element in sims
walk(sims, hist)

breaks_list <- list(
  Normal = seq(6,16,0.5),
  Uniform = seq(0,5,0.25),
  Exp = seq(0,1.5,0.1)
)

# Use walk2() to make histograms with the right breaks
walk2(sims, breaks_list, hist)

# Turn this snippet into find_breaks()
find_breaks <- function(x){
  rng <- range(x, na.rm = TRUE)
  seq(rng[1], rng[2], length.out = 30)
}

# Call find_breaks() on sims[[1]]
find_breaks(sims[[1]])

# Use map() to iterate find_breaks() over sims: nice_breaks
nice_breaks <- map(sims, find_breaks)

# Use nice_breaks as the second argument to walk2()
walk2(sims, nice_breaks, hist)

# Increase sample size to 1000
sims <- invoke_map(f, params, n = 1000)

# Compute nice_breaks (don't change this)
nice_breaks <- map(sims, find_breaks)

# Create a vector nice_titles
nice_titles <- c("Normal(10, 1)", "Uniform(0, 5)", "Exp(5)")

# Use pwalk() instead of walk2()
pwalk(list(x = sims, breaks = nice_breaks,main =  nice_titles), hist, xlab = "")

# Pipe this along to map(), using summary() as .f
sims %>%
  walk(hist) %>%
  map(summary)

###########################################################################################

# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)

both_na <- function(x, y) {
  # Add stopifnot() to check length of x and y
  stopifnot(length(x) == length(y))
  
  sum(is.na(x) & is.na(y))
}

# Call both_na() on x and y
both_na(x, y)

# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)

both_na <- function(x, y) {
  # Replace condition with logical
  if (length(x) != length(y)) {
    # Replace "Error" with better message
    stop("x and y must have the same length", call. = FALSE)
  }  
  
  sum(is.na(x) & is.na(y))
}

col_classes <- function(df) {
  # Assign list output to class_list
  class_list <-  map(df, class)
  
  # Use map_chr() to extract first element in class_list
  map_chr(class_list, 1)
}

# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()

col_classes <- function(df) {
  class_list <- map(df, class)
  
  # Add a check that no element of class_list has length > 1
  if (any(map_dbl(class_list, length) > 1)) {
    stop("Some columns have more than one class", call. = FALSE)
  }
  
  # Use flatten_chr() to return a character vector
  flatten_chr(class_list)
}

# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()

big_x <- function(df, threshold) {
  dplyr::filter(df, x > threshold)
}

big_x(diamonds_sub, 7)

# Remove the x column from diamonds
diamonds_sub$x <- NULL

# Create variable x with value 1
x <- 1

# Use big_x() to find rows in diamonds_sub where x > 7
big_x(diamonds_sub, 7)

# Create a threshold column with value 100
diamonds_sub$threshold <- 100

# Use big_x() to find rows in diamonds_sub where x > 7
big_x(diamonds_sub, 7)

big_x <- function(df, threshold) {
  # Write a check for x not being in df
  if(!"x" %in% names(df)){
    stop("df must contain variable called x", call. = FALSE)
  }
  
  # Write a check for threshold being in df
  if("threshold" %in% names(df)){
    stop("df must not contain variable called threshold", call. = FALSE)
  }
  
  dplyr::filter(df, x > threshold)
}

# Read in the swimming_pools.csv to pools
pools <- read.csv("swimming_pools.csv")

# Examine the structure of pools
str(pools)

# Change the global stringsAsFactors option to FALSE
options("stringsAsFactors" = FALSE)

# Read in the swimming_pools.csv to pools2
pools2 <- read.csv("swimming_pools.csv")

# Examine the structure of pools2
str(pools2)

# Fit a regression model
fit <- lm(mpg ~ wt, data = mtcars)

# Look at the summary of the model
summary(fit)

# Set the global digits option to 2
options("digits" = 2)

# Take another look at the summary
summary(fit)
