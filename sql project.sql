create database ordermanagement
use ordermanagement
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Pending', 'Shipped', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Cash on Delivery') NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers (first_name, last_name, email, phone, address)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street, NY'),
('Jane', 'Smith', 'jane.smith@example.com', '2345678901', '456 Oak Avenue, LA'),
('Alice', 'Johnson', 'alice.johnson@example.com', '3456789012', '789 Pine Road, SF'),
('Bob', 'Williams', 'bob.williams@example.com', '4567890123', '101 Maple Street, NY'),
('Charlie', 'Brown', 'charlie.brown@example.com', '5678901234', '202 Birch Drive, LA'),
('David', 'Taylor', 'david.taylor@example.com', '6789012345', '303 Cedar Lane, SF'),
('Eva', 'Anderson', 'eva.anderson@example.com', '7890123456', '404 Redwood Way, NY'),
('Frank', 'Martinez', 'frank.martinez@example.com', '8901234567', '505 Willow Circle, LA'),
('Grace', 'Garcia', 'grace.garcia@example.com', '9012345678', '606 Birchfield Blvd, SF'),
('Helen', 'Davis', 'helen.davis@example.com', '0123456789', '707 Maplewood Drive, NY');
INSERT INTO Products (name, description, price, stock_quantity)
VALUES
('Laptop', 'High performance laptop', 1200.00, 50),
('Smartphone', 'Latest model smartphone', 800.00, 100),
('Headphones', 'Noise-cancelling headphones', 150.00, 200),
('Tablet', 'Portable tablet with stylus', 400.00, 75),
('Smartwatch', 'Fitness tracker and smartwatch', 200.00, 150);
INSERT INTO Orders (customer_id, total_amount, status)
VALUES
(1, 2400.00, 'Completed'),
(2, 800.00, 'Shipped'),
(3, 150.00, 'Pending'),
(4, 1800.00, 'Completed'),
(5, 200.00, 'Cancelled');
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES
(1, 1, 2, 1200.00),
(2, 2, 1, 800.00),
(3, 3, 1, 150.00),
(4, 4, 4, 400.00),
(5, 5, 1, 200.00);
INSERT INTO Payments (order_id, payment_amount, payment_method, payment_status)
VALUES
(1, 2400.00, 'Credit Card', 'Completed'),
(2, 800.00, 'PayPal', 'Completed'),
(3, 150.00, 'Debit Card', 'Pending'),
(4, 1800.00, 'Credit Card', 'Completed'),
(5, 200.00, 'Cash on Delivery', 'Failed');
INSERT INTO Reviews (customer_id, product_id, rating, review_text)
VALUES
(1, 1, 5, 'Great laptop, very fast and powerful.'),
(2, 2, 4, 'Smartphone works well, but the battery life could be better.'),
(3, 3, 3, 'The headphones are good, but a bit too heavy.'),
(4, 4, 5, 'Fantastic tablet for work and play, highly recommended.'),
(5, 5, 2, 'The smartwatch is not very accurate with heart rate tracking.');

select * from Customers
select * from Products
select * from Orders
select * from Order_Items
select * from Payments
select * from Reviews
SELECT p.name AS product_name, r.rating, r.review_text, r.created_at
FROM Products p
LEFT JOIN Reviews r ON p.product_id = r.product_id;
SELECT o.order_id, o.order_date, p.name AS product_name, oi.quantity, oi.price
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;
SELECT o.order_id, o.total_amount, o.status, p.payment_method, p.payment_status
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
WHERE o.customer_id = 1;
SELECT p.name, AVG(r.rating) AS average_rating
FROM Products p
LEFT JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id;

