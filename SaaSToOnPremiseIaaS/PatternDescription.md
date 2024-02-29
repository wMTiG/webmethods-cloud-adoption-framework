# Pattern Description

This pattern describes how a hybrid integration platform enables 
synchronous service calls from external consumers like SaaS or B2B 
systems to applications hosted on-premises or on PaaS/IaaS.

## Use Cases

Ideal for scenarios where real-time data exchange is required between 
cloud-based SaaS applications (like CRM, ERP) and on-premises systems 
for purposes like order processing, inventory updates, or customer data 
synchronization.

# Architecture Principles

- **Efficiency**: Minimizing latency in data transmission between SaaS and on-premises systems.
- **Security**: Ensuring secure data transit and compliance with data privacy regulations.
- **Scalability**: Ability to handle varying loads without degradation of performance.
- **Reliability**: High availability of services and fault tolerance.

# Logical Flow Structure

![Logical flow](https://github.com/bramhanayaghea/webMethodsCAF/blob/develop/SaaSToOnPremiseIaaS/A1-Logical-hybrid-connector.jpg)

# Deployment Structure

![Depoloyment Arch](https://github.com/bramhanayaghea/webMethodsCAF/blob/develop/SaaSToOnPremiseIaaS/A1-Deployment-hybrid-connector.jpg)

- **Cloud Component**: Software AG’s webMethods.io or Integration Cloud deployed in the cloud.

- **On-Premises Component**: webMethods Integration Server or Terracotta for in-memory data storage and processing.

- **Network**: Secure, encrypted connections, possibly through a VPN or direct cloud-to-on-premise link (private link ???)

# Variants

- On-prem connectivity using https
- On-Prem connectivity using private link for Customers private cloud - [https://github.com/bramhanayaghea/webMethodsCAF/blob/develop/SaaSToOnPremiseIaaS/PatternDescriptionWtPrivateLink.md](Private Link)
  
  

# Components

- **Software AG webMethods.io**: Serves as the iPaaS for orchestrating integration.
- **On-Premises Middleware**: webMethods Integration Server for handling on-premises business logic.
- **IS Agent**
- **Security Components**: Secure gateways, firewalls, and encryption tools.

# Performance and Scaling

- Auto-scaling capabilities in the webMethods i.o to handle peak loads.

- Load balancing on-premises for optimal utilization of resources.

# Security Considerations

- Implementation of OAuth, SAML for secure authentication.
- Data encryption both in transit and at rest.
- Compliance with relevant data protection regulations.

# Monitoring

- End-to-end transaction monitoring using wM i.o end to end monitoring and open telemetry API's.
- Real-time alerts and logging for tracking transaction flow.

# DevSecOps

- Automated deployment pipelines integrating cloud and on-premises components.
- Continuous security assessments and compliance checks.

# Challenges and Solutions

- **Network Latency**: Implementing caching or data replication strategies.
- **Security**: Establishing robust identity and access management protocols.
- **Devops:** The current approach requires on-prem IS restart and update hybrid settings.
- **Failover: ** There is no option to block a particular on-prem IS
- Missing throttling capability

# Associated Assets

- Pre-built connectors for popular SaaS platforms.
- Sample integration flows and templates available in Software AG’s repository.

# Examples

- **Customer Case Study**: A retail company integrating Salesforce with their on-premises ERP system for real-time inventory updates.
- **Implementation Details**: Utilization of webMethods.io for transforming and routing data between Salesforce and the on-premises ERP.
