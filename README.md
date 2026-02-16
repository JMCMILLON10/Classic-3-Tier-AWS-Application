# ☁️ 3-Tier Architecture | Why Fundamentals Still Matter ☁️

In Cloud Engineering, it’s easy to become obsessed with newer services, abstractions, and tooling layers.

But real stability, scalability, and resilience are built on fundamentals.

This project revisits a classic 3-tier architecture on AWS, provisioned entirely with Terraform, reinforcing the architectural patterns that continue to power modern cloud systems.

An Application Load Balancer (ALB) acts as the presentation layer — intelligently routing traffic while performing continuous health checks to maintain workload availability.

The application layer consists of Apache web servers running on EC2, deployed across multiple Availability Zones inside private subnets. This design prioritizes high availability, controlled ingress paths, and network isolation — key concepts in both reliability engineering and cloud security.

For the data layer, Amazon DynamoDB is integrated using a VPC Endpoint, allowing private service communication without traversing the public internet. Access is governed via IAM roles, eliminating credential management risks while enforcing least-privilege permissions.

One of the most valuable lessons from this build:

Architecture failures often stem from small misconfigurations — not major design flaws.

Health check paths, OS package behavior, service initialization order, and networking rules all directly impact system reliability.

Before scaling complexity, master stability.

Before adding layers, understand flow.

Fundamentals are the multiplier.

![image alt](https://github.com/JMCMILLON10/Classic-3-Tier-AWS-Application/blob/main/Diagram.png)
