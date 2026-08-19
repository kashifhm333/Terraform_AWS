# LocalStack VPC & Subnet Provider Testing

This module tests AWS VPC and Subnet creation against LocalStack's EC2 service endpoint.

---

## 📁 File Structure & Individual File Documentation

### 📄 `provider.tf`
Contains provider setup, network resource definitions, and outputs:
- **`provider "aws"`**: Configured with EC2 endpoint `http://localhost:4566` in `us-east-1`.
- **`aws_vpc` (`main`)**: Provisions VPC with CIDR block `10.0.0.0/16`.
- **`aws_subnet` (`main`)**: Provisions Subnet with CIDR block `10.0.1.0/24` within `aws_vpc.main.id`.
- **Outputs**:
  - `vpc_id`: Generated VPC ID.
  - `subnet_id`: Generated Subnet ID.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
