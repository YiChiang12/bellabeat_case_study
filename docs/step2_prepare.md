# Step 2: Prepare Data

The preparation phase involves identifying and collecting relevant data, ensuring credibility, and understanding the dataset structure.

---

## 1. Data Sources

The primary datasets used in this analysis are sourced from **Fitbit Fitness Tracker Data (Fitabase)**, publicly available on [Kaggle](https://www.kaggle.com/datasets/arashnic/fitbit) under CC0: Public Domain license.

The datasets cover activity tracked by Fitbit devices from **33 unique users** over a period between **March and May 2016**.

---

## 2. Dataset Overview

### FitabaseData_3.12.16-4.11.16 folder
| File Name                         | Description                               | Format        | Size    |
|-----------------------------------|-------------------------------------------|---------------|---------|
| `dailyActivity_merged.csv`        | Daily activity summaries                  | Long format   | Moderate|
| `heartrate_seconds_merged.csv`    | Heart rate data recorded every second     | Long format   | Large   |
| `hourlyCalories_merged.csv`       | Calories burned hourly                    | Long format   | Moderate|
| `hourlyIntensities_merged.csv`    | Intensity of activities hourly            | Long format   | Moderate|
| `hourlySteps_merged.csv`          | Steps counted hourly                      | Long format   | Moderate|
| `minuteCaloriesNarrow_merged.csv` | Minute-by-minute calories data            | Long format   | Large   |
| `minuteIntensitiesNarrow_merged.csv`| Minute-by-minute activity intensities   | Long format   | Large   |
| `minuteMETsNarrow_merged.csv`     | Minute-by-minute METs data                | Long format   | Large   |
| `minuteSleep_merged.csv`          | Minute-level sleep tracking               | Long format   | Moderate|
| `minuteStepsNarrow_merged.csv`    | Steps counted every minute                | Long format   | Large   |
| `weightLogInfo_merged.csv`        | Logged body weight info                   | Long format   | Small   |

### FitabaseData_4.12.16-5.12.16 folder
Additional files with similar content (April-May data).

---

## 3. Data Credibility and Integrity Check (ROCCC criteria)

| Criteria      | Check ✅ | Notes                                  |
|---------------|----------|----------------------------------------|
| Reliable      | ✅       | Official Fitbit data from Kaggle       |
| Original      | ✅       | Original collection via Fitabase       |
| Comprehensive | ✅       | Covers multiple wellness metrics       |
| Current       | ⚠️       | Data from 2016, not current            |
| Cited         | ✅       | Clearly cited and CC0 Public Domain    |

**Assessment:** Data reliable and original, but somewhat dated (2016). Still suitable for behavioral trend analysis.

---

### Limitations and Sampling Bias

While the dataset provides valuable insights into user behavior, it has several limitations. With data from only 33 users and no accompanying demographic details, the sample may not accurately reflect the broader population, raising concerns about representativeness. Additionally, the data is from 2016 and spans just two months, which limits its relevance to current trends. Because of these constraints, this case study is treated as an analytical exercise to demonstrate process and methodology, rather than to make generalized claims about today’s smart device users.

---

## 4. Initial Data Exploration Steps
Perform initial exploration using spreadsheet (Excel/Google Sheets) and R:

- Verify data files loaded correctly.
- Check for missing or null values.
- Check unique user IDs across datasets.
- Review date/time formats consistency.

Example initial exploration in R:
```r
# Load a dataset for preliminary exploration
daily_activity <- read.csv("dailyActivity_merged.csv")
summary(daily_activity)
str(daily_activity)
```

---

🔗 **[← Back to Step 1: Ask](step1_ask.md)** | 🔜 **[Next: Step 3: Process →](step3_process.md)**

---

© [2025] [Yi-Hsuan Chiang]  
Licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)