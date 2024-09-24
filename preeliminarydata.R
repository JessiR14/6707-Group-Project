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




