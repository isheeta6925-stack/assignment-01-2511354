## Anomaly Analysis

### Insert Anomaly
Right now, the data is tied strictly to orders. This means if I want to add a new item like a 'Gaming Mouse' (Product P009) to our catalog, I can't do it unless a customer actually buys it first. There is no way to store product details on their own because every row needs an `order_id`.

### Update Anomaly
The data for sales reps is really inconsistent. For example, look at **Deepak Joshi (SR01)**. In one row his address says "Nariman Point," but in another, it’s shortened to "Nariman Pt." If he moves to a new office, I’d have to manually find and fix every single row where he appears, which is a huge waste of time and prone to mistakes.

### Delete Anomaly
The customer info is stuck inside the order rows. If I decide to delete **Order ORD1027**, I'm not just deleting a sale—I'm accidentally deleting **Priya Sharma (C002)** from our system entirely. Since her email and city are only listed in that specific row, once the order is gone, her contact info is gone too.
