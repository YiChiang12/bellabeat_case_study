# Aggregating minute and hourly data
library(dplyr)
library(readr)
library(lubridate)

# Load hourly steps data
hourly_steps <- read_csv("data/raw_data/hourlySteps_merged.csv")

# Convert date
hourly_steps <- hourly_steps %>%
  mutate(Date = as.Date(ActivityHour)) %>%
  group_by(Id, Date) %>%
  summarize(DailySteps = sum(StepTotal, na.rm = TRUE))

# Save to CSV
write_csv(hourly_steps, "data/processed_data/daily_steps_aggregated.csv")
