# Load necessary packages
library(readr)  # for reading CSV files
library(dplyr)  # for data manipulation
library(ggplot2) # for plotting
library(tidyverse)
library(dplyr)

# Load the dataset
pollinators <- read_csv("pollinator.csv")

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



