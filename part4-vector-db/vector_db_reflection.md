## Vector DB Use Case

A traditional keyword-based search would not suffice for a law firm
searching 500-page contracts in plain English. Keyword search works by
matching exact words — if a lawyer types "termination clauses," the
system only returns paragraphs containing those precise words. Legal
contracts, however, are full of synonymous phrasing. A clause that reads
"conditions for contract dissolution" or "grounds for early exit" carries
the same legal meaning as "termination clause," but a keyword search
would miss both entirely. This makes keyword search fundamentally
unreliable for legal document retrieval, where missing a single relevant
clause could have serious consequences.

A vector database solves this by working with meaning rather than exact
words. Each paragraph or section of a contract is converted into a
numerical vector — called an embedding — using a language model such as
all-MiniLM-L6-v2. This vector captures the semantic meaning of the text,
not just its words. When a lawyer types a plain English question, that
question is also converted into a vector. The system then finds the
contract sections whose vectors are closest to the query vector, using
cosine similarity as the distance measure.

In practice, the system would chunk each 500-page contract into
paragraphs, embed each chunk, and store those embeddings in a vector
database such as Pinecone or ChromaDB. A lawyer's natural language query
is embedded at search time and matched against stored vectors instantly.
The result is a ranked list of the most semantically relevant clauses —
regardless of exact wording — making contract review faster, more
accurate, and far less dependent on knowing the precise legal terminology
used in each document.
