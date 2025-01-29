# Load necessary libraries
library(tidyverse)
library(ggplot2)
library(dplyr)

# Load the dataset
data <- read.csv("C:/R Data/Data-3/COVID19_line_list_data.csv")

# Check the structure of the data
str(data)

# Summary statistics
summary(data)

# Handle missing values (remove rows with missing age or gender)
data <- data %>% filter(!is.na(age) & !is.na(gender))

# Create a binary column for death (1 = death, 0 = no death)
data$death_dummy <- as.integer(data$death != 0)

# Death rate
death_rate <- mean(data$death_dummy, na.rm = TRUE)
cat("Death Rate:", death_rate * 100, "%\n")

# Age analysis
dead <- subset(data, death_dummy == 1)
alive <- subset(data, death_dummy == 0)

mean_age_dead <- mean(dead$age, na.rm = TRUE)
mean_age_alive <- mean(alive$age, na.rm = TRUE)
cat("Average age of deceased:", mean_age_dead, "\n")
cat("Average age of survivors:", mean_age_alive, "\n")

# T-test for age difference
t_test_age <- t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
print(t_test_age)

# Gender analysis
men <- subset(data, gender == "male")
women <- subset(data, gender == "female")

death_rate_men <- mean(men$death_dummy, na.rm = TRUE)
death_rate_women <- mean(women$death_dummy, na.rm = TRUE)
cat("Death rate for men:", death_rate_men * 100, "%\n")
cat("Death rate for women:", death_rate_women * 100, "%\n")

# T-test for gender difference
t_test_gender <- t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.95)
print(t_test_gender)

# Top 10 Countries by Case Count
top_countries <- data %>%
  group_by(country) %>%
  summarise(cases = n()) %>%
  arrange(desc(cases)) %>%
  head(10)

# Print top 10 countries
print(top_countries)

# Visualizations
# Age distribution
ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Age Distribution of COVID-19 Cases", x = "Age", y = "Cases") +
  theme_minimal()

# Gender distribution
ggplot(data, aes(x = gender)) +
  geom_bar(fill = "purple", alpha = 0.7) +
  labs(title = "Gender Distribution of COVID-19 Cases", x = "Gender", y = "Cases") +
  theme_minimal()

# Death vs. Recovery
death_recovery <- data %>%
  gather(key = "status", value = "value", death_dummy, recovered) %>%
  filter(!is.na(value)) %>%
  group_by(status) %>%
  summarise(count = n())

ggplot(death_recovery, aes(x = status, y = count, fill = status)) +
  geom_bar(stat = "identity") +
  labs(title = "Death vs Recovery Count", x = "Status", y = "Cases") +
  theme_minimal()

# Top 10 Countries by Case Count
ggplot(top_countries, aes(x = reorder(country, -cases), y = cases, fill = country)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 Countries by Case", x = "Country", y = "Cases") +
  theme_minimal()
