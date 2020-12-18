
x = set.seed(1)

sample_1 <- rnorm(100, mean = 0, sd = 1)



# library to find normality tests
library(nortest)

ad.test(sample_1)
# test succeeds

sample_2 <- rt(100, 3)

ad.test(sample_2)
# test fails




# library to find moments
library(moments)

skewness(sample_1) #-0.07
kurtosis(sample_1) #3.007


skewness(sample_2) #0.45
kurtosis(sample_2) #4.4
