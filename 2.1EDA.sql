-- EDA

select * from properties_cleaned limit 10

-- Count total rows
SELECT COUNT(*) AS total_properties -- 510
FROM properties_cleaned;

-- Check for duplicates 
SELECT "property name", COUNT(*) -- 0 Ok
FROM properties_cleaned 
GROUP BY "property name" 
HAVING COUNT(*) > 1;

-- Count NULLs per key column properties data - Ok
SELECT 
  COUNT(*) FILTER (WHERE "monthly rent per unit" IS NULL) AS monthly_rent_per_unit,
  COUNT(*) FILTER (WHERE "most recent noi" IS NULL) AS most_recent_noi,
  COUNT(*) FILTER (WHERE "appraised value" IS NULL) AS appraised_value
FROM properties_cleaned;

-- Count NULLs per key column demographic data - Ok
SELECT 
	COUNT(*) FILTER (WHERE household_Income_median IS NULL) AS household_Income_median
FROM demographics_us_raw

-- Check outliers

-- monthly rent per unit summary
SELECT 
  MIN("monthly rent per unit") AS min_rent,
  MAX("monthly rent per unit") AS max_rent,
  AVG("monthly rent per unit") AS avg_rent
FROM properties_cleaned;

-- most recent noi summary
SELECT 
  MIN("most recent noi") AS min_rent,
  MAX("most recent noi") AS max_rent,
  AVG("most recent noi") AS avg_rent
FROM properties_cleaned;


-- household_Income_median summary
SELECT 
  MIN(household_Income_median) AS min_rent,
  MAX(household_Income_median) AS max_rent,
  AVG(household_Income_median) AS avg_rent
FROM demographics_us_raw;

