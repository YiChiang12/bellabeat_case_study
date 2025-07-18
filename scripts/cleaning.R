# Data Cleaning Script
library(dplyr)
library(readr)

# Load daily activity data
daily_activity <- read_csv("data/raw_data/dailyActivity_merged.csv")

# Remove duplicates
daily_activity <- daily_activity %>% distinct()

# Rename and select key columns
daily_activity <- daily_activity %>%
  rename(
    Date = ActivityDate,
    Steps = TotalSteps,
    Distance = TotalDistance,
    SedentaryMinutes = SedentaryMinutes,
    Calories = Calories
  )

# Check missing values
colSums(is.na(daily_activity))

# Save cleaned dataset
write_csv(daily_activity, "data/processed_data/daily_activity_clean.csv")
