# My ETL Strategy

The raw data in `retail_transactions.csv` is a bit of a mess, so here is how I'd fix it before moving it into the Warehouse:

1. **Fixing Dates:** I saw dates like `29/08/2023` mixed with `2023-11-18`. I'd use a script to turn them all into the standard `YYYY-MM-DD` format so the database doesn't get confused.
2. **Cleaning Categories:** Some rows say `electronics` and some say `Electronics`. I would force everything to starts with a Capital letter so they group together correctly in reports.
3. **Filling Blanks:** There are 19 rows where the city is missing. Since the store names (like "Mumbai Central") are there, I can just fill in "Mumbai" for those empty spots.
4. **Calculations:** The original file doesn't have a "Total Revenue" column. I'll create that by multiplying the price by the units sold during the loading process.
