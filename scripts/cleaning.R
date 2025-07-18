library(tidyverse)
library(janitor)
library(lubridate)

# Load raw data from project root
daily_activity <- read_csv("data/raw_data/4.12.16-5.12.16/dailyActivity_merged.csv")
daily_sleep <- read_csv("data/raw_data/4.12.16-5.12.16/sleepDay_merged.csv")
hourly_steps <- read_csv("data/raw_data/4.12.16-5.12.16/hourlySteps_merged.csv")

# Clean column names
daily_activity <- daily_activity %>% clean_names()
daily_sleep <- daily_sleep %>% clean_names()
hourly_steps <- hourly_steps %>% clean_names()

# Rename & format date columns
daily_activity <- daily_activity %>%
  rename(date = activity_date) %>%
  mutate(date = mdy(date))

daily_sleep <- daily_sleep %>%
  rename(date = sleep_day) %>%
  mutate(date = as_date(mdy_hms(date)))

hourly_steps <- hourly_steps %>%
  rename(date_time = activity_hour) %>%
  mutate(date_time = mdy_hms(date_time))

# Remove duplicates and missing values
daily_activity <- daily_activity %>% distinct() %>% drop_na()
daily_sleep <- daily_sleep %>% distinct() %>% drop_na()
hourly_steps <- hourly_steps %>% distinct() %>% drop_na()

# Export cleaned datasets
write_csv(daily_activity, "data/processed_data/daily_activity_clean.csv")
write_csv(daily_sleep, "data/processed_data/daily_sleep_clean.csv")
write_csv(hourly_steps, "data/processed_data/hourly_steps_clean.csv")
