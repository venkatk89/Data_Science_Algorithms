library(doSNOW)  #for parallel processing

# Set up doSNOW package for multi-core training.
# NOTE - This works on Windows and Mac, unlike doMC which works only for linux and mac

cl <- makeCluster(4, type = "SOCK") #creates 4 clusters of SOCK type
registerDoSNOW(cl)                  #caret recogonizes multicores only if it is registered. If not it just uses the parent core



# whatever code written here gets completed faster almost 4x times. 



#Shutdown cluster
stopCluster(cl)