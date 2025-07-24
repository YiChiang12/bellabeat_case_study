library(tidyverse)
library(lubridate)

# Load cleaned hourly steps
hourly_steps <- read_csv("data/processed_data/hourly_steps_clean.csv")

# Aggregate hourly to daily
daily_steps <- hourly_steps %>%
  mutate(date = as_date(date_time)) %>%
  group_by(id, date) %>%
  summarize(daily_steps = sum(step_total, na.rm = TRUE), .groups = "drop")

write_csv(daily_steps, "data/processed_data/daily_steps_aggregated.csv")
