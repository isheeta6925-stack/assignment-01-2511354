## Storage Systems
## OLTP vs OLAP Boundary
## Trade-offs

Storage Systems
For this hospital network, I decided on a mixed storage strategy because no single database can handle both real-time vitals and complex historical analysis effectively.

First, I implemented a Data Lake for the ICU monitoring devices. These sensors stream constant data that is too "noisy" and fast for a standard SQL database. Using a lake allows us to capture every heartbeat and oxygen level in its raw format without worrying about pre-defined schemas.

For the goal of querying patient history in plain English, I integrated a Vector Database. Traditional keyword searches often miss context, but by converting patient medical records into embeddings, doctors can ask conversational questions and get semantically relevant results.

Finally, for monthly management reports (like occupancy and costs), I chose a Data Warehouse. This is where the data becomes "clean." By using a structured warehouse, the hospital administration can run standard SQL queries for their monthly BI dashboards without slowing down the live medical systems.

OLTP vs OLAP Boundary
In my design, the boundary between transactional and analytical systems is very clear. The OLTP (Online Transactional Processing) side is the hospital's live EHR system. This is where doctors record new symptoms and nurses update patient charts in real-time. Speed and "row-level" accuracy are the priority here.

The OLAP (Online Analytical Processing) side begins at the ingestion layer of our Data Lakehouse. Once the data is moved from the EHR or the ICU sensors into our analytical storage, it is no longer being modified by day-to-day operations. This is where we perform the heavy lifting, such as training the AI models for readmission risk and running the deep cost-analysis reports for management.

Trade-offs
The biggest trade-off I faced was the "Consistency vs. Speed" dilemma in the ICU data flow. If we spend time cleaning and validating the sensor data as it arrives, we might miss a critical real-time alert.

I decided to prioritize speed for the initial ingestion (the "Bronze" layer) and then use a Medallion Architecture to clean the data in stages. This means the raw data is stored instantly, but the AI readmission model only looks at the "Silver" or "Gold" layers, where the data has been standardized and the "noise" has been filtered out. This ensures the AI isn't making predictions based on faulty sensor readings while still keeping a record of everything that happened in the ICU.
