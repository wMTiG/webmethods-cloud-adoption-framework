This schema defines two tables:

1. `Products`: This is the main table where each product is listed. Each product has a unique `ProductId`, a `Name`, `Description`, `Price`, `Active` and a `Category`.

2. `Stock`: This table keeps track of the stock levels for each product. There's a one-to-one relationship between the `Products` table and the `Stock` table via `ProductId`. The `Quantity` column represents the current stock level for each product.

The `FOREIGN KEY` constraint ensures referential integrity between the `Stock` and `Products` tables, meaning you cannot have stock records for products that do not exist. The `AUTO_INCREMENT` attribute is used to generate a unique ID for each new product and stock entry.

The `CreatedAt` and `UpdatedAt` timestamps in the `Products` table could help you track when records are added or modified. The `ON UPDATE CURRENT_TIMESTAMP` clause for the `UpdatedAt` field automatically updates the timestamp whenever the record is updated.

- **Product Deletion**: Instead of deleting discontinued products from the database, you can now simply set the `Active` column to `FALSE`. This allows for retaining historical data and potentially reactivating products in the future if needed.

- **Querying Active Products**: When querying the database for products to display in the inventory management system or on the retail platform, you can filter by the `Active` column to exclude discontinued products. For example:
  
  ```sql
  SELECT * FROM Products WHERE Active = TRUE;
  ```
  
  

- **Updating Product Status**: To mark a product as discontinued (or reactivate a discontinued product), you would perform an update operation on the `Active` column for the specific `ProductId`. For example, to discontinue a product:
  
  

```sql
UPDATE Products SET Active = FALSE WHERE ProductId = ?;
```


