# LocalStack S3 Provider Testing

This module tests S3 bucket provision against LocalStack using path-style S3 routing.

---

## 📁 File Structure & Individual File Documentation

### 📄 `s3.tf`
Contains provider configuration and resource definition in a single file:
- **`provider "aws"`**: Points S3 endpoint to LocalStack (`http://localhost:4566`), enables `s3_use_path_style = true`, and sets region `us-east-1`.
- **`aws_s3_bucket` (`my_bucket`)**: Creates S3 bucket `terraform-dev-playground` with `force_destroy = true` for easy cleanup.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
