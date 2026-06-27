# Terraform & Amazon EKS Production Infrastructure (Karpenter, ALB, HELM, IRSA) Automation

## Project Overview

Designed and implemented a complete Infrastructure as Code (IaC) platform using Terraform, AWS, Kubernetes, and DevOps best practices.

This project demonstrates end-to-end provisioning, automation, security, scalability, and Kubernetes orchestration in a production-style AWS environment.

---

## Technologies Used

* Terraform
* AWS
* Amazon EKS
* Kubernetes
* Karpenter
* AWS Load Balancer Controller (ALB)
* IAM Roles for Service Accounts (IRSA)
* Helm
* Amazon S3
* DynamoDB
* EC2
* VPC
* CoreDNS
* VPC CNI
* kube-proxy
* NGINX
* Shell Scripting
* Git
* AWS CLI
* kubectl

---
# Project Architecture

```text
Developer
    │
    ▼
Terraform
    │
    ├── AWS Provider
    ├── Helm Provider
    └── Kubernetes Provider
    │
    ▼
AWS Cloud
│
├── VPC
│   ├── Public Subnets
│   ├── Private Subnets
│   └── Intra Subnets
│
├── IAM
│   ├── EKS Cluster Role
│   ├── Node Group Role
│   ├── ALB Controller IRSA
│   └── Karpenter IRSA
│
├── Amazon EKS
│   ├── Control Plane
│   ├── Managed Node Group
│   ├── CoreDNS
│   ├── VPC CNI
│   └── kube-proxy
│
├── Karpenter
│   └── Dynamic Node Provisioning
│
├── AWS Load Balancer Controller
│   └── Application Load Balancer
│
└── Applications
    └── NGINX Deployment
```

---
## Terraform Hands-On Implementation

Completed in-depth Terraform implementation with hands-on projects covering:

### Infrastructure Provisioning

* Provisioned Amazon EC2 instances using Terraform.
* Provisioned Amazon S3 buckets using Terraform.
* Automated NGINX installation using Shell Scripting and Terraform User Data.
* Implemented secure IAM user access with restricted permissions following least-privilege principles.

### Terraform Core Concepts

* String Interpolation
* Variables
* Outputs
* Locals
* Conditional Expressions
* For Loops
* Dynamic Resource Creation
* Modules
* Data Sources
* Dependency Management

### State Management

* Configured Remote Backend using Amazon S3.
* Protected Terraform State using DynamoDB State Locking.
* Implemented secure and centralized state management.
* Prevented concurrent state modification conflicts.

### Resource Importing

* Imported existing AWS resources into Terraform State.
* Imported existing EC2 instances.
* Imported deleted AWS Key Pairs back into Terraform management.
* Managed infrastructure drift through Terraform Import operations.

### Multi-Environment Architecture

* Implemented Terraform Workspaces.
* Created isolated Dev, Test, and Production environments.
* Managed environment-specific deployments using shared Terraform code.

---

# Amazon EKS Infrastructure Automation

## EKS Cluster Provisioning

Provisioned a production-style Amazon EKS cluster using Terraform Modules.

### Features Implemented

* Amazon EKS Cluster Deployment
* Managed Node Groups
* Kubernetes Addons Management
* IAM Roles for Service Accounts (IRSA)
* AWS Load Balancer Controller
* Karpenter Autoscaling
* Helm Provider Integration
* Kubernetes Provider Integration
* AWS Provider Integration

### Cluster Optimization

Optimized EKS provisioning and node startup process by:

* Using optimized EKS AMIs.
* Configuring appropriate AMI Types.
* Reducing node bootstrapping time.
* Streamlining cluster provisioning workflow.
* Reduced cluster deployment time from approximately 15 minutes to nearly 1 minute.

### Future Infrastructure Readiness

Configured reusable Terraform outputs for:

* Amazon RDS Integration
* ArgoCD Integration
* Future Platform Expansion

---

# Post Deployment Validation

After deployment I successfully performed the following validations:

### Cluster Validation

* Verified node registration using:

```bash
kubectl get nodes
```

* Verified Kubernetes cluster health.
* Verified worker node connectivity.

### Addon Validation

Verified essential Kubernetes addons:

* CoreDNS
* VPC CNI
* kube-proxy

### Application Deployment

* Deployed an NGINX application to Kubernetes.
* Created Kubernetes Deployment manifests.
* Verified pod scheduling across worker nodes.

### Service Exposure

* Exposed NGINX through a LoadBalancer Service.
* Provisioned external AWS Load Balancer.
* Verified public application accessibility.

### Kubernetes Operations

* Demonstrated Kubernetes Scaling.
* Demonstrated Pod Scheduling.
* Demonstrated Workload Distribution.
* Validated Cluster Networking.
* Validated Service Discovery.

---

# Performance Optimizations Implemented

### Terraform Optimizations

* Terraform Modules
* Reusable Infrastructure Components
* Remote Backend
* State Locking
* Workspace-Based Environment Isolation

### EKS Optimizations

* Optimized EKS AMIs
* Managed Node Groups
* Karpenter Node Provisioning
* Reduced Node Bootstrap Time
* Efficient Kubernetes Scheduling

### Deployment Improvements

* Reduced EKS deployment time from approximately 15 minutes to nearly 1 minute.
* Automated infrastructure provisioning.
* Eliminated manual Kubernetes cluster setup.
* Improved scalability and operational efficiency.

---

# Security Best Practices Implemented

* Principle of Least Privilege (PoLP)
* IAM Role Separation
* IRSA for Kubernetes Pods
* Private Worker Nodes
* Remote State Protection
* State Locking with DynamoDB
* Restricted IAM User Permissions
* Controlled AWS Resource Access
* Infrastructure as Code Governance

---

# Key DevOps Skills Demonstrated

* Infrastructure as Code (IaC)
* Terraform
* AWS Cloud
* Amazon EKS
* Kubernetes Administration
* Kubernetes Networking
* Karpenter Autoscaling
* Cluster Optimization
* Helm Package Management
* IAM Security
* IRSA
* VPC Design
* EC2 Provisioning
* S3 Backend Management
* DynamoDB State Locking
* Shell Scripting
* DevOps Automation
* Cloud Infrastructure Management
* Load Balancing
* Application Deployment
* Scalability Engineering
* High Availability Architecture
* Infrastructure Automation
* Production Environment Management
* GitOps Readiness
* ArgoCD Ready Architecture
