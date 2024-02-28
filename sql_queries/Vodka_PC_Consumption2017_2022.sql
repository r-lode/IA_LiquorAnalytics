/*

Query to generate per capita vodka consumption from liquor sales data for years 2017 to 2022..
Unfortunately, I could not optimize the create table statement further due to the large volume of data. 
Batch processing was attempted, but resulted in crashing connection. However, the current file runs in
less than 27 seconds and produces correct results.

*/


-- create table displaying only vodka sales

USE ia_liquor;

CREATE TABLE vodka_sales_2017_to_2022 AS
SELECT
    County_Number,
    County,
    YEAR(Date) AS Year,
    Round(SUM(Sale_Dollars), 2) AS Total_Sales, -- total sales dollars column
    Round(SUM(Volume_Sold_Liters), 2) AS Total_Volume_Sold_Liters -- total sales in liters column
FROM (
    SELECT
        County_Number,
        County,
        Date,
        Sale_Dollars,
        Volume_Sold_Liters
    FROM liquor_sales_2017
    WHERE Vodka = 1

    UNION ALL -- union all statements combining different years

    SELECT
        County_Number,
        County,
        Date,
        Sale_Dollars,
        Volume_Sold_Liters
    FROM liquor_sales_2018
    WHERE Vodka = 1
    
    UNION ALL 
    
	SELECT
        County_Number,
        County,
        Date,
        Sale_Dollars,
        Volume_Sold_Liters
    FROM liquor_sales_2019
    WHERE Vodka = 1
    
	UNION ALL 
    
	SELECT
        County_Number,
        County,
        Date,
        Sale_Dollars,
        Volume_Sold_Liters
    FROM liquor_sales_2020
    WHERE Vodka = 1
    
	UNION ALL 
    
	SELECT
        County_Number,
        County,
        Date,
        Sale_Dollars,
        Volume_Sold_Liters
    FROM liquor_sales_2021
    WHERE Vodka = 1
    
    UNION ALL 
    
	SELECT
        County_Number,
        County,
        Date,
        Sale_Dollars,
        Volume_Sold_Liters
    FROM liquor_sales_2022
    WHERE Vodka = 1

)  as combined_sales
GROUP BY
    County_Number, County, Year
ORDER BY
    County_Number, Year;
    

-- NOTE no county population data for 2023 yet
-- add foreign key
ALTER TABLE vodka_sales_2017_to_2022
	ADD CONSTRAINT fk_population_data
	FOREIGN KEY (County_Number, Year)
		REFERENCES county_population_data (County_Number, Year);

-- add population column
ALTER TABLE vodka_sales_2017_to_2022
ADD Population INT;

-- update population column with relevant info
UPDATE vodka_sales_2017_to_2022 as sales
	JOIN county_population_data Population
		ON sales.County_Number = population.County_Number AND sales.Year = population.Year
	SET sales.Population = population.Population;


-- add Per_Capita_Consumption column 
ALTER TABLE vodka_sales_2017_to_2022
ADD Per_Capita_Consumption FLOAT; 
-- update Per_Capita_Consumption column with calculated values
UPDATE vodka_sales_2017_to_2022
	SET Per_Capita_Consumption = IFNULL(Total_Volume_Sold_Liters / NULLIF(Population, 0), 0);