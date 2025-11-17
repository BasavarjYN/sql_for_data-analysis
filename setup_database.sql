-- Drop tables if they exist (this will delete old data)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    join_date DATE
);

-- Create products table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    price REAL,
    category TEXT
);

-- Create orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create order_items table
CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert customers
INSERT INTO customers VALUES 
(1, 'John Doe', 'john@email.com', '2023-01-15'),
(2, 'Jane Smith', 'jane@email.com', '2023-02-20'),
(3, 'Mike Johnson', 'mike@email.com', '2023-03-10'),
(4, 'Sarah Wilson', 'sarah@email.com', '2023-01-25'),
(5, 'Tom Brown', NULL, '2023-04-05');

-- Insert products
INSERT INTO products VALUES 
(1, 'Laptop', 999.99, 'Electronics'),
(2, 'Smartphone', 699.99, 'Electronics'),
(3, 'Desk Chair', 149.99, 'Furniture'),
(4, 'Coffee Mug', 12.99, 'Kitchen'),
(5, 'Headphones', 89.99, 'Electronics');

-- Insert orders
INSERT INTO orders VALUES 
(1, 1, '2023-05-01', 999.99),
(2, 2, '2023-05-02', 849.98),
(3, 1, '2023-05-03', 149.99),
(4, 3, '2023-05-04', 162.98),
(5, 4, '2023-05-05', 89.99);

-- Insert order_items
INSERT INTO order_items VALUES 
(1, 1, 1, 1, 999.99),
(2, 2, 2, 1, 699.99),
(3, 2, 5, 1, 89.99),
(4, 3, 3, 1, 149.99),
(5, 4, 4, 2, 25.98),
(6, 4, 5, 1, 89.99),
(7, 5, 5, 1, 89.99);