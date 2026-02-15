🚀 Production-Grade AWS Infrastructure using Terraform & Jenkins
📌 Project Overview

This project provisions a production-style AWS infrastructure using Terraform modules and automates deployment through a parameterized Jenkins CI/CD pipeline.

The goal was to simulate real-world DevOps practices including environment isolation, infrastructure governance, and safe production deployment.

🏗 Architecture

The infrastructure includes:

VPC with custom CIDR

Public & Private Subnets

Internet Gateway

NAT Gateway

Route Tables

Security Groups

EC2 Instances (Web/App/DB pattern)

EBS (gp3, 20GB optimized)

Jenkins server auto-configured via user_data

Amazon Linux 2023 AMI is dynamically fetched using Terraform data source.

📂 Project Structure
modules/
   networking/
   compute/

env/
   dev/
   qa/
   prod/

Jenkinsfile

🌍 Environment Strategy

Terraform Workspaces:

dev

qa

prod

Each environment uses:

Separate tfvars

Isolated state

Dedicated deployment approval gates

Production destroy is blocked via pipeline guardrails.

🔄 CI/CD Pipeline (Jenkins)

Pipeline Features:

Parameterized ENV (dev / qa / prod)

Parameterized ACTION (plan / apply / destroy)

Auto workspace bootstrap

tfvars validation

terraform validate before plan

Approval gate for apply/destroy

Production protection

Concurrent build protection

Infrastructure lifecycle is fully automated via Jenkins.

🛠 Technologies Used

Terraform

AWS (EC2, VPC, NAT, EBS)

Jenkins

GitHub

Amazon Linux 2023

Bash scripting

🚀 How to Run Locally
terraform init
terraform workspace select dev
terraform plan -var-file=env/dev/terraform.tfvars

🎯 Key Learnings

Modular Infrastructure as Code design

Multi-environment state isolation

CI/CD governance patterns

Safe production controls

Infrastructure automation via user_data

Disk & JVM optimization for Jenkins
