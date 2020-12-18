# Load the dplyr package
library(dplyr)

# Load the hflights package
library(hflights)

# Call both head() and summary() on hflights
head(hflights)
summary(hflights)

# Convert the hflights data.frame into a hflights tbl
hflights <- tbl_df(hflights)

# Display the hflights tbl
hflights

# Create the object carriers
carriers <- hflights$UniqueCarrier

lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")

# Add the Carrier column to hflights
hflights$Carrier <- lut[hflights$UniqueCarrier]

# Glimpse at hflights
glimpse(hflights)

# The lookup table
lut <- c("A" = "carrier", "B" = "weather", "C" = "FFA", "D" = "security", "E" = "not cancelled")

# Add the Code column
hflights$Code <- lut[hflights$CancellationCode]

# Glimpse at hflights
glimpse(hflights)

#########################################################################################################

#The dplyr package contains five key data manipulation functions, also called verbs:

#select(), which returns a subset of the columns,
#filter(), that is able to return a subset of the rows,
#arrange(), that reorders the rows according to single or multiple variables,
#mutate(), used to add columns from existing data,
#summarise(), which reduces each group to a single row by calculating aggregate measures.


# Print out a tbl with the four columns of hflights related to delay
select(hflights, ActualElapsedTime, AirTime, ArrDelay ,DepDelay)

# Print out the columns Origin up to Cancelled of hflights
select(hflights, 14:19)

# Answer to last question: be concise!
select(hflights,-c(5:11))

#dplyr comes with a set of helper functions that can help you select groups of variables inside a select() call:
  
#starts_with("X"): every name that starts with "X",
#ends_with("X"): every name that ends with "X",
#contains("X"): every name that contains "X",
#matches("X"): every name that matches "X", where "X" can be a regular expression,
#num_range("x", 1:5): the variables named x01, x02, x03, x04 and x05,
#one_of(x): every name that appears in x, which should be a character vector.

# Print out a tbl containing just ArrDelay and DepDelay
select(hflights, ends_with("Delay"))

# Print out a tbl as described in the second instruction, using both helper functions and variable names
select(hflights, ends_with("Num"), contains("Cancell"), UniqueCarrier)

# Print out a tbl as described in the third instruction, using only helper functions.
select(hflights, contains("Time"), ends_with("Delay"))

# Finish select call so that ex1d matches ex1r
ex1r <- hflights[c("TaxiIn", "TaxiOut", "Distance")]
ex1d <- select(hflights, 16:18)

# Finish select call so that ex2d matches ex2r
ex2r <- hflights[c("Year", "Month", "DayOfWeek", "DepTime", "ArrTime")]
ex2d <- select(hflights, 1:6, -3)

# Finish select call so that ex3d matches ex3r
ex3r <- hflights[c("TailNum", "TaxiIn", "TaxiOut")]
ex3d <- select(hflights, c(9, 17, 18))

#mutate() creates new columns which are added to a copy of the dataset.

# Add the new variable ActualGroundTime to a copy of hflights and save the result as g1.
g1 <- mutate(hflights, ActualGroundTime = ActualElapsedTime - AirTime)

# Add the new variable GroundTime to g1. Save the result as g2.
g2 <- mutate(g1, GroundTime = TaxiIn + TaxiOut)

# Add the new variable AverageSpeed to g2. Save the result as g3.
g3 <- mutate(g2, AverageSpeed = Distance / AirTime * 60)

# Add a second variable loss_ratio to the dataset: m1
m1 <- mutate(hflights, loss = ArrDelay - DepDelay,loss_ratio = loss / DepDelay)

# Add the three variables as described in the third instruction: m2
m2 <- mutate(hflights, TotalTaxi = TaxiIn + TaxiOut, ActualGroundTime = ActualElapsedTime - AirTime, Diff = TotalTaxi - ActualGroundTime)

############################################################################################


# All flights that traveled 3000 miles or more
filter(hflights, Distance > 3000)

# All flights flown by one of JetBlue, Southwest, or Delta
filter(hflights, UniqueCarrier %in% c("JetBlue", "Southwest", "Delta"))

# All flights where taxiing took longer than flying
filter(hflights, TaxiIn + TaxiOut > AirTime)

# All flights that departed before 5am or arrived after 10pm
filter(hflights, DepTime < 500 | ArrTime > 2200)

# All flights that departed late but arrived ahead of schedule
filter(hflights, DepDelay > 0 & ArrDelay < 0)

# All flights that were cancelled after being delayed
filter(hflights, DepDelay > 0 & Cancelled == 1)

# Select the flights that had JFK as their destination: c1
c1 <- filter(hflights, Dest == "JFK")

# Combine the Year, Month and DayofMonth variables to create a Date column: c2
c2 <- mutate(c1, Date = paste(Year, Month, DayofMonth, sep = "-"))

# Print out a selection of columns of c2
select(c2, Date, DepTime, ArrTime, TailNum)

#arrange() can be used to rearrange rows according to any type of data. 
#If you pass arrange() a character variable, for example, R will rearrange the rows in alphabetical order according to values of the variable.
#If you pass a factor variable, R will rearrange the rows according 
#to the order of the levels in your factor (running levels() on the variable reveals this order).

# Definition of dtc
dtc <- filter(hflights, Cancelled == 1, !is.na(DepDelay))

# Arrange dtc by departure delays
arrange(dtc, DepDelay)

# Arrange dtc so that cancellation reasons are grouped
arrange(dtc, CancellationCode)

# Arrange dtc according to carrier and departure delays
arrange(dtc, UniqueCarrier, DepDelay)

# Arrange according to carrier and decreasing departure delays
arrange(hflights, UniqueCarrier, desc(DepDelay))

# Arrange flights by total delay (normal order).
arrange(hflights, (DepDelay + ArrDelay))

#summarise(), the last of the 5 verbs, follows the same syntax as mutate(), 
#but the resulting dataset consists of a single row instead of an entire new column in the case of mutate()

# Print out a summary with variables min_dist and max_dist
summarise(hflights, min_dist = min(Distance), max_dist = max(Distance))

# Print out a summary with variable max_div
summarise(filter(hflights, Diverted == 1), max_div = max(Distance))

# Remove rows that have NA ArrDelay: temp1
temp1 = filter(hflights, !is.na(ArrDelay))

# Generate summary about ArrDelay column of temp1
summarise(temp1,earliest = min(ArrDelay), average = mean(ArrDelay), latest = max(ArrDelay), sd = sd(ArrDelay))

# Keep rows that have no NA TaxiIn and no NA TaxiOut: temp2
temp2 = filter(hflights, !is.na(TaxiIn) & !is.na(TaxiOut))

# Print the maximum taxiing difference of temp2 with summarise()
summarise(temp2, max_taxi_diff = max(abs(TaxiIn - TaxiOut)))

# Generate summarizing statistics for hflights
summarise(hflights,
          n_obs = n(),
          n_carrier = n_distinct(UniqueCarrier),
          n_dest = n_distinct(Dest))

# All American Airline flights
aa <- filter(hflights, UniqueCarrier == "American")

# Generate summarizing statistics for aa 
summarise(aa, n_flights = n(),
          n_canc = sum(Cancelled),
          avg_delay = mean(ArrDelay, na.rm = TRUE))

hflights %>%
  mutate(diff = TaxiOut - TaxiIn) %>%
  filter(!is.na(diff)) %>%
  summarise(avg = mean(diff))

# Chain together mutate(), filter() and summarise()
hflights %>%
  mutate(RealTime = ActualElapsedTime + 100) %>%
  mutate(mph = Distance / RealTime * 60) %>%
  filter(!is.na(mph) & mph < 70) %>%
  summarise(n_less = n(),
            n_dest = n_distinct(Dest),
            min_dist = min(Distance),
            max_dist = max(Distance))

hflights %>%
  mutate(RealTime = ActualElapsedTime + 100, mph = Distance / RealTime * 60) %>%
  filter(mph < 105 | Cancelled == 1 | Diverted == 1) %>%
  summarise(n_non = n(),
            n_dest = n_distinct(Dest),
            min_dist =min(Distance),
            max_dist = max(Distance))

# Count the number of overnight flights
hflights %>%
  filter(!is.na(DepTime) & !is.na(ArrTime) & DepTime > ArrTime) %>%
  summarise(num = n())

###############################################################################################################

# Make an ordered per-carrier summary of hflights
hflights %>%
  group_by(UniqueCarrier) %>%
  summarise(p_canc = mean(Cancelled) * 100,
            avg_delay = mean(ArrDelay, na.rm = TRUE)) %>%
  arrange(avg_delay, p_canc)

# Ordered overview of average arrival delays per carrier
hflights %>%
  filter(!is.na(ArrDelay) & ArrDelay > 0) %>%
  group_by(UniqueCarrier) %>%
  summarise(avg = mean(ArrDelay)) %>%
  mutate(rank = rank(avg)) %>%
  arrange(rank)

# Set up a connection to the mysql database
my_db <- src_mysql(dbname = "dplyr", 
                   host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
                   port = 3306, 
                   user = "student",
                   password = "datacamp")

# Reference a table within that source: nycflights
nycflights <- tbl(my_db, "dplyr")

# glimpse at nycflights
glimpse(nycflights)

# Ordered, grouped summary of nycflights
nycflights %>%
  group_by(carrier) %>%
  summarise(n_flights = n(), avg_delay = mean(arr_delay)) %>%
  arrange(avg_delay)
