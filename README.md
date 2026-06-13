# data-infra-terraform

## Overview
Infrastructure as Code (IaC) for a **Snowflake data platform** using **Terraform**, with a complete **GitHub Actions CI/CD pipeline** that runs `terraform plan` on pull requests and `terraform apply` on merge to main.

## Architecture
```
GitHub Actions CI/CD
    ↓ PR: terraform plan
    ↓ Merge: terraform apply
Terraform Modules
    ├── Snowflake Warehouses (XS, S, M, L)
    ├── Databases (raw, staging, prod)
    ├── Schemas (per environment)
    ├── Roles & Grants (RBAC)
    └── Service Accounts
```

## Tech Stack
- **IaC:** Terraform 1.x
- **Cloud DW:** Snowflake
- **CI/CD:** GitHub Actions
- **State Backend:** AWS S3 + DynamoDB (locking)
- **Provider:** Snowflake Terraform Provider

## Project Structure
```
data-infra-terraform/
├── modules/
│   ├── snowflake_warehouse/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── snowflake_rbac/
│       ├── main.tf
│       └── variables.tf
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
├── .github/
│   └── workflows/
│       └── terraform_ci.yml
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
└── README.md
```

## Key Features
- Modular Terraform design with reusable warehouse and RBAC modules
- GitHub Actions: `terraform plan` on every PR, `terraform apply` on main merge
- Separate dev/prod environments with different warehouse sizes
- Snowflake RBAC with principle of least privilege
- Remote state in S3 with DynamoDB locking (prevents concurrent applies)

## Setup
```bash
# Install Terraform
brew install terraform

# Set Snowflake credentials
export SNOWFLAKE_ACCOUNT=your_account
export SNOWFLAKE_USER=your_user
export SNOWFLAKE_PRIVATE_KEY_PATH=~/.ssh/snowflake_key.p8

# Initialize and apply
terraform init
terraform plan
terraform apply
```

## Results
- Provisioned **8 Snowflake warehouses** across dev/prod in under 5 minutes
- Eliminated **manual Snowflake admin tasks** (100% infrastructure automated)
- PR-based review process prevents accidental warehouse creation
- Environment parity between dev and prod

## Author
**Ashok Chowdary** | [LinkedIn](https://linkedin.com/in/ashok98765vvs) | [GitHub](https://github.com/Ashok98765vvs)
