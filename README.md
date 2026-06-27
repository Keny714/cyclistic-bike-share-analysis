# Google Data Analytics Capstone: Cyclistic Case Study

## Introduction
In this case study, I perform the real-world tasks of a junior data analyst at a fictional bike-share company, Cyclistic. To answer the key business questions and drive marketing decisions, I followed the six steps of the data analysis process: **Ask, Prepare, Process, Analyze, Share, and Act.**

### Quick Links:
*   **Data Visualization:** [Interactive Tableau Dashboard](https://public.tableau.com/app/profile/keny.patel8268/viz/Cyclistic2025/Dashboard1)
*   **SQL Queries:**
    *   [01. Data Setup & Combining](01_data_setup_and_combining.sql)
    *   [02. Data Cleaning](02_data_cleaning.sql)
    *   [03. Data Analysis](03_data_analysis.sql)
    *   [04. Insights & Recommendations](04_insights_and_recommendations.md)

---

## Background
**Cyclistic** is a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive. 

Cyclistic’s marketing strategy has historically relied on building general awareness and appealing to broad consumer segments using flexible pricing: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as **Casual Riders**. Customers who purchase annual memberships are **Cyclistic Members**.

Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. The Director of Marketing believes that maximizing the number of annual members will be key to future growth. Rather than targeting all-new customers, there is a very good chance to convert existing casual riders into members. 

## Scenario
I am a junior data analyst working on the marketing analyst team at Cyclistic. My team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, we will design a new marketing strategy to convert casual riders into annual members. These recommendations must be backed up with compelling data insights and professional data visualizations.

---

## 1. Ask
**Business Task:** Devise marketing strategies to convert casual riders to annual members.

**Analysis Questions:**
1. How do annual members and casual riders use Cyclistic bikes differently? *(Primary Focus)*
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

---

## 2. Prepare
**Data Source:** 
I used Cyclistic’s historical trip data from **January 2025 to December 2025**. The data has been made available by Motivate International Inc. under a public license. 

Personal identifiable information (PII) has been removed for privacy. The original dataset consists of 12 separate CSV files (one for each month) containing over **5.5 million rows** of data. Key columns include ride ID, bike type, start/end times, and station names.

---

## 3. Process
Because Microsoft Excel has a strict row limit of 1,048,576 rows, it is incapable of managing this 5.5 million row dataset. Therefore, **PostgreSQL** (via pgAdmin 4) was used to process, combine, and clean the massive volumes of data.

**Data Combining:**
The 12 CSV files were imported as individual tables and merged into a single master table using the `UNION ALL` function.

**Data Cleaning:**
Using Common Table Expressions (CTEs), the raw data was cleaned to ensure accuracy:
*   Created a new `ride_duration` column by subtracting the start time from the end time.
*   Extracted `month_name` and `day_name` into distinct columns for time-series analysis.
*   Removed anomalies: Trips with a duration of less than 1 minute (false starts) or greater than 24 hours (unreturned bikes) were deleted.
*   Removed rows with `NULL` station names.
*   **Result:** The fully cleaned database resulted in exactly **3,661,540 highly accurate rides** ready for analysis.

---

## 4. Analyze and Share
The cleaned dataset was analyzed using complex SQL aggregations and exported to **Tableau** for data visualization. 

### Bike Preference
While both groups heavily prefer classic bikes, **Electric bikes** make up nearly half of all rides (1.7 million). 

### Seasonality (Months)
When observing monthly trips, both casual riders and members exhibit comparable behavior: ridership drops in the winter and spikes in the summer. However, **Casual ridership explodes in July and August**, nearly matching or overtaking member volume during peak tourism season.

### Days of the Week
When days of the week are compared, it is discovered that **Casual riders make significantly more journeys on the weekends** (Saturday and Sunday). Conversely, **Annual Members show a distinct decline over the weekend**, preferring to ride Monday through Friday.

### Hours of the Day (The Commuter Trend)
Analyzing the exact hour of the day reveals the starkest contrast in behavior:
*   **Annual Members** show two massive peaks throughout the day: exactly at **8:00 AM** and **5:00 PM**. 
*   **Casual Riders** do not have a morning peak. Their ridership increases consistently throughout the day, peaking at 5:00 PM before tapering off.
*   *Conclusion:* Members use the bikes for traditional 9-to-5 commuting, while Casuals use them for afternoon leisure.

### Ride Duration
Casual riders travel for almost **twice as long** as Annual Members. 
*   Casual Average Ride: **22.46 minutes**
*   Member Average Ride: **12.42 minutes**

### Popular Routes & Stations
The Top 10 most popular routes for Casual riders are overwhelmingly located along the Chicago coastline, near museums, parks, and Navy Pier. Notably, the #1 most popular route in the city is a round-trip starting and ending at *DuSable Lake Shore Dr & Monroe St*. Members, on the other hand, start and end their trips near inland transit hubs, universities, and commercial districts (e.g., *Clinton St & Washington Blvd*).

---

## 5. Summary

| Metric | Casual Riders | Annual Members |
| :--- | :--- | :--- |
| **Purpose** | Leisure and tourism. | Daily commuting to work or school. |
| **Peak Days** | Weekends (Saturday & Sunday). | Weekdays (Monday - Friday). |
| **Peak Hours** | Afternoons (Peaks at 5:00 PM). | Rush Hours (8:00 AM and 5:00 PM). |
| **Duration** | Long, leisurely trips (~22.5 mins). | Short, targeted trips (~12.4 mins). |
| **Locations** | Coastal parks, museums, and beaches. | Inland transit hubs and commercial areas. |

---

## 6. Act (Recommendations)
Based on the data insights, I recommend the following three marketing strategies to convert Casual Riders into Annual Members:

1.  **Launch a "Weekend Warrior" Pass:** Since casual riders overwhelmingly prefer weekends, the current 7-day Annual Pass is not appealing to them. Cyclistic should introduce a discounted Annual Pass that only grants unlimited rides on Saturdays and Sundays.
2.  **Highlight the "Leisure Tax" in Ads:** Casual riders ride for nearly twice as long as members, meaning they are paying high per-minute fees. Digital ads should target this financial pain point: *"Did you know your weekend rides cost you $X last month? An Annual Pass pays for itself in just 3 weekends."*
3.  **Geo-Target Coastal Advertising:** Since casual riders strictly cluster around Navy Pier and Lake Shore Drive, Cyclistic should concentrate physical advertising (billboards and station wraps) exclusively at these Top 10 coastal stations during the summer months, rather than spending money inland.
