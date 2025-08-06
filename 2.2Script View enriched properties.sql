-- Create view with all the data available

CREATE OR REPLACE VIEW enriched_properties AS
SELECT
    p.*,
    d.gross_rent_median,
    d.household_income_median,
    d.housing_units_occupancy_status_total_count,
    d.housing_units_occupied_count,
    s.state_name AS state_name,
	(p."most recent noi" / p."appraised value") AS Cap_Rate,
	 DENSE_RANK() OVER (PARTITION BY s.state_name ORDER BY (p."most recent noi" / p."appraised value") DESC) AS cap_rate_rank_state,
	 AVG(p."monthly rent per unit") OVER (PARTITION BY s.state_name) AS median_rent,
	 (p."monthly rent per unit" - AVG(p."monthly rent per unit") OVER (PARTITION BY s.state_name)) / AVG(p."monthly rent per unit") OVER (PARTITION BY s.state_name) AS Rent_Perc_Diff,
	 p."monthly rent per unit" * 12 / d.household_Income_median AS Rent_Affordability_Ratio,
	 PERCENT_RANK() OVER (PARTITION BY s.state_name ORDER BY (p."monthly rent per unit" * 12 / d.household_Income_median)) AS rent_affordability_percentile,
	 CAST(housing_units_occupied_count AS NUMERIC) / CAST(housing_units_occupancy_status_total_count AS NUMERIC) AS "State Occupancy Rate"
FROM properties_cleaned p
JOIN states_codes_mapping s
    ON p."property state" = s.adm_1_code_letters
JOIN demographics_us_raw d
    ON s.adm_1_code = d.state_code;


select * from enriched_properties
where "property state" = 'AZ' and "property city" = 'Tucson'
