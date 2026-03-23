Anomaly Analysis

Insert Anomaly

The current structure ties everything to orders, which creates a problem for the product catalogue. There's no way to add a new item - say, a Gaming Mouse (P009) - unless a customer buys it first. Every row requires an order_id, so product details can't exist on their own.

Update Anomaly

Sales rep data is inconsistent across rows. Take Deepak Joshi (SR01): his address appears as both "Nariman Point" and "Nariman Pt." in different rows. If his office changes, every row he appears in needs to be updated manually, which is time-consuming and easy to get wrong.

Delete Anomaly

Customer information is embedded in order rows rather than stored separately. Deleting Order ORD1027 doesn't just remove a sale - it wipes out Priya Sharma (C002) entirely, since her email and city are only recorded against that order.

Normalization Justification

A flat table feels simple until the data starts to grow - at which point the structure actively works against you. The orders_flat.csv dataset demonstrates this directly.

Deepak Joshi (SR01) appears in 83 rows, yet his address is inconsistently recorded: 15 rows list "Nariman Pt," while the other 68 list "Nariman Point." This isn't a theoretical risk - it's an observed data quality failure in the provided dataset. In a normalised schema, his address appears only once in the sales_reps table. Fixing it takes a single UPDATE. In the flat design, all 83 rows need to be found and corrected with no guarantee that every occurrence is caught.

The flat structure also makes certain routine operations impossible by design. Product P008 (Webcam, ₹2,100) appears in just one row—ORD1185. If that order is cancelled and deleted, the product vanishes from the system entirely. There's no separate catalogue, so the business loses all record that the webcam was ever stocked or sold. The same logic applies to staff: a new sales rep can't be added to the system until they have a completed order, meaning the company can't onboard anyone before their first sale. These aren't edge cases; they're direct constraints the flat structure imposes on normal business operations.

Normalisation to 3NF resolves all three issues by making customers, products, and sales reps independent entities. Each can be created, updated, or queried without touching the orders table. That's not over-engineering - it's the minimum structure needed for a business database to behave reliably as data and complexity grow.
