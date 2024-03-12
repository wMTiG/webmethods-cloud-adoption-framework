### Test Setup

- **Environment Configuration**:
  
  - Set up a test tenant that mirrors the production environment. This should include the actual webMethods.io API and integration layer configured to operate
  - Use a mock or stub for the Inventory Management Application (IMA) to simulate its behavior.
  - Prepare a test My SQL Server database to reflect the production database schema and initial test data.    

- **Mock Services and Data Preparation**:
  
  - Prepopulate the test database with a variety of products and stock levels to cover different test scenarios.

- **Test Cases**
1. **Read (Query Stock Levels) Test Case**:
   
   - **Integration with webMethods.io**:
     - Ensure the webMethods.io API is configured to route `/api/inventory/{productId}/stock-level` requests to the appropriate webMethods.io Integration flow.
     - The Integration flow should then format the request for the on-premise MySQL database query.
   - **Expected Result**:
     - The stock level returned matches the database records, demonstrating successful API routing and integration processing.

2. **Create (Add New Product) Test Case**:
   
   - **Integration with webMethods.io**:
     - Test that the webMethods.io API correctly forwards new product creation requests to webMethods.io Integration.
     - The Integration layer processes the request, transforming the JSON payload as necessary before inserting the new product into the MySQL Server database.
   - **Expected Result**:
     - The new product details are accurately inserted into the database, verifying the API's capability to handle creation requests and the integration layer's data processing.

3. **Update (Adjust Stock Levels) Test Case**:
   
   - **Integration with webMethods.io**:
     - Validate that the update stock level API calls are properly managed by webMethods.io API and processed by webMethods.io Integration to adjust stock levels in the database.
   - **Expected Result**:
     - The database reflects the updated stock levels, confirming the system's ability to process updates through the API and integration layers.

4. **Delete (Remove Discontinued Products) Test Case**:
   
   - **Integration with webMethods.io**:
     - Confirm that delete requests for discontinued products are accurately routed through the webMethods.io API to the Integration service, which then executes the delete operation on the database.
   - **Expected Result**:
     - The product is successfully removed from the database, illustrating effective delete operation handling by both the API and integration services.

##### General Integration Test Case

- **Objective**:
  - To ensure seamless communication and accurate data manipulation across the Inventory Management Application, webMethods.io API, webMethods.io Integration, and the MySQL Server database through a series of integrated actions (create, read, update, delete).
- **Test Steps**:
  - Perform a sequence of operations through the IMA that involves each CRUD operation, tracking how requests are handled by the webMethods.io API and processed by the Integration service.
- **Expected Result**:
  - Each operation reflects accurately in the database, with API responses confirming the intended outcomes, thereby validating the integration and functionality of the entire system
