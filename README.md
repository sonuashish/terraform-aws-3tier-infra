Infrastructure as Code (IaC) project to provision AWS EC2 instances and EBS volumes using Terraform, automated through a parameterized Jenkins Pipeline with remote state management (S3 + DynamoDB locking).

🚀 Terraform + Jenkins AWS Infrastructure Automation

This project provisions AWS infrastructure using Terraform and automates deployments through a Jenkins CI/CD Pipeline.
The infrastructure is managed using a remote backend stored in Amazon S3 with DynamoDB state locking to support team collaboration and prevent state conflicts.

🧱 Infrastructure Created
VPC
Public Subnet
Security Groups
EC2 Instances
3 EBS volumes attached to each EC2
Remote Terraform State (S3)
State Locking (DynamoDB)

⚙️ Tech Stack Tool Purpose 
Amazon Web Services Cloud Infrastructure 
Terraform Infrastructure as Code 
Jenkins CI/CD Automation 
Git Version Control 
Linux Execution Environment 

🔐 Remote Backend Configuration

Terraform state is stored remotely for team usage.
S3 Bucket: terraform-state-list-snapshots 
DynamoDB Table: terraform-state-file-dynamodb-table 
Region: ap-south-1

Benefits:
Prevents state corruption
Enables team collaboration
Provides locking mechanism

🧪 Jenkins Pipeline (Parameterized)

The pipeline supports 3 actions:
Parameter Function plan Preview infrastructure changes apply Deploy infrastructure destroy Remove infrastructure
The user selects environment workspace before execution.

▶️ How to Run 

1️⃣ Clone Repo git clone https://github.com//terraform-jenkins-aws-infra.git cd terraform-jenkins-aws-infra
2️⃣ Initialize Terraform terraform init
3️⃣ Select Workspace terraform workspace new dev terraform workspace select dev
4️⃣ Run terraform plan terraform apply
🔁 CI/CD Flow

Developer Push → Jenkins Trigger → Terraform Init → Workspace Select → Plan/Apply/Destroy → AWS Infra Update

📌 Key DevOps Concepts Demonstrated

Infrastructure as Code
Immutable Infrastructure
Remote State Management
State Locking
Parameterized Pipelines
Multi-Environment Deployment
Automated Provisioning

🧠 Learning Outcome
This project demonstrates how real production infrastructure is deployed in organizations using CI/CD pipelines and Terraform automation.

👨‍💻 Author
Ashish Ranjan Mahato

