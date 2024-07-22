# Pattern Description

This pattern describes an asynchronous messaging architecture for hybrid integration platforms that facilitate interactions between cloud-based SaaS applications and on-premises systems. The architecture is designed to enable efficient, reliable, and scalable communication, enhancing operational flexibility and system performance.

## Use Cases

- Ideal for enterprises requiring asynchronous messaging for:
  - **Data exchange between cloud and on-premise systems**: Asynchronously transferring data between disparate environments without requiring real-time availability of both parties.
  - **Bulk data processing**: Distributing large datasets across worker applications for parallel processing.
  - **Decoupling of application components**: Enhancing scalability and maintainability.
  - **Ensuring reliable message delivery and processing**: In distributed environments.

# Architecture Principles

- **Loose Coupling**: Applications don't wait for responses from message consumers, enhancing system independence and scalability.
- **Improved Performance**: Sending messages asynchronously avoids blocking the sender, allowing it to continue processing tasks.
- **Reliability**: Messages are queued and delivered eventually, ensuring data isn't lost due to temporary outages.
- **Scalability**: The messaging system can handle increased message volume by adding more workers or resources.
- **Security**: Guarantees that all messages are captured, transmitted, and stored securely, with sensitive information adequately protected.
- **Flexibility**: Optional use of schema-less NoSQL stores to accommodate diverse message formats and structures.

# Logical Flow Structure

**Message Generation**:

- Business services across both cloud-hosted applications and on-premise systems generate messages during normal operations. These messages capture detailed information about transactions, system status, errors, and other relevant operational data.

**Message Processing and Enrichment**:

- Messages are processed and optionally enriched to add metadata that facilitates more effective analysis. This step might occur in the cloud or at edge locations in hybrid setups.

**Cloud Messaging**:

- Processed messages are published to topics within the cloud messaging system. This system acts as a mediator, ensuring messages are appropriately queued and distributed to subscribers. Note that maintaining message order may compromise performance, especially with parallel subscriptions.

**Subscription and Further Processing**:

- Message subscribers consume messages from cloud messaging topics. These subscribers are responsible for additional processing steps, such as filtering, aggregation, or transformation, based on the requirements of the business tasks. Ordering may be relaxed to enhance performance.

**Optional Storage in Managed NoSQL Store**:

- Finally, the messages can be forwarded to a managed NoSQL store. This store not only archives the messages but also supports complex queries and analytics, allowing organizations to derive operational insights and track long-term trends.

**Message Flow**

1. **Producer creates message**:
   - The producer creates a message containing data it wants to share with other applications.
2. **Publish message to topic**:
   - The producer publishes the message to a specific topic within the message broker.
3. **Message broker routes message**:
   - The message broker identifies subscribed consumers for the topic and routes a copy of the message to each consumer's queue.
4. **Consumer receives message**:
   - Consumers periodically poll their queues for new messages and process them as needed.

# Deployment Structure

- **Cloud Messaging**: Acts as the central hub for all logging operations. Logs are published to topics managed within the cloud messaging system and consumed by designated subscribers.
- **Logging Wrapper Service**: A generic service that abstracts the logging mechanism, providing a unified interface for business services to send log data.
- **Logging Subscriber**: A dedicated service that subscribes to log topics, processing and forwarding the log data to the (optional) NoSQL analytic store.
- **Managed NoSQL Analytic Store**: Stores and processes large volumes of log data, providing powerful indexing and querying capabilities for analytics.

# Variants

**Integration with External Cloud Messaging Platforms**: Extends the architecture to include integration with external messaging services like AWS Kinesis, Google Pub/Sub, or Azure Event Hubs, enhancing external scalability and interoperability.

**Hybrid Storage Solutions**: Combines NoSQL with traditional RDBMS or data lakes where structured data storage is also required, providing a more comprehensive data storage strategy.

**Cloud-Only Messaging**:

- In this variant, all message data is processed and stored temporarily within cloud components and asynchronously pushed to the managed NoSQL store for long-term storage and analysis. This approach is optimal for environments fully vested in cloud infrastructure, minimizing latency in message processing and simplifying the architecture.

**Hybrid Messaging**:

- This approach involves simultaneous messaging at both cloud and on-premise components. Messages generated on-premise are synchronized with cloud storage, ensuring redundancy and enhanced security. This variant is particularly beneficial for environments where on-premise systems handle critical operations, and additional redundancy is required for disaster recovery and compliance purposes.

**Point-to-Point Messaging**: A single consumer receives each message.

**Fanout Messaging**: The message broker broadcasts the message to all connected consumers, regardless of their subscription.

# Components

- **Message Producer**: Application or service that creates and publishes messages to a topic.
- **Message Broker**: Centralized service responsible for routing messages to interested consumers.
- **Message Queue**: Temporary storage for messages before they are delivered to consumers.
- **Message Consumer**: Application or service that subscribes to topics and receives relevant messages from the queue.

# Performance and Scaling

- Auto-scaling capabilities in the webMethods i.o to handle peak loads.

- Load balancing on-premises for optimal utilization of resources.

# Security Considerations

- **Message Authentication**: Ensure only authorized producers can publish messages to specific topics.
- **Message Authorization**: Control which consumers have access to messages on a topic.
- **Data Encryption**: Encrypt messages in transit and at rest to protect sensitive information.
- **Network Security:** Implement firewalls and access controls to secure communication between cloud and on-premise components.

# Monitoring

- **Real-time Message Monitoring**: Continuously monitors the message flow and alerts system administrators about critical events or patterns that indicate potential issues.

  **Message Analytics**: Advanced analytics tools are applied to message data to derive insights into system performance, user behavior, and potential security threats.

# DevSecOps

**Integrated Messaging in CI/CD** means that messaging mechanisms are incorporated into the Continuous Integration/Continuous Deployment (CI/CD) pipeline. This integration allows messages to be captured and processed from the earliest stages of development and testing, ensuring that any issues related to messaging can be detected and resolved early in the development cycle. It also allows for continuous monitoring and logging of messages throughout the deployment process, enhancing traceability and debugging.

**Automated Message Analysis** refers to the use of automated tools to analyze message data for security and compliance checks. This involves setting up systems that can automatically scan and review message contents and metadata to identify potential security threats, compliance violations, or operational issues. These tools help ensure that the messaging system adheres to security policies and regulatory requirements without the need for manual inspection.

# Challenges and Solutions

- **High Data Volume**: Implements data compaction and intelligent filtering to manage the volume of messages generated.
- **Performance Impact**: Uses asynchronous and buffered messaging to mitigate the impact on application performance.
- **Ordering vs. Performance**: Balances the need for message order with performance requirements. In scenarios requiring high throughput, relaxing strict ordering can enhance performance.
- **Dead Letter Queues**: Implement mechanisms to handle undeliverable messages and prevent message loss.

# Associated Assets

- 

# Examples

A telecommunications provider uses this architecture to manage messages from its network operations center. The system employs wM.io cloud messaging for message handling. This setup allows for immediate response to network anomalies and system failures, supporting high availability and service reliability.

A robust logging architecture for hybrid integration platforms uses this pattern to facilitate interactions between cloud-based SaaS applications and on-premises systems. For instance, webMethods iPaaS publishes log data to cloud messaging services, which is then subscribed to and processed by a NoSQL analytic store. This setup ensures comprehensive log capture, processing, and storage, enhancing operational analytics, monitoring, and compliance.

This architecture provides a robust framework for comprehensive message management, ensuring organizations can handle vast amounts of data efficiently while gaining valuable insights into their operations.