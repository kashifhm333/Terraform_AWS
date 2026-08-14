# Terraform Expressions Module

This module demonstrates advanced Terraform expressions including ternary conditional operators, dynamic blocks (`dynamic "ingress"`), local values, complex variable types, and LocalStack integration for AWS EC2 & Security Group provisioning.

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Contains resource definitions demonstrating Terraform expressions:
- **`aws_instance` (`exmaple`)**: Provisions EC2 instances using LocalStack AMI (`ami-024f768332f0`). Uses conditional expression `instance_type = var.environment == "dev" ? "t2.micro" : "t2.small"` and `count = var.instance_count`.
- **`aws_security_group` (`ingres`)**: Creates a security group using a `dynamic "ingress"` block that iterates over `var.ingress_rules` to dynamically construct ingress rules (`from_port`, `to_port`, `cidr_blocks`, `protocol`).

### 📄 `variables.tf`
Defines all input variables and local expressions for the module:
- **`environment`**: String variable (`dev` by default).
- **`instance_count`**: Number of instances to provision.
- **`monitering_enable` & `associate_public_ip_address`**: Boolean flags for instance options.
- **`cidr_block`**: List of VPC CIDR strings.
- **`allowed_region`**: Set of region names.
- **`tags`**: Map of resource tags.
- **`config`**: Object type containing `instance_type` and `count`.
- **`s3_buckets` & `s3_buckets_set`**: List and set of S3 bucket names.
- **`ingress_rules`**: List of objects defining ingress security group rules (ports 80, 443, protocol, CIDRs, descriptions).
- **`locals` (`env`)**: Local variable alias for `var.environment`.

### 📄 `provider.tf`
Configures the AWS Terraform provider for local testing:
- Provider version constraint (`~> 5.0`) and Terraform version requirement (`>= 1.0.0`).
- LocalStack endpoint mapping (`http://localhost:4566`) for S3, EC2, and IAM services.
- Test credentials (`access_key = "test"`, `secret_key = "test"`) with path-style S3 routing enabled.

### 📄 `terraform.tfvars`
Provides default variable values when running `terraform apply`:
```hcl
instance_count              = 1
monitering_enable           = true
associate_public_ip_address = true
```

---

## 🚀 How to Run

1. Ensure **LocalStack** is running on `http://localhost:4566`.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Preview execution plan:
   ```bash
   terraform plan
   ```
4. Apply configurations:
   ```bash
   terraform apply -auto-approve
   ```
