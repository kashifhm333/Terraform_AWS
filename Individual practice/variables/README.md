# Terraform Input & Output Variables Module

This module demonstrates parameterizing infrastructure components using environment variables, local values, string interpolation, and output exports.

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Provisions resources parameterized by `var.environment`:
- **`aws_s3_bucket` (`my_bucket`)**: Bucket named `"my-test-bucket"` with dynamic tags (`"${var.environment}-bucket"`).
- **`aws_vpc` (`Myvpc`)**: VPC with `10.0.0.0/24` CIDR and name `"dev-VPC"`.
- **`aws_subnet` (`MySubnet`)**: Subnet with `10.0.0.0/26` CIDR inside `aws_vpc.Myvpc`.
- **`aws_instance` (`instance`)**: EC2 instance (`ami-024f768332f0`, `t2.micro`) attached to `aws_subnet.MySubnet.id`.

### 📄 `variables.tf`
Defines variables, locals, and outputs:
- **`environment`**: String input variable (default: `"dev"`).
- **`locals` (`env`)**: Local reference to environment variable.
- **Outputs**:
  - `vpc_id`: Exported VPC resource ID (`aws_vpc.Myvpc.id`).
  - `ec2_ip`: Exported EC2 instance ID (`aws_instance.instance.id`).

### 📄 `provider.tf`
AWS Provider setup targeting LocalStack (`http://localhost:4566`) for S3, EC2, and IAM endpoints.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
