# Multi-Region AWS Infrastructure (Terraform)

> [!NOTE]
> **Consultation & Implementation Services**
> If you are interested in consulting or professional implementation for your company, please feel free to reach out:
> - **Name**: Ersa Azis Mansyur
> - **Email**: [eam24maret@gmail.com](mailto:eam24maret@gmail.com)
> - **LinkedIn**: [linkedin.com/in/ersaazis](https://www.linkedin.com/in/ersaazis/)

---

This project implements a modular, multi-region, and multi-environment AWS infrastructure using Terraform. It follows a **Hub & Spoke** networking architecture with centralized management.

For a detailed map of VPC CIDRs and connectivity rules, see **[PROJECT.md](PROJECT.md)**.

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

## 🛠 Deployment Guide (Start from Zero)

Follow these steps to deploy the entire infrastructure from a blank AWS account.

### Step 1: AWS Authentication

Configure your credentials:
```bash
# Interactive configuration
aws configure
```

Alternatively, set environment variables:
```bash
export AWS_ACCESS_KEY_ID="your_key"
export AWS_SECRET_ACCESS_KEY="your_secret"
export AWS_REGION="us-west-2"
```

### Step 2: SSH Key Pair

This project manages its own SSH Key Pair using Terraform. This will generate **9 unique keys** (one for each environment and component) and upload them to AWS:
```bash
cd global/keys
terraform init
terraform apply
```
*(This will automatically save all private keys to `~/.ssh/secret-key-*.pem` with correct permissions.)*

### Step 3: Bootstrap State Storage (Global)
Before any other component, you must create the S3 bucket and DynamoDB table for Terraform state.
```bash
cd global/backend
terraform init
terraform apply
```
*(After this step, a `terraform.tfbackend` file will be automatically created in the project root.)*

### Step 4: Deploy the Central Hub (Production)
The Hub VPC must exist before any spokes can be peered to it.
```bash
cd ../../environments/production/us-west-2/control
terraform init -backend-config=../../../terraform.tfbackend
terraform apply
```

### Step 5: Deploy Environment Spokes (e.g., Development)
Each environment should be deployed in the following order:
1.  **Application VPC**: `cd ../../development/us-west-2/application && terraform init -backend-config=../../../../terraform.tfbackend && terraform apply`
2.  **Database VPC**: `cd ../../development/us-west-2/database && terraform init -backend-config=../../../../terraform.tfbackend && terraform apply`
3.  **Peering**: `cd ../../development/us-west-2/peering && terraform init -backend-config=../../../../terraform.tfbackend && terraform apply`

### Step 6: Cleanup (Destroy)
To avoid dependency errors, destroy resources in the **reverse order** of deployment:
1.  **Peering**: Destroy all peering connections in all environments.
2.  **Spokes**: Destroy all Application and Database VPCs in all environments.
3.  **Hub**: Destroy the `production/us-west-2/control` VPC.
4.  **Backend**: Finally, destroy the `global/backend` resources.

Example:
```bash
# Destroy peering first
cd environments/development/us-west-2/peering
terraform destroy -auto-approve
```

## ⚖️ Style Guide
This project follows the **HashiCorp Terraform Style Guide**:
*   Clear separation of `terraform.tf`, `providers.tf`, `main.tf`, `variables.tf`, and `outputs.tf`.
*   Mandatory descriptions for all variables and outputs.
*   Consistent snake_case naming conventions.

## ⚖️ License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
