# Terraform Advanced Functions & Validations Module (Part 2)

This module demonstrates advanced Terraform functions including collection functions (`concat`, `toset`), math functions (`abs`, `max`, `min`, `sum`), file handling (`fileexists`, `jsondecode`, `file`, `try`), custom variable validation rules, and sensitive output handling.

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Implements advanced functions inside local values and resource definitions:
- **String & Tag Operations**: `lower`, `substr`, `replace`, `merge`, `split`.
- **Collection Functions**:
  - `concat(var.user_locations, var.default_locations)`: Combines location lists.
  - `toset(local.all_locations)`: Removes duplicates from location list.
- **Math Functions**:
  - `[for cost in var.monthly_cost : abs(cost)]`: Converts costs to positive numbers.
  - `max(local.positive_cost...)`, `min(...)`, `sum(...)`, average calculated with `length()`.
- **File & JSON Parsing**:
  - `fileexists("./config.json")`: Checks if JSON config file exists.
  - `try(jsondecode(file("${path.module}/config.json")), {})`: Safely reads and parses `config.json`.
- **`aws_s3_bucket` (`mybucket`)**: Provisions bucket with transformed name and merged tags.

### 📄 `variables.tf`
Defines input variables including custom variable validations:
- **`instance_type`**: Validated using `length()` constraint and `regex("^t[2-3]\\.", var.instance_type)` to enforce `t2` or `t3` instances.
- **`backup_name`**: Validated using `endswith(var.backup_name, "_backup")`.
- **`credentials`**: Marked with `sensitive = true` to prevent logging plain-text secrets.
- **`user_locations` & `default_locations`**: String lists for region testing.
- **`monthly_cost`**: List of numerical values (positive and negative) for math function tests.

### 📄 `config.json`
External JSON data file containing user profile, skills, and project data parsed into Terraform locals.

### 📄 `output.tf`
Exposes outputs for math, collections, parsed JSON, and sensitive variables:
- **`crediantls`**: Sensitive output returning credentials variable.
- **`locations` & `set_locations`**: Raw list vs deduplicated set.
- **`positive_cost`, `max_cost`, `min_cost`, `total_cost`, `average_cost`**: Math operation results.
- **`json_file`**: Complete parsed JSON map structure from `config.json`.

### 📄 `provider.tf`
AWS Provider configuration pointing to LocalStack (`http://localhost:4566`).

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
