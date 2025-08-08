-- CREATE TABLES
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    contact_info VARCHAR(100)
);

CREATE TABLE product_suppliers (
    product_id INT REFERENCES products(product_id),
    supplier_id INT REFERENCES suppliers(supplier_id),
    PRIMARY KEY (product_id, supplier_id)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    price DECIMAL(10, 2)
);

-- INSERT SAMPLE DATA

-- Customers
INSERT INTO customers (first_name, last_name, email, city) VALUES
('Alice', 'Smith', 'alice@example.com', 'New York'),
('Bob', 'Johnson', 'bob@example.com', 'Los Angeles'),
('Charlie', 'Williams', 'charlie@example.com', 'New York'),
('David', 'Brown', 'david@example.com', 'Chicago'),
('Eva', 'Davis', 'eva@example.com', 'Miami');

-- Orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-07-01', 250.00),
(2, '2025-07-03', 150.00),
(1, '2025-07-04', 300.00),
(3, '2025-07-05', 120.00),
(4, '2025-07-06', 90.00);

-- Products
INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 800.00),
('Headphones', 'Electronics', 100.00),
('Coffee Maker', 'Home Appliances', 75.00),
('Book', 'Stationery', 20.00),
('Pen', 'Stationery', 5.00);

-- Suppliers
INSERT INTO suppliers (name, contact_info) VALUES
('Tech Supplies Inc.', 'tech@example.com'),
('HomeNeeds Ltd.', 'home@example.com');

-- Product Suppliers
INSERT INTO product_suppliers (product_id, supplier_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 800.00),
(1, 2, 2, 100.00),
(2, 3, 1, 75.00),
(3, 4, 2, 20.00),
(4, 5, 5, 5.00);

-- QUERIES

-- Query 1: SELECT, WHERE, ORDER BY, GROUP BY
SELECT c.city, COUNT(*) AS customer_count
FROM customers c
GROUP BY city
ORDER BY customer_count DESC;

-- Query 2: INNER JOIN - Orders with customer names
SELECT o.order_id, o.order_date, c.first_name || ' ' || c.last_name AS customer_name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- Query 3: LEFT JOIN - All products and their suppliers (even if no supplier)
SELECT p.name AS product_name, s.name AS supplier_name
FROM products p
LEFT JOIN product_suppliers ps ON p.product_id = ps.product_id
LEFT JOIN suppliers s ON ps.supplier_id = s.supplier_id;

-- Query 4: Subquery - Customers with total spending > 500
SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 500
);

-- Query 5: Aggregate - Average order value per customer
SELECT customer_id, AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;

-- Query 6: Create View - Order summary
CREATE OR REPLACE VIEW order_summary AS
SELECT o.order_id, o.order_date, c.first_name || ' ' || c.last_name AS customer_name, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Query 7: Create Index - On order_date
CREATE INDEX idx_order_date ON orders(order_date);

-- Query 8: Top 5 most sold products
SELECT p.name AS product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 5;
