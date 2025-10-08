📘 Terraform Infrastructure as Code (IaC) Blueprints

A collection of production-grade Terraform blueprints for AWS.
This repository showcases real-world cloud engineering skills in areas like VPC design, secure networking, EC2 provisioning, and reusable IaC patterns.

📂 Repository Structure
terraform-iac/
│── terraform-aws-vpc-blueprint/     # VPC with public/private subnets, IGW, NAT
│── terraform-aws-secure-network/    # VPC + Security Groups + NACLs
│── infra-as-code-examples/          # Small IaC demos (EC2, S3, etc.)
│── README.md                        # Main repo overview

🚀 Projects
1. terraform-aws-vpc-blueprint

A Terraform module that provisions:

Custom VPC with DNS support

Public & private subnets across AZs

Internet Gateway + NAT Gateway


2. terraform-aws-secure-network

A secure AWS network example:

VPC with isolated subnets

Security groups for web traffic (HTTP/HTTPS)

Example Network ACLs


3. infra-as-code-examples

Small, practical IaC examples to get started:

EC2 instance provisioning

S3 bucket with random name

Expandable collection for beginners


🛠️ Prerequisites

Terraform
 ≥ 1.5

AWS CLI configured with proper credentials

An AWS account

📖 Usage

Clone the repo:

git clone https://github.com/<your-username>/terraform-iac.git
cd terraform-iac/terraform-aws-vpc-blueprint


Initialize Terraform:

terraform init
terraform plan
terraform apply


Destroy resources:

terraform destroy

📊 Example Architecture (VPC Blueprint)
+---------------------------+
|        AWS VPC            |
|                           |
|   +--------+   +--------+ |
|   | Public |   | Private| |
|   |Subnet1 |   |Subnet1 | |
|   +--------+   +--------+ |
|   | Public |   | Private| |
|   |Subnet2 |   |Subnet2 | |
|   +--------+   +--------+ |
| IGW  NAT GW             |
+---------------------------+

💡 Why This Repo?

Demonstrates real-world cloud engineering patterns.

Acts as a portfolio for DevOps/Cloud roles.

Provides ready-to-use blueprints for learning or production.

🔮 Roadmap

 Add EKS (Kubernetes) example

 Add RDS PostgreSQL with backups

 Add CI/CD pipeline (GitHub Actions) for Terraform validation

 Add Cost Optimisation examples

📜 License

This repo is licensed under the MIT License – feel free to use, modify, and share.

👨‍💻 Author

Jubin Joseph
Cloud & Platform Engineer | AWS | Terraform | Kubernetes | CI/CD

🌐 LinkedIn - http://www.linkedin.com/in/jubin-joseph-8a1b75254

🐙 GitHub - https://github.com/JubinCloud