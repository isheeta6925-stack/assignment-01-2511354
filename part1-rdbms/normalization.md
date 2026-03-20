## Anomaly Analysis

### Insert Anomaly
Right now, the data is tied strictly to orders. This means if I want to add a new item like a 'Gaming Mouse' (Product P009) to our catalog, I can't do it unless a customer actually buys it first. There is no way to store product details on their own because every row needs an `order_id`.

### Update Anomaly
The data for sales reps is really inconsistent. For example, look at **Deepak Joshi (SR01)**. In one row his address says "Nariman Point," but in another, it’s shortened to "Nariman Pt." If he moves to a new office, I’d have to manually find and fix every single row where he appears, which is a huge waste of time and prone to mistakes.

### Delete Anomaly
The customer info is stuck inside the order rows. If I decide to delete **Order ORD1027**, I'm not just deleting a sale—I'm accidentally deleting **Priya Sharma (C002)** from our system entirely. Since her email and city are only listed in that specific row, once the order is gone, her contact info is gone too.


## Normalization Justification

The argument that a single flat table is "simpler" holds up only until the data 
starts to grow — at which point it becomes a liability rather than a convenience. 
The orders_flat.csv dataset itself illustrates this clearly.

Consider sales representative Deepak Joshi (SR01). His office address appears in 
83 rows of the flat file, yet it is still inconsistent: 15 of those rows store 
"Nariman Pt" while the remaining 68 store "Nariman Point." This is not a 
hypothetical risk — it is an observed data quality failure in the provided dataset. 
In a normalized schema, Deepak's address is stored exactly once in the `sales_reps` 
table. Correcting it requires a single UPDATE statement. In the flat design, a 
developer must find and fix all 83 rows simultaneously, with no guarantee they 
caught every occurrence.

The flat design also makes certain legitimate business operations structurally 
impossible. Product P008 (Webcam, ₹2,100) exists in only one row — ORD1185. If 
that order is cancelled and the row is deleted, the product disappears from the 
system entirely. There is no separate product catalog, so the business loses all 
record that the Webcam was ever sold or even stocked. Similarly, a new sales 
representative cannot be added to the system until they have at least one completed 
order — meaning the company cannot onboard staff in advance of their first sale. 
Both of these are direct operational constraints imposed by the flat structure, 
not edge cases.

Normalization to 3NF resolves all three of these problems by ensuring that 
customers, products, and sales representatives exist as independent entities. 
Each can be created, updated, or queried without touching the orders table at all. 
This is not over-engineering — it is the minimum structure required for a business 
database to behave predictably as data volume and operational complexity increase.
