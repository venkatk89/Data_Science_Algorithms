# importing data
train <- read.csv("train.csv") 
test <- read.csv("test.csv")
template <- read.csv("gender_submission.csv")


# gives the structure of dataframe with all columns and their datatype 
str(train) 


# no. of rows
nrow(train)
# no. of columns  # also present in data history
ncol(train)



# head
head(train)       # gives fist 10 rows


# summary
summary(train)    # gives mean, median, min, max, and quantiles for each and every column 



# changing column datatype
train$Pclass <- as.factor(train$Pclass)



# pivot table for one variable
table(train$Survived)
table(train_1$Survived)



# array creation 
x <- c(1:10)
y <- c('a', 'b', 'c')
z <- rep("venkat", 10)  # repeated values


# dataframe creation
train_1 <- train[c(1:10),c(-1,-4)]   # c(1:10) in row includes onlu first 10 rows and c(-1,-4) in column excludes column 1 and 4
# new dataframe
train_2 <- data.frame(rep("hello", nrow(train_1)), train_1[,])









