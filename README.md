# multi-region AWS Infrastructure with Terraform

This project implements a modular, multi-region, and multi-environment AWS infrastructure using Terraform. It follows a **Hub & Spoke** networking architecture with centralized management.

## 📂 Project Structure

```text
terraform/
├── environments/
│   ├── development/    # Development Environment
│   ├── staging/        # Staging Environment
│   ├── production/     # Production Environment (Hub VPC Location)
│   └── mirror/         # Mirror/Testing Environment
│       └── <region>/   # e.g., us-west-2
│           ├── control/     # CENTRAL HUB (Only in Production)
│           ├── application/ # App Spoke VPC
│           ├── database/    # Database Spoke VPC (Private)
│           └── peering/     # Peering Connection to Production Hub
├── modules/            # Reusable Infrastructure Modules
│   ├── vpc/            # VPC, Subnets, Gateways
│   ├── ec2/            # EC2 Instances & Security Groups
│   ├── peering/        # VPC Peering & Route Updates
│   └── iam/            # IAM Roles & Instance Profiles
└── global/             # Account-wide Resources
    ├── backend/        # S3 & DynamoDB for Terraform Remote State
    └── iam/            # Global Users, Groups, and Policies
```

## 🚀 Key Architectural Concepts

### 1. Centralized Hub & Spoke
*   The **Control VPC** (Hub) is centralized within the `production` environment.
*   All other environments (`development`, `staging`, `mirror`) connect to this hub via **VPC Peering**.
*   This allows centralized monitoring, bastion access, and shared services.

### 2. State Management
All environments use a shared S3 bucket for remote state, organized by path:
`env/<environment>/<region>/<component>/terraform.tfstate`

### 3. IAM Strategy
*   **Reusable Templates**: Stored in `modules/iam/`.
*   **Global Resources**: Stored in `global/iam/`.
*   **Env-Specific Roles**: Defined within the specific component's `main.tf` by calling the `iam` module.

## 🛠 Deployment Guide

### Prerequisites
1.  Initialize the backend storage first: `cd global/backend && terraform init && terraform apply`.
2.  Deploy the Central Hub (Hub VPC): `cd environments/production/us-west-2/control && terraform init && terraform apply`.

### Deploying an Environment (e.g., Development)
To deploy a spoke environment, follow this order:
1.  **VPCs**: Deploy `application` and `database` VPCs.
2.  **Peering**: Deploy the `peering` component last to link the spokes to the hub.

```bash
# Example for Development
cd environments/development/us-west-2/application && terraform apply
cd environments/development/us-west-2/database    && terraform apply
cd environments/development/us-west-2/peering     && terraform apply
```

## ⚖️ Style Guide
This project follows the **HashiCorp Terraform Style Guide**:
*   Clear separation of `terraform.tf`, `providers.tf`, `main.tf`, `variables.tf`, and `outputs.tf`.
*   Mandatory descriptions for all variables and outputs.
*   Consistent snake_case naming conventions.
