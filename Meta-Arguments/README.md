# Terraform Meta-Arguments Module

This module demonstrates the usage of core Terraform meta-arguments: `count`, `for_each`, `count.index`, `each.value`, and explicit dependencies with `depends_on`.

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Demonstrates meta-arguments in resource creation:
- **`aws_s3_bucket` (`bucket1`)**: Uses **`count`** meta-argument (`count = length(var.s3_buckets)`) to dynamically instantiate multiple S3 buckets using index lookup `var.s3_buckets[count.index]`.
- **`aws_s3_bucket` (`set_bucket`)**: Uses **`for_each`** meta-argument (`for_each = var.s3_buckets_set`) iterating over a set of bucket names with `bucket = each.value`.
- **`depends_on`**: Explicitly requires `aws_s3_bucket.bucket1` to be created before `aws_s3_bucket.set_bucket` starts provisioning.

### 📄 `variables.tf`
Defines input lists, sets, and resource configurations:
- **`s3_buckets`**: List of string bucket names (`["mybucket1", "mybucket2"]`) used with `count`.
- **`s3_buckets_set`**: Set of string bucket names (`["mybucket01", "mybucket02"]`) used with `for_each`.
- **`tags`**: Default resource tagging map (`Environment = "dev"`, `Project = "MyProject"`).
- Other auxiliary variables for environment setup.

### 📄 `provider.tf`
AWS Provider configuration pointed at LocalStack (`http://localhost:4566`).

### 📄 `terraform.tfvars`
Sample variable values for module execution:
```hcl
instance_count              = 1
monitering_enable           = true
associate_public_ip_address = true
```

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
