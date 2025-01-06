# Zomato Data Exploration and Analysis with SQL (SQL Server)

## Project Overview
This project explores and analyzes the Zomato dataset using SQL Server to uncover insights into the restaurant industry. The dataset includes over 9,000 rows with details like restaurant names, locations, cuisines, ratings, and more.

## Key Features
- Data cleaning: Identified and handled duplicates, removed unwanted columns, and corrected misspelled city names.
- Table merging: Combined data from two tables, adding a new `Country_Name` column using the `CountryCode`.
- Exploratory analysis: Applied window functions and aggregate calculations to explore restaurant distribution, ratings, and online delivery options.
- Insights derived:
  - 90.67% of data is related to Indian restaurants.
  - Only 28.01% of Indian restaurants offer online delivery.
  - Connaught Place (New Delhi) has the most listed restaurants (122).
  - The best moderately priced restaurant in Kolkata, India, is identified.

## SQL Techniques Used
- **Data Cleaning**: Duplicate removal, data type checks, and misspelling correction.
- **Window Functions**: Rolling count/moving count of restaurants.
- **Aggregates**: Calculations for min, max, and average on various columns (e.g., ratings, votes).
- **Joins**: Merged data from two tables based on `CountryCode`.
  
## Technologies
- **SQL Server** for data processing and analysis.

## Getting Started
1. Clone this repository.
2. Import the dataset into SQL Server.
3. Run the provided SQL scripts for data cleaning and analysis.
