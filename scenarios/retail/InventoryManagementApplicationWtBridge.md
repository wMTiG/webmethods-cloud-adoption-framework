**Use Case Description**

A retail company's inventory management system leverages webMethods iPaaS as an API-led Integration Platform as a Service (iPaaS) to connect cloud-hosted applications with an on-premise inventory database. The introduction of a bridge VPC/VNet enhances this architecture by providing a secure, controlled gateway for all data traffic between the cloud and on-premise environments, ensuring compliance with stringent security standards and enabling more flexible connectivity options.

**High-Level Architecture Overview**



- **Inventory Database (On-Premise)**: This remains the core repository for all inventory-related data, such as stock levels, product information, pricing, and supplier details, residing within the company's secure, on-premise infrastructure.

- **On-Premise Integration Server**: Acts as a secure gateway facilitating communication between the on-premise database and the cloud, now enhanced with connectivity through the bridge VPC/VNet for additional security and control.

- **webMethods.io API Gateway**:
  
  Mediates API calls from the Inventory Management Application (IMA), implementing actions like authentication, request routing, and throttling, now routing these through the bridge VPC/VNet

- **webMethods.io Integration Platform (iPaaS)**: Handles business logic transformations, request enrichment with channel information, and preparation for on-premise communication. It now connects through the bridge VPC/VNet, securing all data flows.

- **Bridge VPC/VNet**: A new component in the architecture that acts as a secure mediator between the iPaaS and on-premise systems. It manages all incoming and outgoing data traffic, enhancing security protocols and supporting additional connectivity options like IPsec.

- **Inventory Management Application (IMA)**:  A cloud-hosted application that interfaces with the inventory database to manage stock levels, update product information, and process orders. It connects seamlessly with the webMethods iPaaS through the bridge VPC/VNet, ensuring all data exchanges are secure and compliant.

- **Hybrid Connectivity**:
  
  Establishes a more secure and controlled connection from the webMethods.io in the cloud to on-premise systems via the bridge VPC/VNet, replacing the previous direct hybrid connector.

- **On-Premise MSR**:
  
  Manages mapping to Adapter format and orchestrates database operations, acting as a secure gateway for database interactions.

### Low-Level Design Details

1. **IMA Query Stock Flow**:

   **Request Initiation**:

   - The Inventory Management Application (IMA) initiates a request to query stock levels. This request is sent to the webMethods.io API Gateway.

   **API Gateway Processing**:

   - **Authentication**: The API Gateway authenticates the request using API keys stored in a secure vault. This ensures that only authorized users or systems can initiate queries.
   - **Routing**: After authentication, the API Gateway routes the request to the webMethods.io Integration platform. The routing includes passing through the bridge VPC/VNet, which acts as an intermediary ensuring that all data transfers adhere to the defined security protocols.

   **Bridge VPC/VNet Security Handling**:

   - The request travels through the bridge VPC/VNet, which provides an additional layer of security. This includes:
     - **IPsec Encryption**: Encrypts data traffic between the cloud and on-premise components.
     - **Firewall Policies**: Applies firewall rules to guard against unauthorized data access and mitigate potential threats.
     - **Traffic Inspection and Filtering**: Inspects and filters traffic to ensure compliance with security policies and standards.

   **Data Transformation and Enrichment**:

   - Within the webMethods.io Integration platform, the request is enriched with necessary channel information and transformed into a format suitable for querying the on-premise database. This may involve converting the JSON payload into SQL query parameters.

   **Hybrid Connector to On-Premise MSR**:

   - The enriched and secured request is then forwarded from the webMethods.io Integration platform to the on-premise Microservice Runtime (MSR) via the bridge VPC/VNet. The hybrid connector securely transmits the request, maintaining encryption and adhering to security protocols.

   **Database Query Execution**:

   - The on-premise MSR receives the request and uses a JDBC adapter to execute the stock level query on the MySQL Server database. This component manages database interactions, ensuring that queries are executed efficiently and securely.

   **Data Retrieval and Response Preparation**:

   - Once the query is processed, the MySQL Server database sends the stock level data back to the MSR. The MSR then prepares the response, mapping the database results to a suitable JSON format for transmission back to the cloud.

   **Response Transmission through Bridge VPC/VNet**:

   - The response data is sent back through the bridge VPC/VNet, ensuring that the return path is as secure as the outbound path. Data remains encrypted and monitored as it moves back to the cloud.

   **Response Handling at Integration Platform**:

   - The webMethods.io Integration platform receives the response, performs any necessary final transformations or mappings, and forwards it to the API Gateway.

   **Final Delivery to IMA**:

   - The API Gateway sends the final, processed response back to the IMA, completing the query cycle. The IMA receives the stock level data, which it can then display or use for further business processing.

2. **API Endpoint Definitions**:
   
   While the functional roles of the API endpoints remain unchanged, their routing configuration has been significantly enhanced by the introduction of the bridge VPC/VNet:
   
   - **CRUD Operations API Definitions**:
     - **Read GET (Query Stock Levels)**: An API endpoint `/gateway/inventory/{productName}/stockLevel` for retrieving current stock levels.
     - **Read GET (Get Product Details)**: An API endpoint `/gateway/inventory/v1/product?name={productName}` for getting product details
     - **Create POST (Add New Product)**: An endpoint `/gateway/inventory/v1/product` for adding new product details to the database.
     - **Update PUT (Update Product Details)**: An endpoint `/gateway/inventory/v1/product` for updating stock quantities.
     - **Update PATCH (Adjust Stock Levels)**: An endpoint `/gateway/inventory/v1/product/{productName}/updateStock` for updating stock quantities.
  - **Delete DELETE (Remove Product)**: An endpoint `/gateway/inventory/v1/product` for removing product record.
   - **Enhanced Security Routing**: All API traffic, regardless of the type of operation (CRUD), is routed through the bridge VPC/VNet. This setup ensures that all communications between the cloud services and on-premise systems pass through a controlled, secure environment.
   - **Endpoint Management**: Each API endpoint, such as those for querying stock levels, updating product details, or processing orders, is configured to interface seamlessly with the bridge VPC/VNet. This ensures that endpoint communications benefit from the added security and performance optimizations provided by the bridge.
   
3. **Security Measures**:

   -  Utilization of API keys for access control
   - TLS encryption for data in transit between cloud and on-premise components.
   - **Comprehensive Data Security**: The bridge VPC/VNet is equipped with multiple layers of security measures, including IPsec encryption for all data in transit. This ensures that sensitive data, such as inventory details and customer information, is securely encrypted as it moves between cloud and on-premise environments.
   - **Advanced Threat Protection**: Firewalls and intrusion detection/prevention systems within the bridge VPC/VNet actively monitor and block malicious traffic and unauthorized access attempts. This proactive security measure helps to maintain the integrity and confidentiality of the data.
   - **Consistent Security Policies**: The bridge VPC/VNet enables the enforcement of consistent security policies across all connected systems. This unified approach simplifies security management and reduces the risk of configuration errors that could lead to vulnerabilities.

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

7. ##### Bridge VPC/VNet Configuration

   - **Purpose**: Acts as the central hub for routing and securing all data traffic between cloud-based applications and on-premise systems, enhancing the overall security posture and connectivity flexibility of the architecture.
   - **Security Enhancements**:
     - **IPsec Tunnels**: Configures IPsec tunnels to provide a secure, encrypted pathway for data traffic, shielding communications from eavesdropping and tampering.
     - **Firewalls**: Implements stateful and stateless firewall configurations to meticulously inspect and control incoming and outgoing network traffic based on predetermined security rules.
     - **Advanced Monitoring Tools**: Deploys a suite of monitoring tools within the bridge to continuously track system performance, detect anomalies, and trigger alerts for potential security incidents. This enables real-time security and operational oversight.

**TDD**

Tests for the core functionalities based on the CRUD operations 
that involve interactions between the Inventory Management Application 
(IMA), webMethods.io integration platform, and the on-premise inventory 
database. -[TDD]([webmethods-cloud-adoption-framework/scenarios/retail/InventoryManagement-TDD.md at develop · wMTiG/webmethods-cloud-adoption-framework · GitHub](https://github.com/wMTiG/webmethods-cloud-adoption-framework/blob/develop/scenarios/retail/InventoryManagement-TDD.md))