# AWS 3-Tier Infrastructure using Terraform & Jenkins

This project provisions a production-style AWS infrastructure using Terraform modules and Jenkins CI/CD pipeline.

## Architecture
- VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- EC2 Instances (Web, App, DB)
- EBS Volumes

## Environments
Terraform Workspaces:
- dev
- qa
- prod

Each environment uses separate tfvars.

## Run Locally
terraform init
terraform workspace select dev
terraform plan -var-file=env/dev/terraform.tfvars

## CI/CD
Jenkins pipeline automatically:
- creates workspaces
- validates environment
- plans/applies infrastructure
- protects production from destroy
