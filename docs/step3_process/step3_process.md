---
layout: default
title: Process
permalink: /step3_process/
---

# Step 3: Process Data

This step involves cleaning, transforming, and preparing the data for further analysis.

---

## 1. Data Cleaning Steps

### Tools Used:
- **R** with `tidyverse`, `lubridate`, `janitor`, `readr`


### Cleaning Objectives:
- Validate structure and integrity of each dataset
- Harmonize timestamp formats across datasets
- Normalize column naming conventions
- Eliminate redundant rows and missing values
- Derive contextual flags such as usage time category and step classification

### Cleaning Pipeline:
```r
library(tidyverse)
library(lubridate)
library(janitor)

# Load datasets
activity <- read_csv("data/raw_data/dailyActivity_merged.csv")
sleep <- read_csv("data/raw_data/sleepDay_merged.csv")
steps_hourly <- read_csv("data/raw_data/hourlySteps_merged.csv")

# Clean column names and standardize formats （as_date -> remove the time component, keep only the date)
activity <- activity %>% clean_names() %>% rename(date = activity_date) %>% mutate(date = mdy(date))
sleep <- sleep %>% clean_names() %>% rename(date = sleep_day) %>% mutate(date = as_date(mdy_hms(date)))
steps_hourly <- steps_hourly %>% clean_names() %>% rename(datetime = activity_hour) %>% mutate(datetime = mdy_hms(datetime))

# Remove duplicate entries and rows with missing values
activity <- activity %>% distinct() %>% drop_na()
sleep <- sleep %>% distinct() %>% drop_na()
steps_hourly <- steps_hourly %>% distinct() %>% drop_na()
```

---

## 2. Data Aggregation and Feature Engineering

### a. Daily Step Summaries
```r
daily_steps <- steps_hourly %>%
  mutate(date = as_date(datetime)) %>%
  group_by(id, date) %>%
  summarise(daily_steps = sum(step_total), .groups = 'drop')
```

### b. Classify Step Intensity Levels
```r
step_levels <- daily_steps %>%
  mutate(step_level = case_when(
    daily_steps < 5000 ~ "sedentary",
    daily_steps < 7500 ~ "lightly active",
    daily_steps < 10000 ~ "fairly active",
    TRUE ~ "very active"
  ))
```

> Based on the step-count classification guidelines by Tudor-Locke & Bassett (2004).

### c. Device Usage Time Classification
```r
activity <- activity %>%
  mutate(minutes_worn = sedentary_minutes + lightly_active_minutes + fairly_active_minutes + very_active_minutes,
         usage_category = case_when(
           minutes_worn >= 1440 ~ "All day",
           minutes_worn >= 720 ~ "Most of day",
           minutes_worn > 0 ~ "Part day",
           TRUE ~ "No use"
         ))
```

> Note: 1440 minutes = 24 hours. These thresholds are practical approximations based on daily wearable usage.

---

## 3. Processed Outputs

Cleaned and transformed data files are saved in the following directory:

```
data/
└── processed-data/
    ├── daily_activity_clean.csv
    ├── daily_sleep_clean.csv
    ├── daily_steps_aggregated.csv
    ├── hourly_steps_clean.csv
    └── merged_activity_sleep.csv
```

---

## 4. Script Repository Structure

```
scripts/
├── cleaning.R         # General cleaning, validation, formatting
├── merging.R          # Dataset joins and output export
└── aggregation.R      # Summaries and classification
```

---

## 5. Final Validations
```r
# Sample checks
summary(activity)
n_distinct(activity$id)
any(is.na(activity))
```

---

<!-- 🔗 **[← Back to Step 2: Prepare](../step2_prepare/)** | 🔜 **[Next: Step 4: Analyze →](../step4_analyze/)** -->

<div style="display: flex; justify-content: space-between;">
  <span>🔗 <a href="../step2_prepare/"><strong>← Back to Step 2: Prepare<strong></a></span>
  <span>🔜 <a href="../step4_analyze/"><strong>Next: Step 4: Analyze →<strong></a></span>
</div>

---

© [2025] [Yi-Hsuan Chiang]  
Licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)

<!-- Command run in Terminal: Rscript scripts/cleaning.R  -->







<!-- #### Tasks Completed:

- Removed duplicates
- Renamed columns for clarity
- Standardized date formats
- Aggregated minute/hour data into daily summaries (where needed)
- Removed records with missing or unrealistic values

#### Example:
```r
library(dplyr)
library(readr)

# Load daily activity data
daily_activity <- read.csv("data/raw-data/dailyActivity_merged.csv")

# Remove duplicates
daily_activity <- daily_activity[!duplicated(daily_activity), ]

# Clean column names
daily_activity <- daily_activity %>%
  rename(
    Date = ActivityDate,
    Steps = TotalSteps,
    Calories = Calories
  )

# Check missing values
colSums(is.na(daily_activity))
```

---

## 2. Data Aggregation Examples

Merged and aggregated:
- **Hourly → Daily steps**: summed by user/date
- **Heart rate (seconds) → daily average/max**
- **Minute METs → total MET per day**

```r
hourly_steps <- read.csv("data/raw-data/hourlySteps_merged.csv")

daily_steps <- hourly_steps %>%
  group_by(Id, Date = as.Date(ActivityHour)) %>%
  summarize(DailySteps = sum(StepTotal))
```

---

## 3. Processed Outputs

Stored cleaned and transformed datasets here:

```
data/
└── processed-data/
    ├── daily_activity_clean.csv
    ├── daily_steps_aggregated.csv
    └── merged_activity_sleep.csv
```

---

## 4. Script Repository

All data cleaning steps are documented in:

```
scripts/
├── cleaning.R         # General cleaning
├── aggregation.R      # Summarizing step/sleep data
└── merging.R          # Joining datasets
```

---

## Tools Used

- **R**: Main tool for cleaning and transformation
- **dplyr**: Used for filtering, renaming, grouping
- **readr**: For importing large CSVs efficiently
- **Excel**: Spot-checking for anomalies

---

## Final Check

```r
summary(daily_activity)
any(is.na(daily_activity))
```

--- -->