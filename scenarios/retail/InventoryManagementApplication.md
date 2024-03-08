**Use Case Description**

A retail company's inventory management system, leveraging webMethods iPaas as API led integration platform as a service (iPaaS) for connecting cloud-hosted applications with an on-premise inventory database



**High-Level Architecture Overview**

![High level flow](https://github.com/bramhanayaghea/webMethodsCAF/blob/develop/scenarios/retail/_images/Hybrid-sync-flow.jpg)


- **Inventory Database (On-Premise)**: This is the core repository for all inventory-related data, including stock levels, product information, pricing, and supplier details. It resides within the company's secure, on-premise infrastructure.

- **On-Premise Integration Server**: Acts as a secure gateway that facilitates the communication between the on-premise database and the cloud. This server implements a hybrid connectivity solution, ensuring secure data transfer across cloud and on-premise environments.

- **webMethods.io API Gateway**:
  
  Mediates API calls from the IMA, performing actions such as authentication, request routing, and throttling.

- **webMethods.io Integration Platform (iPaaS)**: Handles business logic transformation, request enrichment with Channel information, and preparation for on-premise communication.

- **Inventory Management Application (IMA)**: A cloud-hosted application that interfaces with the inventory database to manage stock levels, update product information, and process orders. It's accessible by company staff and integrates seamlessly with webMethods iPaas for data exchange.

- **Hybrid Connectivity**:
  
  Establishes a secure connection from webMethods.io in the cloud to on-premise systems via a Hybrid Connector.

- **On-Premise MSR**:
  
  Manages mapping to Adapter format and orchestrates database operations, acting as a secure gateway for database interactions.

### Low-Level Design Details

1. **IMA Query Stock Flow**:
   
   - IMA sends a stock level query to webMethods.io API Gateway.
   - API Gateway authenticates the request using API keys from a secure vault.
   - Integration Service enriches the request and transforms JSON payload as needed.
   - Hybrid Connector securely forwards the request to the on-premise SMR.
   - SMR uses a JDBC adapter to execute the stock level query on the SQL Server.
   - SQL Server processes the request and returns the stock level data back through the same path.

2. **API Endpoint Definitions**:
   
   - **CRUD Operations API Definitions**:
     
     - **Read (Query Stock Levels)**: An API endpoint `/api/inventory/{productId}/stock-level` for retrieving current stock levels.
     - **Create (Add New Product)**: An endpoint `/api/inventory/new-product` for adding new product details to the database.
     - **Update (Adjust Stock Levels)**: An endpoint `/api/inventory/{productId}/update-stock` for updating stock quantities.
     - **Delete (Remove Discontinued Products)**: An endpoint `/api/inventory/{productId}/delete` for removing product records.

3. **Security Measures**:
   
   - Utilization of API keys for access control
   - TLS encryption for data in transit between cloud and on-premise components.

4. **Data Processing**:
   
   - Enrichment of Channel information to the JSON Payload
   - Conversion of enriched payload to My SQL query parameters.
   - Mapping and validation of request data through Integration Service before database interaction.

5. **Monitoring and Logging**:
   
   - Continuous monitoring of API health and performance metrics.
   - Logging of all transactions for audit trails and debugging.

**TDD**

Tests for the core functionalities based on the CRUD operations 
that involve interactions between the Inventory Management Application 
(IMA), webMethods.io integration platform, and the on-premise inventory 
database. -[!TDD](https://github.com/bramhanayaghea/webMethodsCAF/blob/develop/scenarios/retail/InventoryManagement-TDD.md)
