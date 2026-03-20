-- Q1.2: Schema Design

-- Creating the basic tables first
CREATE TABLE sales_reps (
    rep_id VARCHAR(10) PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    office_addr TEXT NOT NULL
);

CREATE TABLE customers (
    cust_id VARCHAR(10) PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    prod_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Order table with foreign keys to link everything
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    cust_id VARCHAR(10),
    prod_id VARCHAR(10),
    rep_id VARCHAR(10),
    qty INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
    FOREIGN KEY (prod_id) REFERENCES products(prod_id),
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id)
);

-- Inserting sample records (5 per table)
INSERT INTO sales_reps (rep_id, fullname, email, office_addr) VALUES 
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road'),
('SR04', 'Suresh Raina', 'suresh@corp.com', 'Chennai Branch'),
('SR05', 'Megha Singh', 'megha@corp.com', 'Kolkata Hub');

INSERT INTO customers (cust_id, cust_name, email, city) VALUES 
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai');

INSERT INTO products (prod_id, name, category, price) VALUES 
('P001', 'Laptop', 'Electronics', 55000),
('P002', 'Mouse', 'Electronics', 800),
('P003', 'Desk Chair', 'Furniture', 8500),
('P004', 'Notebook', 'Stationery', 120),
('P005', 'Headphones', 'Electronics', 3200);

INSERT INTO orders (order_id, cust_id, prod_id, rep_id, qty, order_date) VALUES 
('ORD1001', 'C001', 'P001', 'SR01', 1, '2023-01-10'),
('ORD1002', 'C002', 'P005', 'SR02', 1, '2023-01-17'),
('ORD1003', 'C003', 'P003', 'SR03', 2, '2023-02-05'),
('ORD1004', 'C004', 'P004', 'SR04', 10, '2023-02-15'),
('ORD1005', 'C005', 'P002', 'SR01', 5, '2023-03-01');
