-- create a new one
CREATE DATABASE IF NOT EXISTS InventoryDB;
USE InventoryDB;

-- Modified Product table with 'Active' column
CREATE TABLE IF NOT EXISTS Products (
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Category VARCHAR(255),
    Active BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Stock table
CREATE TABLE IF NOT EXISTS Stock (
    StockId INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    Quantity INT DEFAULT 0,
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);

-- index on the ProductId in the Stock table to query
CREATE INDEX idx_product_id ON Stock(ProductId);
