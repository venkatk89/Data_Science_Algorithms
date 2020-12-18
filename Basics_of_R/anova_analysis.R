# ONE WAY ANOVA


a <- c(100,100,99,101,100)

b <- c(101,104,98,105,102)

c <- c(107,103,105,105,106)

d <- c(100,96,99,100,99)

e <- c(119,122,114,120,121)

df <- data.frame(a,b,c,d,e)
df$trial <- c(1,2,3,4,5)

str(df)

library(reshape2)
df_new <- melt(df, id.vars = c("trial"))


aov_res <- aov(value ~ variable, data = df_new)
summary(aov_res)





#-----------------------------------------------------------------------------------------------------------------------


# TWO WAY ANOVA








mice <- c(1,2,3,4,5)
lf <- c(20,19,20,22,19)
mf <- c(18,17,20,21,19)
hf <- c(18,20,17,16,16)
vhf <- c(21,23,20,23,22)


exp_data <- data.frame(mice, lf, mf, hf, vhf)


molten_exp_data <- melt(exp_data, id.vars = c("mice"))
str(molten_exp_data)

#one way anova with diet variable
aov_res_1 <- aov(value ~ variable, data = molten_exp_data)
summary(aov_res_1)


# one way anova with mice variable
aov_res_2 <- aov(value ~ mice, data = molten_exp_data)
summary(aov_res_2)
# dissapointing results


molten_exp_data$mice <- as.factor(molten_exp_data$mice)
aov_res_2 <- aov(value ~ mice, data = molten_exp_data)
summary(aov_res_2)




# two way anova

aov_res_3 <- aov(value ~ variable + mice, data = molten_exp_data)
summary(aov_res_3)





#----------------------------------------------------------

# ANOVA with interaction

m_met <- c(15,18,26,14,19)

f_met <- c(29,49, 33, 37, 27)

m_thz <- c(14, 12, 18, 20, 16)

f_thz <- c(14, 18, 25, 20, 26)

gender <- c(rep("male", 10), rep("female", 10))

drug <- c(rep("met", 5), rep("thz", 5), rep("met", 5), rep("thz", 5) )

observation <- c(m_met, m_thz, f_met, f_thz)

final_data <- data.frame(gender, drug, observation)

summary(final_data)

library(ggplot2)
library(dplyr)

ggplot(final_data, aes(x = gender, y = observation, col = drug)) +
  geom_boxplot()



summ_data <- final_data%>%
  group_by(drug, gender)%>%
  summarise(mean_obs = mean(observation))


ggplot(data = summ_data, aes(y = mean_obs, col = drug, x = gender))+
  geom_point()




aov_res <- aov(observation ~ drug + gender + gender*drug, data = final_data)
summary(aov_res)

























