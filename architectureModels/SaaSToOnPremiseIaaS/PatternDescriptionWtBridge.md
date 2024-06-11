# Pattern Description

This pattern describes a bridge-based VPC/VNet architecture that enhances the flexibility and control over connectivity between internal customer networks and external systems. While iPaaS offers secure and fast connections via private links, it does not natively support all customer-specific requirements such as IPsec. Our bridge architecture fills this gap, allowing for the integration of IPsec and other protocols to manage diverse connectivity scenarios. This setup not only maintains the inherent security benefits of private links but also extends the iPaaS capabilities to accommodate a wider range of secure and versatile integration options.

## Use Cases

Ideal for businesses that require robust, secure, and customizable connectivity solutions to integrate cloud-based systems with on-premises infrastructure, particularly in industries such as finance, healthcare, or government where secure data handling and regulatory compliance are paramount.

# Architecture Principles

- **Security**: Achieves high-level security by using dedicated bridge VPCs/VNets that isolate network traffic, thus reducing exposure to threats and vulnerabilities. Leverages both the inherent security of private links and additional protocols like IPsec within the bridge VPCs/VNets to ensure robust data protection
- **Scalability**: Adapts to changing demands without requiring significant restructuring of the underlying network infrastructure.
- **Reliability**: Ensures dependable connectivity and minimizes disruptions by managing access and isolating components through dedicated network segments.
- **Efficiency**: Optimizes network management and prevents address conflicts by strategically segmenting the network space.

# Logical Flow Structure

The architecture involves the use of private links to connect isolated iPaaS components within dedicated bridge VPCs/VNets. These bridges act as secure gateways that manage diverse connectivity paths to internal networks, safeguarding against unauthorized access and traffic.

# Deployment Structure

- **Cloud Component**: Software AG’s webMethods.io or Integration Cloud deployed in the cloud which are connected through secure private links to bridge VPCs/VNets.
- **On-Premises Component**: webMethods MSR
- **Bridge VPCs/VNets**: Serve as the central control points for managing traffic between the cloud and internal networks, equipped with robust security configurations to ensure comprehensive data protection and isolation.
- **Network**: Utilizes private links for secure communications, with IPsec tunnels added for enhanced encryption as needed.

# Variants

- Customer VPC with Edge Instance
- Ipaas with CRT
- **Expanded Monitoring**: While standard iPaaS monitoring tools are available, additional observability tools can be integrated within the bridge VPCs/VNets to enhance monitoring capabilities and proactive management.

# Components

- **Software AG webMethods.io**: Facilitate data integration , automation workflows and orchestrating integration.
- **Bridge VPCs/VNets**: Facilitate additional security and connectivity protocols beyond standard iPaaS capabilities.
- **On-Premises Middleware**: webMethods Integration Server for handling on-premises business logic.
- **IS Agent**
- **Security Components**: Secure gateways. firewalls, encryption tools, comprehensive access controls.

# Performance and Scaling

- Auto-scaling capabilities in the webMethods i.o to handle peak loads.
- Active-active bridge components
- Load balancing on-premises for optimal utilization of resources.

# Security Considerations

- **Advanced Authentication Protocols**: Implements industry-standard protocols such as OAuth and SAML to ensure secure and verified access control across all integration points.
- **Comprehensive Data Encryption**: Enforces stringent encryption practices for data both in transit and at rest, utilizing robust encryption algorithms to protect sensitive information against unauthorized access.
- **Regulatory Compliance**: Adheres to relevant data protection regulations, including GDPR, HIPAA, and others, to ensure compliance across different jurisdictions and sectors. Regular audits and updates are conducted to align with evolving legal requirements.
- **Protocol-Specific Security**: Accommodates the use of additional security protocols such as IPsec within the bridge VPCs/VNets, providing an extra layer of security for data transmission that is crucial for sensitive customer environments.
- **Isolated Network Segments**: Utilizes dedicated bridge VPCs/VNets to minimize the risk of lateral movement and provide controlled connectivity, enhancing security against potential intrusions and network vulnerabilities.

# Monitoring

- End-to-end transaction monitoring using wM i.o end to end monitoring and open telemetry API's.
- **Comprehensive Network Monitoring**: Implements a robust monitoring strategy across all network segments, including bridge VPCs/VNets and iPaaS components. Utilizes advanced network monitoring tools to track real-time traffic, detect anomalies, and monitor the health and performance of network infrastructure.
- **Application and Service Monitoring**: Integrates application performance monitoring (APM) tools to oversee and manage the performance and availability of applications running on iPaaS platforms. This includes tracking response times, throughput rates, and error rates.
- **Security Event Monitoring**: Employs security information and event management (SIEM) systems to continuously monitor for security threats and vulnerabilities. This includes automated alerts for suspicious activities, ensuring rapid response to potential security incidents.
- **Customizable Dashboards and Reporting**: Offers customizable dashboards that provide stakeholders with real-time views of their system's status and health. Periodic reports are generated to assess performance, utilization, and security posture over time.

# DevSecOps

- **Integrated Development Pipelines**: Utilizes continuous integration (CI) and continuous deployment (CD) pipelines to streamline development, testing, and deployment processes. These pipelines are designed to incorporate security checks and testing at every stage, ensuring that new code is both functional and secure before it is deployed to production environments.
- **Automated Security Scanning**: Incorporates automated security scanning tools within the CI/CD pipelines to detect vulnerabilities early. This includes static application security testing (SAST), dynamic application security testing (DAST), and dependency scanning to identify insecure libraries or outdated components.
- **Configuration Management**: Employs configuration as code practices to maintain consistency across environments, reducing human errors and ensuring compliance with security standards. All changes are tracked and version-controlled, allowing for quick rollbacks and detailed audit trails.
- **Security Policy Enforcement**: Defines and enforces security policies programmatically across all stages of application and infrastructure management. This ensures that all deployments comply with organizational security standards and regulatory requirements.
- **Feedback Loop Integration**: Establishes robust feedback mechanisms that allow security and operations teams to provide input into the development process. This ensures continuous improvement of the products and processes, with security and operational considerations being addressed proactively.

# Challenges and Solutions

- **Network Latency**: For Software AG iPaaS integrated environments, implementing caching mechanisms and data replication across distributed nodes can significantly reduce latency. This ensures efficient data transfer between cloud and on-premises environments, maintaining performance across geographically dispersed infrastructures.
- **Security**: To enhance security within the Software AG iPaaS environment, establishing rigorous identity and access management protocols is crucial. Utilizing multi-factor authentication, role-based access controls, and fine-grained permission settings can help mitigate unauthorized access and ensure data integrity.
- **Cloud Ops:** The current approach requires on-prem IS restart and update hybrid settings.
- **Failover Management:** There is no option to block a particular on-prem IS
- **Throttling Management**: Addressing the absence of native throttling capabilities in Software AG iPaaS by integrating custom throttling mechanisms within the bridge VPC/VNet. This allows for better management of resource consumption and prevents system overload during peak times, ensuring stable and reliable performance.

# Associated Assets

- Pre-built connectors for popular SaaS platforms.
- Sample integration flows and templates available in Software AG’s repository.

# Examples

- **Customer Case Study**: A retail company integrating Salesforce with their on-premises ERP system for real-time inventory updates.
- **Implementation Details**: Utilization of webMethods.io for transforming and routing data between Salesforce and the on-premises ERP.
