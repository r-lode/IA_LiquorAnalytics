USE ia_liquor;

DROP PROCEDURE IF EXISTS drop_vodka_sales_if_exists;

DELIMITER //

CREATE PROCEDURE drop_vodka_sales_if_exists()
BEGIN
  DECLARE table_exists BOOLEAN;

  SELECT EXISTS(SELECT 1 FROM information_schema.tables WHERE table_name = 'vodka_sales_2017_to_2022') INTO table_exists;

  IF table_exists THEN
    ALTER TABLE `vodka_sales_2017_to_2022` DROP CONSTRAINT `fk_population_data`;
    DROP TABLE `vodka_sales_2017_to_2022`;
  END IF;
END;

CALL drop_vodka_sales_if_exists();

CREATE TABLE vodka_sales_2017_to_2022 AS
SELECT
    County_Number,
    County,
    YEAR(Date) AS Year,
    Round(SUM(Sale_Dollars), 2) AS Total_Sales,
    Round(SUM(Volume_Sold_Liters), 2) AS Total_Volume_Sold_Liters
FROM (
    SELECT
        County_Number,
        County,
        Date,
        Sale_Dollars,
        Volume_Sold_Liters
    FROM liquor_sales_2017
    WHERE Vodka = 1

    UNION ALL

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

    
) AS combined_sales
GROUP BY
    County_Number, County, Year
ORDER BY
    Total_Sales DESC;
    

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