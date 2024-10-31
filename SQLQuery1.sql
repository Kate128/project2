CREATE DATABASE online_store;

USE online_store;

CREATE TABLE id_counter (
    id INT PRIMARY KEY
);
INSERT INTO id_counter (id) VALUES (0);

CREATE TRIGGER before_insert_products
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    UPDATE id_counter SET id = LAST_INSERT_ID(id + 1);
    SET NEW.id = LAST_INSERT_ID();
END;
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image VARCHAR(255)
);
CREATE TABLE orders (
    id INT PRIMARY KEY,  -- Звичайний INT
    total DECIMAL(10, 2) NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE order_items (
    id INT PRIMARY KEY,  -- Звичайний INT
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);