# Load necessary packages
rm(list=ls())
library(readr)  # for reading CSV files
library(dplyr)  # for data manipulation
library(ggplot2) # for plotting
library(tidyverse)
library(dplyr)

# Load the dataset
pollinators <- read_csv("C:/Users/chemk/Desktop/Classes/ENT6707_DataAnalysis/group_project/6707-Group-Project/Original_file_Breh/Pollinator_Obs_Data_24_ENT_6702.csv")

# Inspect the first few rows of the data
head(pollinators)

# Ensure variables are assigned their correct data types
pollinators <- pollinators %>%
  mutate(
    Location = as.factor(Location),              # Convert location to factor
    Application = as.factor(Application),        # Convert application to factor
    Date = as.Date(Date, format = "%Y-%m-%d"),   # Convert date to Date (adjust format if necessary)
    Treatment = as.factor(Treatment),            # Convert treatment to factor
    Zone = as.factor(Zone),                      # Convert zone to factor
    Pollinator_category = as.factor(Pollinator_category),  # Convert pollinator_category to factor
    Duration_of_visit = as.numeric(Duration_of_visit)  # Convert duration_of_visit to numeric
  )


# Subset the data to only include POST treatment data
post_data <- pollinators %>%
  filter(Application == "Post") %>%  # Filtering for "post" in the application column
  droplevels() 

# Inspect the first few rows of the subset data
str(post_data)
summary(post_data)
head(post_data)
tail(post_data)


# Boxplot of a specific variable
ggplot(post_data, aes(x = Pollinator_category, y = Duration_of_visit)) + 
  geom_boxplot() +  
  theme_minimal()

ggplot(post_data, aes(x = Treatment, y = Duration_of_visit)) + 
  geom_boxplot() +
  theme_minimal()

#Boxplot with points 
ggplot(post_data, aes(x = Pollinator_category, y = Duration_of_visit)) + 
  geom_boxplot() +  geom_jitter(width = 0.2, size = 2, color = "blue")
theme_minimal()

ggplot(post_data, aes(x = Treatment, y = Duration_of_visit)) + 
  geom_boxplot() + geom_jitter(width = 0.2, size = 2, color = "blue") +
  theme_minimal()

#Q-Q to see normality 
qqnorm(post_data$Duration_of_visit)
qqline(post_data$Duration_of_visit, col = "red")

#checking normality with shapiro test 
shapiro.test(post_data$Duration_of_visit)


#Conclusion: the data does not have a normal distribution of its numerical variable duration of visit. 



######################## DaheeUpdated start ##########################
#log Q-Q to see normality
library(dplyr)

#log - qqnorm looks good, but I tried to do histogram which didn't look good.
post_data <- post_data %>% mutate(Duration_of_visit_log = log(Duration_of_visit + 1))
head(post_data)
qqnorm(post_data$Duration_of_visit_log)
qqline(post_data$Duration_of_visit_log, col = "red")

#sqrt - so I used sqrt.
library(lme4)
library(lmerTest)

# 1
post_data <- post_data %>% mutate(Duration_of_visit_sqrt = sqrt(Duration_of_visit))
mixed_model_sqrt_1 <- lmer(Duration_of_visit_sqrt ~ Pollinator_category + Treatment + (1 | Location) + (1 | Zone), data = post_data) # This doesn't work. Errors keep occuring. 

# 2
post_data <- post_data %>% mutate(Duration_of_visit_sqrt = sqrt(Duration_of_visit))
mixed_model_sqrt_2 <- lmer(Duration_of_visit_sqrt ~ Pollinator_category + Treatment + (Pollinator_category | Location) + (Pollinator_category | Zone), data = post_data)
summary(mixed_model_sqrt_2)
## This works. If we assume that the effect of Pollinator_category may vary depending on Location/Zone, it can be used. However, p-value doesn't seem to be significant.

# 3
post_data <- post_data %>% mutate(Duration_of_visit_sqrt = sqrt(Duration_of_visit))
mixed_model_sqrt_3 <- lmer(Duration_of_visit_sqrt ~ Pollinator_category + Treatment + (1 | Location), data = post_data)
summary(mixed_model_sqrt_3) ## This works. I guess we have too many random effect, so if we can delete one random effect, this may work. In summary, the p-value of intercept is only significant.

# 4
post_data <- post_data %>% mutate(Duration_of_visit_sqrt = sqrt(Duration_of_visit))
mixed_model_sqrt_4 <- lmer(Duration_of_visit_sqrt ~ Pollinator_category + Treatment + (1 | Zone), data = post_data)
summary(mixed_model_sqrt_4) ## This doesn't work, assuming that there might be some problems with variables of "Zone".

plot(mixed_model_sqrt)


library(lmerTest)

# 2
# Fit the mixed model with lmerTest for p-values
qqnorm(resid(mixed_model_sqrt_2))
qqline(resid(mixed_model_sqrt_2), col = "red")
# Extract fitted values and residuals
fitted_values_2 <- fitted(mixed_model_sqrt_2)
residuals_2 <- resid(mixed_model_sqrt_2)
# Create Residuals vs Fitted plot
ggplot(data.frame(fitted_values_2, residuals_2), aes(x = fitted_values_2, y = residuals_2)) +
  geom_point() +
  geom_hline(yintercept = 0, color = "red") +
  labs(x = "Fitted Values", y = "Residuals", title = "Residuals vs Fitted") +
  theme_minimal()
# Visualize random effects
install.packages("sjPlot")
library(sjPlot)
plot_model(mixed_model_sqrt_2, type = "re")


# 3
# Fit the mixed model with lmerTest for p-values
qqnorm(resid(mixed_model_sqrt_3))
qqline(resid(mixed_model_sqrt_3), col = "red")
# Extract fitted values and residuals
fitted_values_3 <- fitted(mixed_model_sqrt_3)
residuals_3 <- resid(mixed_model_sqrt_3)
# Create Residuals vs Fitted plot
ggplot(data.frame(fitted_values_3, residuals_3), aes(x = fitted_values_3, y = residuals_3)) +
  geom_point() +
  geom_hline(yintercept = 0, color = "red") +
  labs(x = "Fitted Values", y = "Residuals", title = "Residuals vs Fitted") +
  theme_minimal()
# Visualize random effects
library(ggplot2)
install.packages("sjPlot")
library(sjPlot)
plot_model(mixed_model_sqrt_3, type = "re")


##################### Daheeupdated end #######################






# Load necessary library for mixed models
library(lme4)

# Fit a mixed model with Pollinator_category and Treatment as fixed effects, 
# and Location and Zone as random effects (adjust based on your design)
mixed_model <- lmer(Duration_of_visit ~ Pollinator_category * Treatment + (1|Location) + (1|Zone), data = post_data)

# Summary of the mixed model
summary(mixed_model)

# Diagnostic plots for the mixed model
plot(mixed_model)

install.packages("lmerTest")
library(lmerTest)
# Fit the mixed model with lmerTest for p-values
mixed_model <- lmer(Duration_of_visit ~ Pollinator_category + Treatment + (1|Location) + (1|Zone), data = post_data)

summary(mixed_model)


qqnorm(resid(mixed_model))
qqline(resid(mixed_model), col = "red")
library(ggplot2)

# Extract fitted values and residuals
fitted_values <- fitted(mixed_model)
residuals <- resid(mixed_model)

# Create Residuals vs Fitted plot
ggplot(data.frame(fitted_values, residuals), aes(x = fitted_values, y = residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, color = "red") +
  labs(x = "Fitted Values", y = "Residuals", title = "Residuals vs Fitted") +
  theme_minimal()

# Visualize random effects
install.packages("sjPlot")
library(sjPlot)
plot_model(mixed_model, type = "re")

