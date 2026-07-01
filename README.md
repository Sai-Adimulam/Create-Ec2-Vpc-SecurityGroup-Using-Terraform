# Create-Ec2-Vpc-SecurityGroup-Using-Terraform

# Terraform AWS Infrastructure

## Project Overview

This project uses Terraform to create the following AWS resources:

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Route Table Association
* Security Group
* EC2 Instance

The infrastructure is created automatically using Infrastructure as Code (IaC) with Terraform.

---

## Architecture

```text
                Internet
                    |
          Internet Gateway (IGW)
                    |
               Public Route Table
                    |
             Public Subnet
                    |
        EC2 Instance (Public IP)
                    |
            Security Group
                    |
                  VPC
```

---

## Prerequisites

Before running this project, ensure you have:

* AWS Account
* AWS CLI configured
* Terraform installed
* Git installed
* An AWS Key Pair created in your chosen region

Verify the installations:

```bash
terraform -version
aws --version
git --version
```

---

## Project Structure

```text
terraform-project/
│
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── main.tf
├── outputs.tf
├── README.md
└── .gitignore
```

---

## Resources Created

### VPC

* Creates a custom VPC.
* CIDR Block: `10.0.0.0/16`

### Public Subnet

* Creates a public subnet.
* Automatically assigns public IPs to EC2 instances using:

```hcl
map_public_ip_on_launch = true
```

### Internet Gateway

* Allows communication between the VPC and the Internet.

### Route Table

* Adds a default route (`0.0.0.0/0`) pointing to the Internet Gateway.

### Security Group

Allows:

* SSH (22)
* HTTP (80)

Allows all outbound traffic.

### EC2 Instance

Creates an Amazon Linux EC2 instance inside the public subnet.

---

## Terraform Commands

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Preview Changes

```bash
terraform plan
```

### Create Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

when prompted.

### View Outputs

```bash
terraform output
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## Variables

Example `terraform.tfvars`

```hcl
aws_region = "ap-south-1"

vpc_cidr = "10.0.0.0/16"

subnet_cidr = "10.0.1.0/24"

instance_type = "t2.micro"

key_name = "your-keypair-name"
```

---

## Security Group Rules

| Type | Port | Source    |
| ---- | ---- | --------- |
| SSH  | 22   | 0.0.0.0/0 |
| HTTP | 80   | 0.0.0.0/0 |

Outbound traffic:

* All traffic allowed

---

## Outputs

After deployment, Terraform displays:

* VPC ID
* Subnet ID
* Security Group ID
* EC2 Instance ID
* Public IP Address

---

## Cleanup

To avoid AWS charges, delete all created resources:

```bash
terraform destroy
```

---

## Technologies Used

* Terraform
* AWS EC2
* AWS VPC
* AWS Security Groups
* AWS Internet Gateway
* AWS Route Tables
* AWS CLI
* Git & GitHub

---

## Author

Created using Terraform for learning and deploying AWS infrastructure as code.
