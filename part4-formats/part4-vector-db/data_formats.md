Comparison of Data Formats
1. CSV (Comma Separated Values)
Best for: Simple lists and viewing data in Excel.
CSV is just plain text- nothing fancy. That's its biggest advantage. Anyone can open it, and it needs no special software. The catch is that it falls apart when your data gets nested or complex. If an order contains multiple items, CSV doesn't have a clean way to represent that.
2. JSON (JavaScript Object Notation)
Best for: Web apps and NoSQL databases (like the products we built in Part 2).
JSON handles messy, real-world data well. One product can have a "battery life" field while another has "fabric type"- and neither breaks the file. That flexibility is why it's everywhere in web development. The downside is file size: since every single row repeats the field names (like "price": over and over), the files get bloated fast.
3. Parquet
Best for: Large-scale data warehouses and analytics.
Parquet stores data by column rather than by row. In practice, that means if you only need to calculate total revenue, it reads just the revenue column and ignores everything else- which makes a massive difference when you're dealing with millions of rows. The tradeoff is accessibility: you can't open a Parquet file in Notepad or Excel. You need proper data tooling to work with it.
