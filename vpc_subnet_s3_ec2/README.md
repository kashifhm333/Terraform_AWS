# Terraform VPC, Subnet, S3 & EC2 Module

This module demonstrates provisioning an end-to-end cloud infrastructure stack combining network components (VPC, Subnet), storage (S3 Bucket), and compute resources (EC2 Instance) in LocalStack.

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Defines full infrastructure resource architecture:
- **`aws_s3_bucket` (`my_bucket`)**: S3 bucket tagged with environment name (`"${var.environment}-bucket"`).
- **`aws_vpc` (`Myvpc`)**: Custom VPC with `10.0.0.0/24` CIDR block.
- **`aws_subnet` (`MySubnet`)**: Subnet with `10.0.0.0/26` CIDR block bound to `aws_vpc.Myvpc.id`.
- **`aws_instance` (`instance`)**: EC2 instance (`t2.micro`, LocalStack Linux AMI `ami-024f768332f0`) launched into `aws_subnet.MySubnet.id`.

### 📄 `variables.tf`
Defines inputs, locals, and outputs for the module:
- **`environment`**: String input variable (`"dev"` default).
- **`locals` (`env`)**: Local alias for `var.environment`.
- **Outputs**:
  - `vpc_id`: Returns created VPC ID (`aws_vpc.Myvpc.id`).
  - `ec2_ip`: Returns created EC2 instance ID (`aws_instance.instance.id`).

### 📄 `provider.tf`
AWS Provider configuration specifying LocalStack endpoints (`http://localhost:4566`) for S3, EC2, and IAM services.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
