# LocalStack S3-2 Provider Testing

This module tests secondary S3 bucket provisioning configurations with tagged resources in LocalStack.

---

## 📁 File Structure & Individual File Documentation

### 📄 `provider.tf`
Contains provider configuration and S3 resource definition:
- **`provider "aws"`**: Configured for LocalStack endpoint (`http://localhost:4566`) in `us-east-1`.
- **`aws_s3_bucket` (`name`)**: Provisions S3 bucket `my-test-bucket` tagged with `environment = "test"`.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
