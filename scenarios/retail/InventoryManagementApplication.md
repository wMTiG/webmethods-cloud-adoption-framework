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
   
   1. IMA sends a stock level query to webMethods.io API Gateway.
   
   2. API Gateway authenticates the request using API keys from a secure vault.
   
   3. Integration Workflow/flow enriches the request with channel information  and transforms JSON payload as needed.
   
   4. Hybrid Connector securely forwards the request to the on-premise MSR.
   
   5. MSR uses a JDBC adapter to execute the stock level query on the MySQL Server DB.
   
   6. Inbound transaction is recorded in monitoring
   
   7. MySQL Server DB processes the request and returns the stock level data back MSR.
   
   8. MSR forwards to response wM i.o cloud flow/workflow
   
   9. wM.io flow/workflow maps the response and creates response JSON and returns response to wM.io API
   
   10. Outbound transaction is recorded in monitoring
   
   11. Response is fwded to IMA

2. **API Endpoint Definitions**:
   
   - **CRUD Operations API Definitions**:
     
     - **Read GET (Query Stock Levels)**: An API endpoint `/gateway/inventory/{productId}/stock-level` for retrieving current stock levels.
     - **Read GET (Get Product Details)**: An API endpoint '/gateway/inventory/v1/product?name={productName}' for getting product details
     - **Create POST (Add New Product)**: An endpoint `/gateway/inventory/v1/product` for adding new product details to the database.
     - **Update PUT (Update Product Details)**: An endpoint `/gateway/inventory/v1/product` for updating stock quantities.
     - **Update PATCH (Adjust Stock Levels)**: An endpoint `/gateway/inventory/v1/product/{productName}/updateStock` for updating stock quantities.
     - **Delete DELETE (Remove Product)**: An endpoint `/gateway/inventory/v1/product` for removing product record.

3. **Security Measures**:
   
   - Utilization of API keys for access control
   - TLS encryption for data in transit between cloud and on-premise components.

4. **Data Processing**:
   
   - Enrichment of Channel information to the JSON Payload
   - Conversion of enriched payload to My SQL query parameters.
   - Mapping and validation of request data through Integration Service before database interaction.
     
5. **System Configuration Details**
   
   ###### API Gateway configuration
   - **Purpose**: Manages and secures API traffic between the IMA and backend services.
   - **Details**:
     - **Routing Rules**: Define endpoint patterns and associate them with specific integration flows or services.
     - **Throttling**: Set limits on the number of requests per second (RPS) to protect backend services from overload.
     - **Security**: Configure API key validation, and if needed, OAuth2 flows for more granular access control.
   
   ###### API Key Management Configuration
   
   - **Purpose**: Securely manages API keys used for authentication and authorization.
   - **Details**:
     - **Vault Integration**: Set up integration with a secure vault for storing and retrieving API keys.
   
   ###### Hybrid Connectivity Configuration
   
   - **Purpose**: Establishes secure communication between cloud services and on-premise resources.
   - **Details**:
     - **Encryption**: Ensure that all data transmitted over the hybrid connection is encrypted using industry-standard protocols (e.g., TLS 1.2 or higher).
     - Configuration for edge environment
   
   ###### Database Connectivity Configuration (MSR & JDBC Adapter)
   
   - **Purpose**: Enables communication between the on-premise database and the integration services.
   - **Details**:
     - **JDBC Connection**: Configure connection strings, credentials (using encrypted storage), and connection pools for the JDBC adapter.
       
       
   
   ###### Monitoring and Logging Configuration
   
   - **Purpose**: Tracks system performance, usage metrics, and operational health.
   - **Details**:
     - **Monitoring Setup**: Configure monitoring tools for real-time insights.
     - **Logging**: Set log levels and configure log rotation and retention policies. Ensure sensitive data is masked or encrypted in logs.
   
   ###### Security Configuration
   
   - **Purpose**: Ensures system integrity, confidentiality, and availability.
   - **Details**:
     - **TLS/SSL**: Configure SSL certificates for all endpoints to ensure data is encrypted in transit.
     - **Authentication & Authorization**: Setup authentication mechanisms (API keys, OAuth tokens) and define role-based access controls for API endpoints.
   
   ###### Error Handling and Validation Configuration
   
   - **Purpose**: Provides consistent and informative error responses to client applications.
   - **Details**:
     - **Error Codes and Messages**: Define a standardized set of error codes and messages for common error scenarios.
     - **Validation Rules**: Implement request validation to catch and respond to invalid data before processing.

6. **Monitoring and Logging**:
   
   - Continuous monitoring of API health and performance metrics.
   - Logging of all transactions for audit trails and debugging.

**TDD**

Tests for the core functionalities based on the CRUD operations 
that involve interactions between the Inventory Management Application 
(IMA), webMethods.io integration platform, and the on-premise inventory 
database. -[TDD](https://github.com/bramhanayaghea/webMethodsCAF/blob/develop/scenarios/retail/tdd/InventoryManagement-TDD.md)
