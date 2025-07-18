# Merging activity and sleep data
library(dplyr)
library(readr)

# Load cleaned activity data
activity <- read_csv("data/processed_data/daily_activity_clean.csv")

# Load sleep data
sleep <- read_csv("data/raw_data/minuteSleep_merged.csv")

# Aggregate sleep by day
sleep_summary <- sleep %>%
  mutate(Date = as.Date(EndTime)) %>%
  group_by(Id, Date) %>%
  summarize(TotalMinutesAsleep = sum(Value, na.rm = TRUE))

# Merge with activity data
merged_data <- left_join(activity, sleep_summary, by = c("Id", "Date"))

# Save merged dataset
write_csv(merged_data, "data/processed_data/merged_activity_sleep.csv")
