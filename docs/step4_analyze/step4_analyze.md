---
layout: default
title: Analyze
permalink: /step4_analyze/
---

# Step 4: Analyze

This step focuses on analyzing the cleaned Fitbit data to uncover trends and behaviors that can guide Bellabeat's marketing strategy.

---

## 1. Objective

Analyze user activity, sleep, and usage patterns from the Fitbit dataset. Identify any important trends in behavior and correlations that could translate into Bellabeat app feature improvements or engagement strategies.

---

## 2. Key Questions

- What is the average step count, calorie burn, and sleep time per user?
- How do these behaviors change across weekdays?
- What is the correlation between steps and calories burned?
- How do users vary in their usage intensity and step activity level?

---

## 3. Summary Statistics

- Daily average steps, calories, and sleep by user
- Percentage of users in step categories: sedentary, lightly active, fairly active, very active
- Daily device usage counts

---

## 4. Trends by Weekday

- Steps per weekday
- Minutes asleep per weekday
- Create visualizations of these trends using `ggplot2`

---

## 5. Correlation Analysis

- Steps vs Calories burned (scatter plot + correlation coefficient)
- Steps vs Sleep (scatter plot)

---

## 6. Hourly Step Patterns

- Aggregate steps by hour across all users and dates
- Plot a chart to show peak activity windows (e.g., mornings, lunch, evening)

---

## 7. User Classification

- Classify users into activity levels by their average daily steps:
  - Sedentary: < 5000
  - Lightly active: 5000–7499
  - Fairly active: 7500–9999
  - Very active: 10000+

- Visualize distribution as a bar chart

---

## 8. Device Usage Frequency

- Count how many days each user wore the device
- Categorize into:
  - High use: 21–31 days
  - Moderate use: 11–20 days
  - Low use: 1–10 days

- Visualize with bar chart chart

---

## 9. Export Insights

Summarize insights in a format suitable for Bellabeat’s marketing team:
- Key behavior patterns
- Actionable findings for app notifications or incentives
- Recommended feature enhancements based on usage timing

---

<!-- 🔗 **[← Back to Step 3: Process](../step3_process/)** | 🔜 **[Next: Step 5: Share →](../step5_share/)** -->

<div style="display: flex; justify-content: space-between;">
  <span>🔗 <a href="../step3_process/">← Back to Step 3: Process</a></span>
  <span>🔜 <a href="../step5_share/">Next: Step 5: Share →</a></span>
</div>

---

© [2025] [Yi-Hsuan Chiang]  
Licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)