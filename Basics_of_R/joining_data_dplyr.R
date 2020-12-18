# Complete the code to join artists to bands
bands2 <- left_join(bands, artists, by = c("first", "last"))

# Examine the results
bands2

# Finish the code below to recreate bands3 with a right join
bands2 <- left_join(bands, artists, by = c("first", "last"))
bands3 <- right_join(artists, bands, by = c("first", "last"))

# Check that bands3 is equal to bands2
setequal(bands3, bands2)

# Join albums to songs using inner_join()
inner_join(songs, albums, by = "album")

# Join bands to artists using full_join()
full_join(artists, bands, by = c("first", "last"))

# Find guitarists in bands dataset (don't change)
temp <- left_join(bands, artists, by = c("first", "last"))
temp <- filter(temp, instrument == "Guitar")
select(temp, first, last, band)

# Reproduce code above using pipes
bands %>% 
  left_join(artists, by = c("first", "last")) %>%
  filter(instrument == "Guitar") %>%
  select(first, last, band)

# Examine the contents of the goal dataset
goal

# Create goal2 using full_join() and inner_join() 
goal2 <- artists %>%
  full_join(bands, by = c("first", "last")) %>%
  inner_join(songs, by = c("first", "last"))



# Check that goal and goal2 are the same
setequal(goal, goal2)

# Create one table that combines all information
artists %>%
  full_join(bands, by = c("first", "last")) %>%
  full_join(songs, by = c("first", "last")) %>%
  full_join(albums, by = c("band", "album"))

#######################################################################################3

# View the output of semi_join()
artists %>% 
  semi_join(songs, by = c("first", "last"))

# Create the same result
artists %>% 
  right_join(songs, by = c("first", "last")) %>% 
  filter(!is.na(instrument)) %>% 
  select(first, last, instrument)

albums %>% 
  # Collect the albums made by a band
  semi_join(bands, by = "band") %>% 
  # Count the albums made by a band
  nrow()

# Return rows of artists that don't have bands info
artists %>% 
  anti_join(bands, by = c("first", "last"))

# Determine which key joins labels and songs
labels
songs

# Check your understanding
songs %>% 
  # Find the rows of songs that match a row in labels
  semi_join(labels, "album") %>% 
  # Number of matches between labels and songs
  nrow()

aerosmith %>% 
  # Create the new dataset using a set operation
  union(greatest_hits) %>% 
  # Count the total number of songs
  nrow()

# Create the new dataset using a set operation
aerosmith %>% 
  intersect(greatest_hits)

# Select the song names from live
live_songs <- live %>% select(song)

# Select the song names from greatest_hits
greatest_songs <- greatest_hits %>% select(song)

# Create the new dataset using a set operation
live_songs %>% 
  setdiff(greatest_songs)

# Select songs from live and greatest_hits
live_songs <- select(live, song)
greatest_songs <- select(greatest_hits, song)

# Return the songs that only exist in one dataset
live_songs %>%
  union(greatest_songs) %>%
  setdiff(intersect(live_songs, greatest_songs))

# Check if same order: definitive and complete
identical(definitive, complete)

# Check if any order: definitive and complete
setequal(definitive, complete)

# Songs in definitive but not complete
setdiff(definitive, complete)


# Songs in complete but not definitive
setdiff(complete, definitive)

# Return songs in definitive that are not in complete
definitive %>% 
  anti_join(complete)

# Return songs in complete that are not in definitive
complete %>% 
  anti_join(definitive)

# Check if same order: definitive and union of complete and soundtrack
complete %>%
  union(soundtrack) %>%
  identical(definitive)


# Check if any order: definitive and union of complete and soundtrack
complete %>%
  union(soundtrack) %>%
  setequal(definitive)

###################################################################################################

# Examine side_one and side_two
side_one
side_two

# Bind side_one and side_two into a single dataset
side_one %>% 
  bind_rows(side_two)

# Examine discography and jimi
discography
jimi

jimi %>% 
  # Bind jimi into a single data frame
  bind_rows(.id = 'album') %>% 
  # Make a complete data frame
  left_join(discography)

# Examine hank_years and hank_charts
hank_years
hank_charts

hank_years %>% 
  # Reorder hank_years alphabetically by song title
  arrange(by = song) %>% 
  # Select just the year column
  select(year) %>% 
  # Bind the year column
  bind_cols(hank_charts) %>% 
  # Arrange the finished dataset
  arrange(by = year)

# Make combined data frame using data_frame()
data_frame('year' = hank_year, 'song' = hank_song, 'peak' = hank_peak ) %>% 
  # Extract songs where peak equals 1
  filter(peak == 1)

# Examine the contents of hank
hank

# Convert the hank list into a data frame
as_data_frame(hank) %>% 
  # Extract songs where peak equals 1
  filter(peak == 1)

####################################################################################################################

# Examine the result of joining singers to two_songs
two_songs %>% inner_join(singers, by = "movie")

# Remove NA's from key before joining
two_songs %>% 
  filter(!is.na(movie)) %>% 
  inner_join(singers, by = "movie")

movie_years %>% 
  # Left join movie_studios to movie_years
  left_join(movie_studios, by = 'movie') %>% 
  # Rename the columns: artist and studio
  rename(artist = name.x, studio = name.y)

# Identify the key column
elvis_songs
elvis_movies

elvis_movies %>% 
  # Left join elvis_songs to elvis_movies by this column
  left_join(elvis_songs, by = c('name' = 'movie')) %>% 
  # Rename columns
  rename(movie = name, song = name.y)

# Identify the key columns
movie_directors
movie_years

movie_years %>% 
  # Left join movie_directors to movie_years
  left_join(movie_directors, by = c("movie" = "name")) %>% 
  rename(artist = name) %>%
  # Arrange the columns using select()
  select(year, movie, artist, director, studio)

# Load the purrr library
library(purrr)

# Place supergroups, more_bands, and more_artists into a list
list(supergroups, more_bands, more_artists) %>% 
  # Use reduce to join together the contents of the list
  reduce(left_join)

list(more_artists, more_bands, supergroups) %>% 
  # Return rows of more_artists in all three datasets
  reduce(semi_join)

vignette(topic = "databases", package = "dplyr")

# Alter the code to perform the join with a dplyr function
#merge(bands, artists, by = c("first", "last"), all.x = TRUE) %>%
# arrange(band)

bands %>%
  left_join(artists, by = c("first", "last")) %>%
  arrange(band)

###########################################################################################################################

# CASE STUDY WITH LAHMAN DATABASE
# Examine lahmanNames
lahmanNames

# Find variables in common
reduce(lahmanNames, intersect) # no variables in common

lahmanNames %>%  
  # Bind the data frames in lahmanNames
  bind_rows(.id = 'dataframe') %>%
  # Group the result by var
  group_by(var) %>%
  # Tally the number of appearances
  tally() %>%
  # Filter the data
  filter(n > 1) %>% 
  # Arrange the results
  arrange(desc(n))

lahmanNames %>% 
  # Bind the data frames
  bind_rows(.id = 'dataframe') %>%
  # Filter the results
  filter(var == 'playerID') %>% 
  # Extract the dataframe variable
  `$`(dataframe)

players <- Master %>% 
  # Return one row for each distinct player
  distinct(playerID, nameFirst, nameLast)

players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries) %>%
  # Count them
  count()

players %>% 
  anti_join(Salaries, by = "playerID") %>% 
  # How many unsalaried players appear in Appearances?
  semi_join(Appearances) %>% 
  count()

players %>% 
  # Find all players who do not appear in Salaries
  anti_join(Salaries, by = 'playerID') %>% 
  # Join them to Appearances
  left_join(Appearances, by = 'playerID') %>% 
  # Calculate total_games for each player
  group_by(playerID) %>%
  summarise('total_games' = sum(G_all, na.rm = TRUE)) %>%
  # Arrange in descending order by total_games
  arrange(desc(total_games))

players %>%
  # Find unsalaried players
  anti_join(Salaries, by = 'playerID') %>% 
  # Join Batting to the unsalaried players
  left_join(Batting) %>% 
  # Group by player
  group_by(playerID) %>% 
  # Sum at-bats for each player
  summarise('total_at_bat' = sum(AB, na.rm = TRUE)) %>% 
  # Arrange in descending order
  arrange(desc(total_at_bat))

# Find the distinct players that appear in HallOfFame
nominated <- HallOfFame %>% 
  distinct(playerID)

nominated %>% 
  # Count the number of players in nominated
  count()

nominated_full <- nominated %>% 
  # Join to Master
  left_join(Master, by = 'playerID') %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID, nameFirst, nameLast)

inducted <- HallOfFame %>% 
  filter(inducted == "Y") %>% 
  distinct(playerID)

inducted %>% 
  # Count the number of players in inducted
  count()

inducted_full <- inducted %>% 
  # Join to Master
  left_join(Master, by = 'playerID') %>% 
  # Return playerID, nameFirst, nameLast
  select(playerID, nameFirst, nameLast)

# Tally the number of awards in AwardsPlayers by playerID
nAwards <- AwardsPlayers %>% 
  group_by(playerID) %>% 
  tally

nAwards %>% 
  # Filter to just the players in inducted 
  filter(playerID %in% inducted$playerID) %>% 
  # Calculate the mean number of awards per player
  summarise('avg_n' = mean(n, na.rm =TRUE))

nAwards %>% 
  # Filter to just the players in nominated 
  filter(playerID %in% nominated$playerID) %>% 
  # Filter to players NOT in inducted 
  filter(!(playerID %in% inducted$playerID)) %>% 
  # Calculate the mean number of awards per player
  summarise('avg_n' = mean(n, na.rm =TRUE))

# Find the players who are in nominated, but not inducted
notInducted <- nominated %>% 
  setdiff(inducted)

Salaries %>% 
  # Find the players who are in notInducted
  semi_join(notInducted, by = "playerID") %>%
  # Calculate the max salary by player
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  # Calculate the average of the max salaries
  summarize(avg_salary = mean(max_salary, na.rm = TRUE))

# Repeat for players who were inducted
Salaries %>% 
  semi_join(inducted, by = "playerID") %>% 
  group_by(playerID) %>% 
  summarize(max_salary = max(salary, na.rm = TRUE)) %>% 
  summarize(avg_salary = mean(max_salary, na.rm = TRUE))

Appearances %>% 
  # Filter Appearances against nominated
  semi_join(nominated, by = "playerID") %>% 
  # Find last year played by player
  group_by(playerID) %>% 
  summarize(last_year = max(yearID)) %>% 
  # Join to full HallOfFame
  left_join(HallOfFame, by = "playerID") %>% 
  # Filter for unusual observations
  filter(last_year >= yearID)