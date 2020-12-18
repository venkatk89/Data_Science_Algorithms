# Scatterplot of weight vs. weeks
ggplot(ncbirths, aes(x = weeks, y = weight)) +
  geom_point()

# convert scatterplot to boxplot by converting x to categorical variables

# Boxplot of weight vs. weeks
ggplot(data = ncbirths, 
       aes(x = cut(weeks, breaks = 5), y = weight)) + 
  geom_boxplot()

# Mammals scatterplot
ggplot(mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point()


# Baseball player scatterplot
ggplot(mlbBat10, aes(x = OBP, y = SLG)) +
  geom_point()


# Body dimensions scatterplot
ggplot(bdims, aes(y = wgt, x = hgt, color = factor(sex))) +
  geom_point()


# Smoking scatterplot
ggplot(smoking, aes(x = age, y = amtWeekdays)) +
  geom_point()

# Scatterplot with coord_trans()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() + 
  coord_trans(x = "log10", y = "log10")
# same plot
# Scatterplot with scale_x_log10() and scale_y_log10()
ggplot(data = mammals, aes(x = BodyWt, y = BrainWt)) +
  geom_point() +
  scale_x_log10("Body Weight") + 
  scale_y_log10("Brain Weight")


# Scatterplot of SLG vs. OBP
mlbBat10 %>%
  filter(AB >= 200) %>%
  ggplot(aes(x = OBP, y = SLG)) +
  geom_point()

# Identify the outlying player
mlbBat10 %>%
  filter(OBP < 0.2, AB >= 200)

##############################################################################################################################

# Compute correlation
ncbirths %>%
  summarize(N = n(), r = cor(weight, mage))

# Compute correlation for all non-missing pairs
ncbirths %>%
  summarize(N = n(), r = cor(weight, weeks, use = "pairwise.complete.obs"))


# anscombe is a predifined dataset to explain the concept of correlation
# Compute properties of Anscombe
Anscombe %>%
  group_by(set) %>%
  summarize(N = n(), mean(x), sd(x), mean(y), sd(y), cor(x,y))

# Correlation for all baseball players
mlbBat10 %>%
  summarize(N = n(), r = cor(OBP, SLG))

# Correlation for all players with at least 200 ABs
mlbBat10 %>%
  filter(AB >= 200) %>%
  summarize(N = n(), r = cor(OBP, SLG))

# Correlation of body dimensions
bdims %>%
  group_by(sex) %>%
  summarize(N = n(), r = cor(hgt, wgt))

# Correlation among mammals, with and without log
mammals %>%
  summarize(N = n(), 
            r = cor(BrainWt, BodyWt), 
            r_log = cor(log(BrainWt), log(BodyWt)))





# Create faceted scatterplot
ggplot(noise, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~z)


# Compute correlations for each dataset
noise_summary <- noise %>%
  group_by(z) %>%
  summarize(N = n(), spurious_cor = cor(x, y))

# Isolate sets with correlations above 0.2 in absolute strength
noise_summary %>%
  filter(abs(spurious_cor) > 0.2)

###########################################33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

# Scatterplot with regression line
ggplot(data = bdims, aes(x = hgt, y = wgt)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

# Print bdims_summary
bdims_summary

# Add slope and intercept
bdims_summary %>%
  mutate(slope = r*(sd_wgt/sd_hgt), 
         intercept = (mean_wgt - slope*mean_hgt))

# Height of children vs. height of father
ggplot(data = Galton_men, aes(x = father, y = height)) +
  geom_point() + 
  geom_abline(slope = 1, intercept = 0) + 
  geom_smooth(method = "lm", se = FALSE)

# Height of children vs. height of mother
ggplot(data = Galton_women, aes(x = mother, y = height)) +
  geom_point() + 
  geom_abline(slope = 1, intercept = 0) + 
  geom_smooth(method = "lm", se = FALSE)

#3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

# Linear model for weight as a function of height
lm(wgt ~ hgt, data = bdims)

# Linear model for SLG as a function of OBP
lm(SLG ~ OBP, data = mlbBat10)

# Log-linear model for body weight as a function of brain weight
lm(log(BodyWt) ~ log(BrainWt), data = mammals)



mod <- lm(wgt ~ hgt, data = bdims)

# Show the coefficients
coef(mod)

# Show the full output
summary(mod)

# Mean of weights equal to mean of fitted values?
mean(bdims$wgt) == mean(fitted.values(mod))

# Mean of the residuals
mean(residuals(mod))

# Load broom
library(broom)

# Create bdims_tidy
bdims_tidy <- augment(mod)

# Glimpse the resulting data frame
glimpse(bdims_tidy)

# View summary of model
summary(mod)

# Compute the mean of the residuals
mean(residuals(mod))

# Compute RMSE
sqrt(sum(residuals(mod)^2) / df.residual(mod))

# View model summary
summary(mod)

# Compute R-squared
bdims_tidy %>%
  summarize(var_y = var(wgt), var_e = var(.resid)) %>%
  mutate(R_squared = 1 - (var_e / var_y))

# Compute SSE for null model
mod_null %>%
  summarize(SSE = var(.resid))

# Compute SSE for regression model
mod_hgt %>%
  summarize(SSE = var(.resid))


# .hat has leverage scores
# Rank points of high leverage
mod %>%
  augment() %>%
  arrange(desc(.hat)) %>%
  head()

# .cooksd has influenze scores
# Rank influential points
mod %>%
  augment() %>%
  arrange(desc(.cooksd)) %>%
  head()

# Create nontrivial_players
nontrivial_players <- mlbBat10 %>%
  filter(AB >= 10, OBP < 0.5)

# Fit model to new data
mod_cleaner <- lm(SLG ~ OBP, data = nontrivial_players)

# View model summary
summary(mod_cleaner)

# Visualize new model
ggplot(data = nontrivial_players, aes(x = OBP, y = SLG)) +
  geom_point() + 
  geom_smooth(method = "lm")

# Rank high leverage points
mod %>%
  augment() %>%
  arrange(desc(.hat), .cooksd) %>%
  head()

