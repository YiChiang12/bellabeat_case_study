library(tidyverse)

# Load cleaned activity and sleep data
daily_activity <- read_csv("data/processed_data/daily_activity_clean.csv")
daily_sleep <- read_csv("data/processed_data/daily_sleep_clean.csv")

# Merge on id and date
activity_sleep_merged <- inner_join(daily_activity, daily_sleep, by = c("id", "date"))

# Export
write_csv(activity_sleep_merged, "data/processed_data/merged_activity_sleep.csv")
