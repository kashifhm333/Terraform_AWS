# Terraform Built-in Functions Module (Part 1)

This module demonstrates Terraform built-in functions for string manipulation, list transformations, tag merging, and output formatting.

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Contains local logic and resource creation using built-in functions:
- **`locals`**:
  - `lower(var.project_name)`: Converts project name to lowercase.
  - `merge(var.default_tags, var.enviroment_tags)`: Combines tag maps into `new_tags`.
  - `lower(substr(replace(var.bucket_name, " ", "-"), 0, 63))`: Replaces spaces with hyphens, extracts up to 63 chars, and converts to lowercase to form valid S3 bucket names.
  - `split(",", var.ports)`: Converts a comma-separated string of ports into a list.
  - `[for port in local.ports_list : { name = "port-${port}", port = port }]`: Uses a `for` loop to build a list of security group rule objects.
- **`aws_s3_bucket` (`mybucket`)**: Creates S3 bucket with processed `bucket_name` and merged `new_tags`.

### 📄 `variables.tf`
Defines inputs for testing string and map functions:
- **`project_name`**: String variable (default: `"web based project"`).
- **`default_tags`**: Map of default tags (default: `{ name = "MyProject" }`).
- **`enviroment_tags`**: Map of environment tags (default: `{ env = "dev" }`).
- **`bucket_name`**: Raw string bucket name with mixed casing and spaces.
- **`ports`**: Comma-separated string of port numbers (default: `"80,443,3000"`).

### 📄 `output.tf`
Exposes evaluated function results as Terraform outputs:
- **`formatted_project_name`**: Transformed project name formatted for resource identifiers.
- **`bucket_name`**: Final formatted S3 bucket name.
- **`ports_list`**: Second element of split port list (`local.ports_list[1]`).
- **`sg_rules`**: Array of generated security group rule objects.

### 📄 `provider.tf`
AWS Provider configured for LocalStack (`http://localhost:4566`) with path-style S3 routing and dummy credentials.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
