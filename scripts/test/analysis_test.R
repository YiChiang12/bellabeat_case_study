# Too identify user trends
library(tidyverse)
library(lubridate)
library(ggplot2)
library(scales)

# Load data
daily_activity <- read_csv("data/processed_data/daily_activity_clean.csv")
daily_sleep <- read_csv("data/processed_data/daily_sleep_clean.csv")
merged <- read_csv("data/processed_data/merged_activity_sleep.csv")
hourly_steps <- read_csv("data/processed_data/hourly_steps_clean.csv")

# 1. Daily averages per user
daily_avg <- merged %>%
  group_by(id) %>%
  summarise(
    avg_steps = mean(total_steps),
    avg_calories = mean(calories),
    avg_sleep = mean(total_minutes_asleep)
  )

# 2. Classify users by activity level
step_levels <- daily_avg %>%
  mutate(activity_level = case_when(
    avg_steps < 5000 ~ "Sedentary",
    avg_steps < 7500 ~ "Lightly Active",
    avg_steps < 10000 ~ "Fairly Active",
    TRUE ~ "Very Active"
  ))

# Plot distribution
ggplot(step_levels, aes(x = activity_level, fill = activity_level)) +
  geom_bar() +
  labs(title = "User Activity Level Distribution", x = "", y = "User Count") +
  theme_minimal()

# 3. Steps and sleep by weekday
weekday_stats <- merged %>%
  mutate(weekday = wday(date, label = TRUE)) %>%
  group_by(weekday) %>%
  summarise(
    avg_steps = mean(total_steps),
    avg_sleep = mean(total_minutes_asleep)
  )

# Plot steps and sleep
ggplot(weekday_stats, aes(x = weekday)) +
  geom_col(aes(y = avg_steps), fill = "#4CAF50") +
  labs(title = "Average Daily Steps by Weekday", y = "Steps", x = "")

ggplot(weekday_stats, aes(x = weekday)) +
  geom_col(aes(y = avg_sleep), fill = "#2196F3") +
  labs(title = "Average Minutes Asleep by Weekday", y = "Minutes", x = "")

# 4. Correlations
ggplot(merged, aes(x = total_steps, y = calories)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Steps vs Calories Burned")

ggplot(merged, aes(x = total_steps, y = total_minutes_asleep)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "loess", color = "purple") +
  labs(title = "Steps vs Minutes Asleep")

# 5. Hourly step pattern
hourly_steps_summary <- hourly_steps %>%
  mutate(hour = hour(date_time)) %>%
  group_by(hour) %>%
  summarise(avg_steps = mean(step_total))

ggplot(hourly_steps_summary, aes(x = hour, y = avg_steps)) +
  geom_line(color = "darkorange", size = 1.2) +
  labs(title = "Average Steps by Hour", x = "Hour of Day", y = "Steps") +
  scale_x_continuous(breaks = 0:23)

# 6. Device usage frequency
usage_days <- merged %>%
  group_by(id) %>%
  summarise(days_used = n()) %>%
  mutate(usage_group = case_when(
    days_used >= 21 ~ "High",
    days_used >= 11 ~ "Moderate",
    days_used > 0 ~ "Low"
  ))

ggplot(usage_days, aes(x = usage_group, fill = usage_group)) +
  geom_bar() +
  labs(title = "Device Usage Frequency", x = "Usage Group", y = "Number of Users") +
  theme_minimal()
