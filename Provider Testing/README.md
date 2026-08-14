# Provider Testing Suite

This directory contains standalone tests for validating Terraform resource deployment against LocalStack AWS endpoints.

---

## 📁 Subdirectories & Documentation

| Subdirectory | Description | Documentation |
| :--- | :--- | :--- |
| 📁 **`s3/`** | Basic S3 Bucket provisioning (`terraform-dev-playground`) with `force_destroy`. | [s3/README.md](s3/README.md) |
| 📁 **`s3-2/`** | Tagged S3 Bucket provisioning (`my-test-bucket`). | [s3-2/README.md](s3-2/README.md) |
| 📁 **`vpc/`** | VPC (`10.0.0.0/16`) and Subnet (`10.0.1.0/24`) provisioning with outputs. | [vpc/README.md](vpc/README.md) |

---

## 🚀 Quick Start

Navigate to any subfolder and run:
```bash
cd s3      # or cd s3-2 or cd vpc
terraform init
terraform apply -auto-approve
```
