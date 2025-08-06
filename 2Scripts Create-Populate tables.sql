-- Create table with necessary fields

CREATE TABLE properties_raw (
    "property name" TEXT,
    "property city" TEXT,
    "property state" TEXT,
    "zip code" TEXT,
    "property type" TEXT,
    "property subtype" TEXT,
    "year built" TEXT,
    "total units" INT,
    "occupancy %" NUMERIC,
    "monthly rent per unit" NUMERIC,
    "uw noi" NUMERIC,
    "most recent noi" NUMERIC,
    "appraised value" NUMERIC,
    "latitude" NUMERIC,
    "longitude" NUMERIC
);

-- Create table cleaned

CREATE TABLE properties_cleaned (
    "property name" TEXT,
    "property city" TEXT,
    "property state" TEXT,
    "zip code" TEXT,
    "property type" TEXT,
    "property subtype" TEXT,
    "year built" TEXT,
    "total units" INT,
    "occupancy %" NUMERIC,
    "monthly rent per unit" NUMERIC,
    "uw noi" NUMERIC,
    "most recent noi" NUMERIC,
    "appraised value" NUMERIC,
    "latitude" NUMERIC,
    "longitude" NUMERIC
);

select * from properties_raw limit 10

-- Populate table casted fields

INSERT INTO properties_cleaned (
    "property name",
    "property city",
    "property state",
    "zip code",
    "property type",
    "property subtype",
    "year built",
    "total units",
    "occupancy %",
    "monthly rent per unit",
    "uw noi",
    "most recent noi",
    "appraised value",
    "latitude",
    "longitude"
)
SELECT
    "property name",
    "property city",
    "property state",
    "zip code",
    "property type",
    "property subtype",
    "year built",
    CAST("total units" AS INT),
    CAST("occupancy %" AS NUMERIC),
    CAST("monthly rent per unit" AS NUMERIC),
    CAST("uw noi" AS NUMERIC),
    CAST("most recent noi" AS NUMERIC),
    CAST("appraised value" AS NUMERIC),
    CAST(latitude AS NUMERIC),
    CAST(longitude AS NUMERIC)
FROM
    properties_raw;

	select * from properties_cleaned limit 10

-- Create demographic table with only necessary columns

CREATE TABLE demographics_us_raw (
    state_code INTEGER PRIMARY KEY,
    gross_rent_median NUMERIC,
    household_income_median NUMERIC,
    housing_units_occupancy_status_total_count INTEGER,
    housing_units_occupied_count INTEGER
);


select * from demographics_us_raw limit 10

-- Create mapping table states_codes_mapping

CREATE TABLE states_codes_mapping (
    state_name VARCHAR(100),
    adm_1_code_letters VARCHAR(2) PRIMARY KEY,  
    adm_1_code INTEGER
);




	




