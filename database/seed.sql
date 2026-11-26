-- Grocery Store Management System
-- Every sample user has the password:  Password123! (stored as a bcrypt hash; the Java code must check it with bcrypt)

USE grocery_store;

-- Users: 1 manager, 1 deliveryman, 2 customers
INSERT INTO users (user_id, name, username, phone_number, password, role, address, staff_id) VALUES
(1, 'Jordan Ellis',  'manager1',  '0901000001', '$2a$10$8T4gIN5Bfr1fekrbR8H37.Zkbb26xhOWo8PbxAzLJQMmyrt6n3rt6', 'MANAGER',     NULL, 'S001'),
(2, 'Casey Brooks',  'delivery1', '0901000002', '$2a$10$8T4gIN5Bfr1fekrbR8H37.Zkbb26xhOWo8PbxAzLJQMmyrt6n3rt6', 'DELIVERYMAN', NULL, 'S002'),
(3, 'Jamie Carter',  'jamie',     '0902000001', '$2a$10$8T4gIN5Bfr1fekrbR8H37.Zkbb26xhOWo8PbxAzLJQMmyrt6n3rt6', 'CUSTOMER',    '12 Example Street, District 1', NULL),
(4, 'Riley Morgan',  'riley',     '0902000002', '$2a$10$8T4gIN5Bfr1fekrbR8H37.Zkbb26xhOWo8PbxAzLJQMmyrt6n3rt6', 'CUSTOMER',    '45 Sample Avenue, District 3',  NULL);

-- Categories
INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Dairy',               'Milk, cheese and yogurt'),
(2, 'Bakery',              'Fresh bread and pastries'),
(3, 'Fruit & Vegetables',  'Fresh produce'),
(4, 'Beverages',           'Juice and water'),
(5, 'Pantry',              'Dry and canned goods');

-- Products (expiration dates are relative to today; NULL = does not expire)
INSERT INTO products (product_id, product_name, price, expiration_date, category_id) VALUES
(1,  'Fresh Milk 1L',       1.80, DATE_ADD(CURDATE(), INTERVAL 4 DAY),   1),
(2,  'Yogurt 4-pack',       2.40, DATE_ADD(CURDATE(), INTERVAL 10 DAY),  1),
(3,  'Cheddar Cheese 200g', 3.50, DATE_ADD(CURDATE(), INTERVAL 40 DAY),  1),
(4,  'Cream 250ml',         1.90, DATE_SUB(CURDATE(), INTERVAL 2 DAY),   1),
(5,  'White Bread',         1.50, DATE_ADD(CURDATE(), INTERVAL 2 DAY),   2),
(6,  'Croissant',           1.20, DATE_ADD(CURDATE(), INTERVAL 1 DAY),   2),
(7,  'Apples 1kg',          2.90, DATE_ADD(CURDATE(), INTERVAL 9 DAY),   3),
(8,  'Bananas 1kg',         1.60, DATE_ADD(CURDATE(), INTERVAL 5 DAY),   3),
(9,  'Orange Juice 1L',     2.50, DATE_ADD(CURDATE(), INTERVAL 60 DAY),  4),
(10, 'Mineral Water 1.5L',  0.80, DATE_ADD(CURDATE(), INTERVAL 365 DAY), 4),
(11, 'Rice 5kg',            8.90, DATE_ADD(CURDATE(), INTERVAL 500 DAY), 5),
(12, 'Pasta 500g',          1.40, DATE_ADD(CURDATE(), INTERVAL 400 DAY), 5),
(13, 'Canned Tomatoes',     1.10, DATE_ADD(CURDATE(), INTERVAL 700 DAY), 5),
(14, 'Sea Salt 500g',       0.90, NULL,                                  5);

-- One inventory batch per product
-- (to cover all example bases: milk and croissant are low on stock, rice is sold out)
INSERT INTO inventory_batches (product_id, quantity, low_stock_threshold, restock_date) VALUES
(1,   6, 10, DATE_SUB(CURDATE(), INTERVAL 3 DAY)),
(2,  40, 10, DATE_SUB(CURDATE(), INTERVAL 6 DAY)),
(3,  25, 10, DATE_SUB(CURDATE(), INTERVAL 12 DAY)),
(4,   8, 10, DATE_SUB(CURDATE(), INTERVAL 15 DAY)),
(5,  30, 10, DATE_SUB(CURDATE(), INTERVAL 1 DAY)),
(6,   4, 10, DATE_SUB(CURDATE(), INTERVAL 1 DAY)),
(7,  50, 10, DATE_SUB(CURDATE(), INTERVAL 5 DAY)),
(8,  35, 10, DATE_SUB(CURDATE(), INTERVAL 5 DAY)),
(9,  60, 10, DATE_SUB(CURDATE(), INTERVAL 20 DAY)),
(10, 120, 20, DATE_SUB(CURDATE(), INTERVAL 30 DAY)),
(11,  0,  5, DATE_SUB(CURDATE(), INTERVAL 45 DAY)),
(12, 80, 10, DATE_SUB(CURDATE(), INTERVAL 25 DAY)),
(13, 70, 10, DATE_SUB(CURDATE(), INTERVAL 25 DAY)),
(14, 45, 10, NULL);

-- Orders: one for each status
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount, delivery_address, deliveryman_id) VALUES
(1, 3, DATE_SUB(NOW(), INTERVAL 3 DAY), 'DELIVERED',       5.10, '12 Example Street, District 1', 2),
(2, 4, DATE_SUB(NOW(), INTERVAL 2 HOUR), 'PENDING',        8.30, '45 Sample Avenue, District 3',  NULL),
(3, 3, DATE_SUB(NOW(), INTERVAL 1 DAY), 'BEING_DELIVERED', 6.10, '12 Example Street, District 1', 2);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1,  2, 1.80),
(1, 5,  1, 1.50),
(2, 7,  2, 2.90),
(2, 9,  1, 2.50),
(3, 12, 2, 1.40),
(3, 13, 3, 1.10);