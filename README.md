# COVID-19 Data Analysis By R

This project focuses on the analysis of COVID-19 data to explore patterns related to patient demographics, such as age and gender, as well as mortality rates. The analysis is based on a dataset containing information about confirmed COVID-19 cases, including age, gender, recovery, and death status.

## Table of Contents

- [Overview](#overview)
- [Data](#data)
- [Analysis](#analysis)
- [Visualizations](#visualizations)
- [Conclusion](#conclusion)

## Overview

The main objective of this project is to explore the relationship between various factors such as age and gender with COVID-19 mortality and recovery rates. Key insights from the analysis include:
- Death rate statistics.
- Age distribution for both deceased and surviving patients.
- Gender-based death rate comparisons.
- Top 10 countries with the highest case counts.

## Data

The dataset used in this project contains the following columns:

- `id`: Unique identifier for each case.
- `case_in_country`: Case number within the country.
- `reporting date`: Date when the case was reported.
- `summary`: Summary of the case, including details on symptoms, exposure, and outcomes.
- `location`: Location where the case was reported.
- `country`: Country where the case was reported.
- `gender`: Gender of the patient.
- `age`: Age of the patient.
- `symptom_onset`: Date when symptoms first appeared.
- `If_onset_approximated`: Indicates if the symptom onset date is approximated.
- `hosp_visit_date`: Date when the individual visited the hospital.
- `exposure_start`: Start date of exposure.
- `exposure_end`: End date of exposure.
- `visiting Wuhan`: Indicates if the individual visited Wuhan.
- `from Wuhan`: Indicates if the individual is from Wuhan.
- `death`: Status of the patient (1 = deceased, 0 = alive).
- `recovered`: Status of the patient (1 = recovered, 0 = not recovered).
- `symptom`: Symptoms experienced by the individual.
- `source`: Source of the data.
- `link`: Link to the source of the data.

## Analysis

### 1. Death Rate Analysis

The death rate is calculated as the percentage of cases that resulted in death.

```R
death_rate <- mean(data$death_dummy, na.rm = TRUE)
```
### 2. Age Analysis
The average age of deceased and surviving patients was calculated, and a t-test was performed to check if there was a significant difference between the two groups.
```R
t_test_age <- t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)
```
### 3. Gender Analysis
The death rate for men and women was calculated and compared using a t-test.
```R
t_test_gender <- t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.95)
```
### 4. Top 10 Countries by Case Count
The top 10 countries with the highest number of confirmed cases were identified.
```R
top_countries <- data %>%
  group_by(country) %>%
  summarise(cases = n()) %>%
  arrange(desc(cases)) %>%
  head(10)
```
## Visualizations
The project includes the following visualizations:

- Age Distribution: Histogram of age distribution of COVID-19 patients.
![image alt](https://github.com/Fakhrul-Ahmed/Covid-19-Analysis-By-R/blob/main/Age%20Distribution.png?raw=true)
- Gender Distribution: Bar plot showing the gender distribution of patients.
![image alt](https://github.com/Fakhrul-Ahmed/Covid-19-Analysis-By-R/blob/main/Gender%20Distribution.png?raw=true)
- Death vs Recovery: Bar plot comparing the count of deaths and recoveries.
![image alt](https://github.com/Fakhrul-Ahmed/Covid-19-Analysis-By-R/blob/main/Death%20vs%20Recovery%20Count.png?raw=true)
- Top 10 Countries by Case Count: Bar plot showing the top 10 countries with the highest number of COVID-19 cases.
![image alt](https://github.com/Fakhrul-Ahmed/Covid-19-Analysis-By-R/blob/main/Top%2010%20Countries%20by%20Case.png?raw=true)
## Conclusion
This analysis highlights the impact of age and gender on COVID-19 mortality. The average age of deceased individuals (68.6 years) is significantly higher than that of survivors (48.3 years), with a p-value < 2.2e-16, indicating a strong statistical difference. Additionally, men have a higher death rate (9.24%) compared to women (4.01%), with a p-value of 0.00209, confirming a significant gender disparity. These findings emphasize the need for focused healthcare strategies to protect older individuals and men, who are at higher risk of severe outcomes.
