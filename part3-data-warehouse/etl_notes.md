My ETL Strategy
The raw data in retail_transactions.csv has a few issues that need sorting before it can be loaded into the warehouse. Here's how I've approached each one:

Fixing dates: The dataset mixes formats- some dates appear as 29/08/2023, others as 2023-11-18. A short script standardises everything to YYYY-MM-DD before loading, so date-based queries don't break or return unexpected results.
Cleaning categories: Inconsistent casing (electronics vs Electronics) causes the same category to appear as separate groups in reports. Applying title case across the column ensures they consolidate correctly.
Filling blanks: 19 rows have a missing city value. Since the store names are still present- for example, "Mumbai Central"- the city can be inferred and filled in without needing to drop those rows.
Deriving total revenue: The source file has no revenue column. During the load step, I multiply price by units_sold to generate it, so the warehouse has it ready for aggregation without recalculating every time a query runs.
