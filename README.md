# Iowa Liquor Analytics Project

## Project Tasks Status: 

### Data Preparation
- [x] Separate Incorrect/Missing Yearly Data from Correct Yearly Data
- [x] Data cleaning of incorrect data
- [x] Merge newly cleaned data with original cleaned data
- [x] Separate remaining data into csv for later cleaning
- [x] Prepare Yearly Iowa County Population Data for per capita consumption anaylsis

### SQL Database
- [x] Establish connection between Linux environment and local MySQL Desktop
- [x] Import Data into MySQL Database using batch processing
- [x] Extract data subsets as .txt files to for dashboard building in Tableau

### Dashboard Building
- [ ] County Per Capita Consumption Visualization Completed
- [ ] Other visualizations to be determined
- [ ] Publish Dashboards

## Table of Contents

1. [Project Description](#project-description)
2. [Example Visualizations](#visuals)
3. [Links](#links)

<a name="project-description"></a>
## Project Description

The goal of this project was to clean and analyze a large publicly available dataset using techniques in Python, SQL, and Tableau. For this endeavor, I chose the [Sales Data from Iowa Class “E” liquor licensees](https://data.iowa.gov/Sales-Distribution/Iowa-Liquor-Sales/m3tr-qhgy/about_data) dataset from data.iowa.gov, which details all the liquor sales in Iowa from January 2012 through the end of September 2023, since I downloaded this data in early November of 2023. 

This dataset was very large at 27489743 values. Upon downloading the data, over 20% of the rows had missing values. Compounding this was a large number of rows with mismatched and incorrect data types. For rows without mismatched datatypes and missing values, a large number contained incorrect values as well. Thus, a cleaning the data was a massive undertaking. It soon became apparent that cleaning 100% of this data was not going to be possible given time constraints and my sanity as many errors were very granular in nature. My goal was to have over 99% of this dataset cleanred prior to building visualizations. After an intensive effort, I reduced the number of missing values down to only 0.96%. In addition, data corrections (such as frequent misspellings and mismatched data types) was completed by a methodical process. The steps by which I cleaned the data can be followed by sequentially reading the data_preprocess files in the data folder. However, due to the size of the data, I cannot fully guaruntee 100% accuracy in my process, though I am extremely confident that my effort represents a significant improvement. Despite this, I urge caution when interpreting the visualizations




