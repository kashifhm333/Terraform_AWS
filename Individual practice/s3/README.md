# Terraform S3 Playground Module

This standalone module provisions an S3 bucket in LocalStack for development testing.

---

## 📁 File Structure & Individual File Documentation

### 📄 `s3.tf`
Single self-contained Terraform file:
- **`terraform` Block**: Specifies Terraform version (`>= 1.0.0`) and `hashicorp/aws` provider constraint (`~> 5.0`).
- **`provider "aws"`**: Configured for LocalStack (`http://localhost:4566`) in `us-east-1` with `s3_use_path_style = true`.
- **`aws_s3_bucket` (`my_bucket`)**: Creates S3 bucket `terraform-dev-playground` with `force_destroy = true` to allow destroying non-empty buckets during testing.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
