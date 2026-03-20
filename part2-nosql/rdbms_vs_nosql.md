## Database Recommendation

For a healthcare startup building a patient management system, the recommended 
choice is MySQL (or PostgreSQL) as the primary database.

Patient records are among the most strictly regulated data in any industry. 
Every operation — recording a diagnosis, updating a medication, logging a 
surgical procedure — must either complete fully or not at all. This makes 
**ACID compliance** non-negotiable. MySQL guarantees Atomicity (a transaction 
never partially commits), Consistency (data always satisfies defined constraints), 
Isolation (concurrent transactions do not interfere with each other), and 
Durability (committed data survives system failures). MongoDB, operating under 
the **BASE** model (Basically Available, Soft state, Eventually Consistent), 
tolerates temporary inconsistencies that are acceptable in a product catalog or 
social feed but are dangerous in a clinical context. A doctor reading a patient's 
allergy list while a concurrent update is in flight cannot be allowed to see 
stale data.

The **CAP theorem** further supports this choice. MySQL in a synchronous 
replication configuration prioritizes **Consistency over Availability** during 
a network partition — meaning it will refuse to serve a request rather than 
return potentially incorrect data. MongoDB, by contrast, is typically configured 
as an **AP system**, remaining available during partitions at the cost of 
possible stale reads. In a healthcare setting, an unavailable system is a 
recoverable incident; an incorrect patient record is a patient safety risk. 
Consistency must take priority.

SQL's relational model also handles the structural complexity of healthcare 
data naturally. Patients link to multiple doctors, appointments, prescriptions, 
lab results, and insurance providers. These are well-defined, stable 
relationships that foreign keys, JOIN queries, and referential integrity 
constraints manage reliably — far more so than embedding or referencing 
documents manually in MongoDB.

**The answer changes with the addition of a fraud detection module.** Fraud 
detection operates on a fundamentally different data profile: high-velocity 
event streams, unstructured behavioral signals (login locations, device 
fingerprints, session durations), and pattern recognition across millions of 
records in near real-time. This workload does not require the strict consistency 
guarantees of the patient management system — it requires throughput, 
flexibility, and horizontal scalability. A document store like MongoDB, or 
a dedicated stream-processing layer backed by a tool like Apache Kafka, is 
better suited here.

The practical recommendation is therefore a **hybrid architecture**: MySQL as 
the system of record for all clinical data, with a separate MongoDB instance 
(or equivalent) handling the fraud detection pipeline. The two systems 
communicate through an event-driven integration layer, with MySQL remaining 
the authoritative source for any data that crosses both domains.
