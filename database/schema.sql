-- Grocery Store Management System - Schema
DROP DATABASE IF EXISTS grocery_store;
CREATE DATABASE grocery_store
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE grocery_store;

CREATE TABLE users (
    user_id       INT          NOT NULL AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    username      VARCHAR(50)  NOT NULL,
    phone_number  VARCHAR(20)  NOT NULL,
    password      VARCHAR(255) NOT NULL,          -- stores a password HASH, never plain text
    role          ENUM('CUSTOMER', 'MANAGER', 'DELIVERYMAN') NOT NULL,
    address       VARCHAR(255) NULL,              -- Customer only
    staff_id      VARCHAR(20)  NULL,              -- Staff only (Manager, Deliveryman)
    active        BOOLEAN      NOT NULL DEFAULT TRUE,  -- Staff.isWorking()
    PRIMARY KEY (user_id),
    UNIQUE KEY uq_users_username (username),
    UNIQUE KEY uq_users_phone (phone_number),
    UNIQUE KEY uq_users_staff_id (staff_id),
    CONSTRAINT chk_users_role_fields CHECK (
        (role = 'CUSTOMER' AND address IS NOT NULL AND staff_id IS NULL)
        OR (role <> 'CUSTOMER' AND staff_id IS NOT NULL)
    )
) ENGINE = InnoDB;

CREATE TABLE categories (
    category_id    INT          NOT NULL AUTO_INCREMENT,
    category_name  VARCHAR(100) NOT NULL,
    description    VARCHAR(255) NULL,
    PRIMARY KEY (category_id),
    UNIQUE KEY uq_categories_name (category_name)
) ENGINE = InnoDB;

-- A category should not be deleted while it still has products => RESTRICT.
-- expiration_date is NULL for products that do not expire (e.g. salt).
CREATE TABLE products (
    product_id       INT           NOT NULL AUTO_INCREMENT,
    product_name     VARCHAR(150)  NOT NULL,
    price            DECIMAL(10,2) NOT NULL,
    expiration_date  DATE          NULL,
    category_id      INT           NOT NULL,
    PRIMARY KEY (product_id),
    KEY idx_products_name (product_name),
    KEY idx_products_expiration (expiration_date),
    CONSTRAINT chk_products_price CHECK (price >= 0),
    CONSTRAINT fk_products_category FOREIGN KEY (category_id)
        REFERENCES categories (category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- inventory_batches: exactly ONE row per product (UNIQUE product_id).
-- Composition: deleting a product deletes its stock row (CASCADE).
CREATE TABLE inventory_batches (
    batch_id             INT  NOT NULL AUTO_INCREMENT,
    product_id           INT  NOT NULL,
    quantity             INT  NOT NULL DEFAULT 0,
    low_stock_threshold  INT  NOT NULL DEFAULT 10,
    restock_date         DATE NULL,
    PRIMARY KEY (batch_id),
    UNIQUE KEY uq_batches_product (product_id),
    CONSTRAINT chk_batches_quantity  CHECK (quantity >= 0),
    CONSTRAINT chk_batches_threshold CHECK (low_stock_threshold >= 0),
    CONSTRAINT fk_batches_product FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- delivery_address is a COPY of the customer's address at order time.
-- deliveryman_id stays NULL until a deliveryman starts the delivery.
CREATE TABLE orders (
    order_id          INT           NOT NULL AUTO_INCREMENT,
    customer_id       INT           NOT NULL,
    order_date        DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status            ENUM('PENDING', 'BEING_DELIVERED', 'DELIVERED')
                                    NOT NULL DEFAULT 'PENDING',
    total_amount      DECIMAL(12,2) NOT NULL,
    delivery_address  VARCHAR(255)  NOT NULL,
    deliveryman_id    INT           NULL,
    PRIMARY KEY (order_id),
    KEY idx_orders_status (status),
    KEY idx_orders_date (order_date),
    CONSTRAINT chk_orders_total CHECK (total_amount >= 0),
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES users (user_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_orders_deliveryman FOREIGN KEY (deliveryman_id)
        REFERENCES users (user_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB;

-- unit_price is the price at order time, so old orders keep their total even if the product price changes later.
-- A product that appears in an order cannot be deleted => RESTRICT
CREATE TABLE order_items (
    order_id    INT           NOT NULL,
    product_id  INT           NOT NULL,
    quantity    INT           NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT chk_items_quantity CHECK (quantity > 0),
    CONSTRAINT chk_items_price    CHECK (unit_price >= 0),
    CONSTRAINT fk_items_order FOREIGN KEY (order_id)
        REFERENCES orders (order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_items_product FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE USER IF NOT EXISTS 'grocery_app'@'localhost' IDENTIFIED BY 'ChangeMe_123!';
GRANT SELECT, INSERT, UPDATE, DELETE ON grocery_store.* TO 'grocery_app'@'localhost';
FLUSH PRIVILEGES;
