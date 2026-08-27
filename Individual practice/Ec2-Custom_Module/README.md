# Terraform AWS Custom Modules Project

This project demonstrates modular Terraform architecture for creating an end-to-end AWS infrastructure stack—including a **VPC**, **Subnet**, and an **EC2 Instance**—using reusable custom modules. It is configured to run seamlessly against local AWS emulators like **LocalStack** or standard AWS environments.

---

## 📁 Repository Structure

```text
Ec2-Custom_Module/
├── main.tf                    # Root Terraform configuration combining all custom modules
├── README.md                  # Project documentation
└── modules/
    ├── vpc_module/            # Custom module for creating a VPC
    │   ├── main.tf
    │   ├── variable.tf
    │   └── outputs.tf
    ├── subnet_module/         # Custom module for creating a Subnet within a VPC
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ec2_instance/          # Custom module for launching an EC2 instance
        ├── main.tf
        ├── variables.tf
        └── output.tf
```

---

## 🛠️ Architecture & Custom Modules Overview

### 1. VPC Module (`./modules/vpc_module`)
Creates an AWS VPC network block.
* **Input Variables:** `cidr_block` (Default: `10.0.0.0/16`)
* **Outputs:** `aws_vpc_id` (The generated VPC ID)

### 2. Subnet Module (`./modules/subnet_module`)
Creates an AWS Subnet inside a given VPC.
* **Input Variables:** 
  * `vpc_id` (Required - passed from VPC module output)
  * `subnet_cidr_block` (Default: `10.0.1.0/24`)
  * `availability_zone` (Default: `us-east-1a`)
* **Outputs:** `aws_subnet_id` (The generated Subnet ID)

### 3. EC2 Instance Module (`./modules/ec2_instance`)
Launches an Amazon EC2 instance in a specified subnet.
* **Input Variables:**
  * `ami_value` (AMI ID)
  * `instance_type` (Instance type, e.g., `t2.micro`)
  * `subnet_id` (Subnet ID passed from Subnet module output)

---

## 🚀 How Custom Modules Connect

The root `main.tf` chains outputs from one module into the inputs of another:

```hcl
# 1. Create VPC
module "my_vpc" {
  source     = "./modules/vpc_module"
  cidr_block = "10.0.0.0/16"
}

# 2. Create Subnet inside the created VPC
module "my_subnet" {
  source            = "./modules/subnet_module"
  subnet_cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id            = module.my_vpc.aws_vpc_id
}

# 3. Launch EC2 instance inside the created Subnet
module "this_ec2" {
  source        = "./modules/ec2_instance"
  ami_value     = "ami-024f768332f0"
  instance_type = "t2.micro"
  subnet_id     = module.my_subnet.aws_subnet_id
}
```

---

## 💻 Quick Start & Commands

### Prerequisites
* [Terraform](https://www.terraform.io/downloads) >= 1.0.0
* LocalStack (optional, if running locally without an actual AWS account)

### Usage

1. **Initialize Terraform & Modules:**
   ```bash
   terraform init
   ```

2. **Validate Configuration:**
   ```bash
   terraform validate
   ```

3. **Preview Infrastructure Plan:**
   ```bash
   terraform plan
   ```

4. **Apply Configuration:**
   ```bash
   terraform apply -auto-approve
   ```

5. **Destroy Infrastructure:**
   ```bash
   terraform destroy -auto-approve
   ```
