# Terraform Lifecycle Meta-Arguments Module

This module demonstrates Terraform resource lifecycle lifecycle control blocks, such as `create_before_destroy`, `prevent_destroy`, and `ignore_changes`.

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Contains resource configurations with lifecycle rules:
- **`aws_vpc` (`myvpc`)**: Provisions a VPC using indexed CIDR block `var.cidr_block[2]` (`"192.168.0.0/16"`).
- **`aws_s3_bucket` (`mybucket`)**: Demonstrates `lifecycle` rules (e.g. `create_before_destroy = true`) ensuring replacement resources are provisioned before existing ones are destroyed during updates.
- **`aws_instance` (`instance`)** *(commented reference)*: Highlights resource dependencies (`depends_on = [aws_vpc.myvpc]`) combined with lifecycle modification flags.

### 📄 `variables.tf`
Defines variables for infrastructure configuration:
- `environment`, `instance_count`, `monitering_enable`, `associate_public_ip_address`.
- `cidr_block` list (`["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]`).
- `allowed_region`, `tags`, `ingress_rules`, `config` object.

### 📄 `provider.tf`
AWS Provider configuration pointed at LocalStack (`http://localhost:4566`).

### 📄 `terraform.tfvars`
Sample variable input definitions.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
