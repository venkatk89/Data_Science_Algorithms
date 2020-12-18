test_input <- read.csv("infile(contains_null_values).csv")  #read file from directory



i = 0 
j = 0
for(i in c(1:nrow(test_input))){ # change no. of rows
  for(j in c(1:ncol(test_input))){ # change no. of columns
    if(is.na(test_input[i,j])){
      test_input[i,j] <- median(test_input[,j], na.rm = TRUE)
    }
  }
}

write.csv(test_input,"test.csv", row.names =FALSE) # write file to directory

