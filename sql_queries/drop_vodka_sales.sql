/*
Stored procedure to used to drop vodka_sales table. Foreign key constraint must
be dropped prior to executing drop.
*/

USE ia_liquor;

DROP PROCEDURE IF EXISTS drop_vodka_sales_if_exists;

DELIMITER //

-- procedure to drop vodka sales table

CREATE PROCEDURE drop_vodka_sales_if_exists()
BEGIN
  DECLARE table_exists BOOLEAN;

  SELECT EXISTS(SELECT 1 FROM information_schema.tables WHERE table_name = 'vodka_sales_2017_to_2022') INTO table_exists;

  IF table_exists THEN
    ALTER TABLE `vodka_sales_2017_to_2022` DROP CONSTRAINT `fk_population_data`; -- foreign key constraint must be dropped prior to dropiing table
    DROP TABLE `vodka_sales_2017_to_2022`;
  END IF;
END;

CALL drop_vodka_sales_if_exists();
