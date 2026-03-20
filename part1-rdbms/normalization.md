## Anomaly Analysis

### Insert Anomaly
We cannot add a new **Product** (e.g., Product ID 'P009') to the system without an associated order. Since `order_id` is the primary record key, a product cannot exist in this flat file unless someone buys it.

### Update Anomaly
The **office_address** for Sales Rep **SR01 (Deepak Joshi)** is inconsistent. In Row 2, the address is "Nariman Point," while in Row 38, it is "Nariman Pt." Updating his address would require searching every single row.

### Delete Anomaly
If we delete **Order ORD1027** (the very first row), we lose the information for **Customer C002 (Priya Sharma)** entirely. Her email and city disappear from our records because they only exist inside that order row.
