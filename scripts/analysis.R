library(tidyverse)
library(lubridate)
library(ggplot2)
library(scales)

# Load processed data
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

# Set factor level order for proper bar plot ordering
step_levels$activity_level <- factor(step_levels$activity_level,
                                     levels = c("Sedentary", "Lightly Active", "Fairly Active", "Very Active"))

# Plot activity level distribution
ggplot(step_levels, aes(x = activity_level, fill = activity_level)) +
  geom_bar() +
  scale_fill_manual(values = c(
    "Sedentary" = "#c2e0e2",
    "Lightly Active" = "#8ec4e0",
    "Fairly Active" = "#1f78b4",
    "Very Active" = "#08306b"
  )) +
  labs(title = "User Activity Level Distribution", x = "Activity Level", y = "User Count") +
  theme_minimal() +
  theme_minimal()

# 3. Steps and sleep by weekday
weekday_stats <- merged %>%
  mutate(weekday = wday(date, label = TRUE)) %>%
  group_by(weekday) %>%
  summarise(
    avg_steps = mean(total_steps),
    avg_sleep = mean(total_minutes_asleep)
  )

# Combine into grouped bar chart
weekday_long <- weekday_stats %>%
  pivot_longer(cols = c(avg_steps, avg_sleep), names_to = "metric", values_to = "value")

ggplot(weekday_long, aes(x = weekday, y = value, fill = metric)) +
  geom_col(position = "dodge") +
  labs(title = "Average Steps and Sleep by Weekday", x = "", y = "") +
  scale_fill_manual(values = c("avg_steps" = "#4CAF50", "avg_sleep" = "#2196F3"),
                    labels = c("Steps", "Sleep")) +
  theme_minimal()

# 4. Correlation plots
ggplot(merged, aes(x = total_steps, y = calories)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Steps vs Calories Burned", x = "Total Steps", y = "Calories Burned") +
  theme_minimal()

ggplot(merged, aes(x = total_steps, y = total_minutes_asleep)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "loess", color = "purple") +
  labs(title = "Steps vs Minutes Asleep", x = "Total Steps", y = "Minutes Asleep") +
  theme_minimal()

# 5. Hourly step pattern
hourly_steps_summary <- hourly_steps %>%
  mutate(hour = hour(date_time)) %>%
  group_by(hour) %>%
  summarise(avg_steps = mean(step_total))

ggplot(hourly_steps_summary, aes(x = hour, y = avg_steps)) +
  geom_line(color = "darkorange", size = 1.2) +
  geom_point(color = "black", size = 1) +
  geom_vline(xintercept = hourly_steps_summary$hour[which.max(hourly_steps_summary$avg_steps)],
             linetype = "dashed", color = "grey50") +
  labs(title = "Average Steps by Hour", x = "Hour of Day", y = "Steps") +
  scale_x_continuous(breaks = 0:23) +
  theme_minimal()

# 6. Device usage frequency
usage_days <- merged %>%
  group_by(id) %>%
  summarise(days_used = n()) %>%
  mutate(usage_group = case_when(
    days_used >= 21 ~ "High",
    days_used >= 11 ~ "Moderate",
    days_used > 0 ~ "Low"
  ))

usage_days$usage_group <- factor(usage_days$usage_group, levels = c("Low", "Moderate", "High"))

ggplot(usage_days, aes(x = usage_group, fill = usage_group)) +
  geom_bar() +
  scale_fill_manual(values = c(
    "Low" = "#d9f0a3",
    "Moderate" = "#78c679",
    "High" = "#238443"
  )) +
  labs(title = "Device Usage Frequency", x = "Usage Group", y = "Number of Users") +
  theme_minimal() +
  theme_minimal()
