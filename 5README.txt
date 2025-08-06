README

This document summarizes the logic, assumptions, and decisions behind the creation of a data-driven dashboard to analyze commercial real estate performance across profitability, affordability, and operational metrics.

1.  Metric Logic and Assumptions

This analysis includes several key metrics calculated per property using enriched demographic and operational data. Each metric is defined below by performance category and includes:
- Definition
- Formula (if calculated)
- Source
- Usage
- Assumption

 Profitability Metrics

Net Operating Income (NOI)
- Definition: Income after subtracting operating expenses.
- Source: Provided directly in the property dataset.
- Usage: Used in Cap Rate calculation.
- Assumption: Assumed accurate and up to date.

Monthly Rent / Unit
- Definition: Average monthly revenue per unit before considering occupancy.
- Source: Property dataset.
- Usage: Used for affordability metrics and RevPOU.
- Assumption: Reflects current market rents.

Cap Rate
- Definition: Return on investment based on income vs. property value.
- Formula: Cap Rate = NOI / Appraised Value
- Source: Derived from property dataset.
- Usage: Measures profitability; used for ranking.
- Assumption: Assumes both values are current.

RevPOU (Revenue per Occupied Unit)
- Definition: Rent revenue normalized by occupancy.
- Formula: Monthly Rent × Occupancy Rate
- Source: Property dataset.
- Usage: Assesses actual income performance.
- Assumption: Assumes data accuracy and operational efficiency.

Property Value (Appraised Value)
- Definition: Estimated market value of the property.
- Source: Property dataset.
- Usage: Used for Cap Rate calculation.
- Assumption: Assumed consistent and accurate.

 Affordability Metrics

Avg Rent Affordability Ratio
- Definition: Share of income spent on rent.
- Formula: Monthly Rent / Median Household Income
- Source: Property rent + Demographic income.
- Usage: Flags unaffordability (values > 0.30).
- Assumption: Income data matches the people who would live in or rent that property

Rent Affordability Percentile Rank
- Definition: A property’s relative affordability rank within its state, based on how much of a household’s income would be spent on annual rent. The higher the rank, the less affordable the property is compared to others in the same state.
- Formula: PERCENT_RANK() OVER (PARTITION BY state_name ORDER BY (Rent Affordability Ratio)
- Source: Rent Affordability Ratio, state
- Usage: Identifies how affordable or unaffordable a property is relative to others in the same state 
	 A value close to 100% means the property is among the least affordable in its state, a value near 0.0% means the property is more affordable than most others
- Assumption: Income and rent values are assumed to be accurate and current

Household Income Median
- Definition: Middle income per state.
- Source: Demographic dataset.
- Usage: Input for all affordability metrics.
- Assumption: Accurate and recent.

Housing Units Occupied
- Definition: Number of currently occupied housing units.
- Source: Demographic dataset.
- Usage: Contextualizes affordability by population.
- Assumption: Reflects present housing demand.

 Operational Metrics

Total Units
- Definition: Number of housing units per property.
- Source: Property dataset.
- Usage: Used for occupancy metrics.
- Assumption: Accurate and consistent.

Total Occupancy %
- Definition: Occupied units as a percentage of total units.
- Formula: (Occupied Units / Total Units) × 100
- Source: Property dataset.
- Usage: Tracks occupancy health.
- Assumption: Total and occupied values are up to date.

State Occupancy Rate
- Definition: Average occupancy for each state.
- Formula: housing_units_occupied_count / housing_units_occupancy_status_total_count
- Source: Demographic dataset.
- Usage: Benchmark for POI metric.
- Assumption: Reflects market average per state.

POI (Performance Occupancy Index)
- Definition: Measures property occupancy performance vs. the state average.
- Formula: Total Occupancy % / State Occupancy Rate
- Source: Combination of property and demographic data.
- Usage: Detects over-/under-performance in occupancy.
- Assumption: Benchmarks and occupancy rates are valid.

2. Data Handling and Processing Decisions

- Three datasets were used: property data, demographic data (state-level), and a state code mapping table.
- The data source files were cleaned to use only the necessary fields for the analysis.
- An exploratory data analysis was performed in the datasets to find anomalies in the data.
- Data was cleaned and transformed using PostgreSQL.
- A view (enriched properties) was created to combine and calculate all relevant fields.
- The data was exported to CSV and loaded into Power BI for visualization.

3. Automation Strategy

We assume the enriched_properties.csv file is periodically updated by an automated ETL/data pipeline.

To enable automated updates of the analysis and Power BI report:

- The enriched dataset is exported as a CSV from PostgreSQL.
- The power BI report is published in a workspace.
- The report is included in the app in power BI service.
- In Power BI Service, the dataset can be scheduled for automatic refresh (daily, weekly).


4. Communication Strategy for Non-Technical Stakeholders

To ensure clarity for non-technical audiences:

Language

- Plain explanations (e.g., "more than 30% of income spent on rent = unaffordable")

Visual Storytelling
- KPI tiles show high-level metrics
- Bar charts grouped by state
- Color indicators: green = good, red = concern

Dashboard Structure
- Executive Summary Page:
  - Snapshot of total performance
  - Highlights top-performing and underperforming properties/states

- Sections by theme:
  - Profitability
  - Affordability
  - Operational Performance

Built-in Tooltips
- Hover-over explanations for metrics
- Allow users to interpret insights without leaving the dashboard

Enables Decision-Making
Helps business users to:
- Prioritize attention to poor-performing markets
- Identify attractive investment areas
