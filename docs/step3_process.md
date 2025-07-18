# Step 3: Process Data

This step involves cleaning, transforming, and preparing the data for further analysis.

---

## 1. Data Cleaning Steps

### Performed in R (with dplyr)

#### Tasks Completed:

- Removed duplicates
- Renamed columns for clarity
- Standardized date formats
- Aggregated minute/hour data into daily summaries (where needed)
- Removed records with missing or unrealistic values

#### Example:
```r
library(dplyr)
library(readr)

# Load daily activity data
daily_activity <- read.csv("data/raw-data/dailyActivity_merged.csv")

# Remove duplicates
daily_activity <- daily_activity[!duplicated(daily_activity), ]

# Clean column names
daily_activity <- daily_activity %>%
  rename(
    Date = ActivityDate,
    Steps = TotalSteps,
    Calories = Calories
  )

# Check missing values
colSums(is.na(daily_activity))
```

---

## 2. Data Aggregation Examples

Merged and aggregated:
- **Hourly → Daily steps**: summed by user/date
- **Heart rate (seconds) → daily average/max**
- **Minute METs → total MET per day**

```r
hourly_steps <- read.csv("data/raw-data/hourlySteps_merged.csv")

daily_steps <- hourly_steps %>%
  group_by(Id, Date = as.Date(ActivityHour)) %>%
  summarize(DailySteps = sum(StepTotal))
```

---

## 3. Processed Outputs

Stored cleaned and transformed datasets here:

```
data/
└── processed-data/
    ├── daily_activity_clean.csv
    ├── daily_steps_aggregated.csv
    └── merged_activity_sleep.csv
```

---

## 4. Script Repository

All data cleaning steps are documented in:

```
scripts/
├── cleaning.R         # General cleaning
├── aggregation.R      # Summarizing step/sleep data
└── merging.R          # Joining datasets
```

---

## Tools Used

- **R**: Main tool for cleaning and transformation
- **dplyr**: Used for filtering, renaming, grouping
- **readr**: For importing large CSVs efficiently
- **Excel**: Spot-checking for anomalies

---

## Final Check

```r
summary(daily_activity)
any(is.na(daily_activity))
```

---

🔗 **[← Back to Step 2: Prepare](step2_prepare.md) | 🔜 **[Next: Step 4: Analyze →](step4_analyze.md)**

---

© [2025] [Yi-Hsuan Chiang].  
This work is licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](https://creativecommons.org/licenses/by-nc/4.0/).