# Terraform AWS & LocalStack Master Learning & Infrastructure Repository

Welcome to the comprehensive **Terraform AWS & LocalStack Infrastructure Repository**. This project serves as a complete hands-on guide and modular codebase demonstrating Terraform core concepts, advanced expressions, built-in functions, variable type constraints, custom validations, resource meta-arguments, lifecycle rules, and LocalStack provider configurations.

---

## 🗺️ Project Architecture & Directory Map

```text
Terraform AWS/
├── 📄 README.md                       # Master Combined Repository Documentation
├── 📁 Expressions/                    # Ternary operators & dynamic ingress blocks
│   ├── 📄 README.md                   # Module-specific documentation
│   ├── 📄 main.tf                     # EC2 conditional instance_type & Dynamic Security Group
│   ├── 📄 variables.tf                # Complex input variables & local values
│   ├── 📄 provider.tf                 # LocalStack AWS Provider configuration
│   └── 📄 terraform.tfvars            # Default variable assignments
├── 📁 Function-1/                     # Basic built-in functions (String, List, Map)
│   ├── 📄 README.md                   # Module-specific documentation
│   ├── 📄 main.tf                     # lower(), merge(), substr(), split(), for loops
│   ├── 📄 variables.tf                # Input variable definitions
│   ├── 📄 output.tf                   # Transformed string & list outputs
│   └── 📄 provider.tf                 # LocalStack AWS Provider configuration
├── 📁 Function-2/                     # Advanced functions, JSON parsing & validations
│   ├── 📄 README.md                   # Module-specific documentation
│   ├── 📄 main.tf                     # concat(), toset(), math functions, jsondecode()
│   ├── 📄 variables.tf                # Custom validation rules & sensitive fields
│   ├── 📄 output.tf                   # Math calculations, JSON map & sensitive outputs
│   ├── 📄 config.json                 # External JSON configuration sample
│   └── 📄 provider.tf                 # LocalStack AWS Provider configuration
├── 📁 Meta-Arguments/                 # Resource loops & dependency control
│   ├── 📄 README.md                   # Module-specific documentation
│   ├── 📄 main.tf                     # count, for_each, count.index, each.value, depends_on
│   ├── 📄 variables.tf                # List and set bucket definitions
│   ├── 📄 provider.tf                 # LocalStack AWS Provider configuration
│   └── 📄 terraform.tfvars            # Variable value overrides
├── 📁 Provider Testing/               # Standalone LocalStack AWS service testing
│   ├── 📄 README.md                   # Parent test suite documentation
│   ├── 📁 s3/                         # S3 Bucket testing with force_destroy
│   │   ├── 📄 README.md               # S3 test module documentation
│   │   └── 📄 s3.tf                   # Single-file S3 & provider definition
│   ├── 📁 s3-2/                       # S3 Bucket testing with custom tags
│   │   ├── 📄 README.md               # S3-2 test module documentation
│   │   └── 📄 provider.tf             # Provider & tagged S3 resource definition
│   └── 📁 vpc/                        # VPC & Subnet network testing
│       ├── 📄 README.md               # Network test module documentation
│       └── 📄 provider.tf             # Provider, VPC, Subnet & output definitions
├── 📁 Type Constraints/               # Primitive, Collection & Structural Types
│   ├── 📄 README.md                   # Module-specific documentation
│   ├── 📄 main.tf                     # Consuming lists, sets, maps, tuples, objects
│   ├── 📄 variables.tf                # Primitive, collection & structural variable types
│   ├── 📄 provider.tf                 # LocalStack AWS Provider configuration
│   └── 📄 terraform.tfvars            # Input variable values
├── 📁 life_cycle/                     # Resource Lifecycle management
│   ├── 📄 README.md                   # Module-specific documentation
│   ├── 📄 main.tf                     # create_before_destroy & lifecycle meta-arguments
│   ├── 📄 variables.tf                # Configuration inputs
│   └── 📄 provider.tf                 # LocalStack AWS Provider configuration
├── 📁 s3/                             # S3 playground
│   ├── 📄 README.md                   # Module-specific documentation
│   └── 📄 s3.tf                       # LocalStack S3 bucket definition
├── 📁 variables/                      # Parameterized AWS infrastructure
│   ├── 📄 README.md                   # Module-specific documentation
│   ├── 📄 main.tf                     # S3, VPC, Subnet & EC2 instance setup
│   ├── 📄 variables.tf                # Environment variable & output declarations
│   └── 📄 provider.tf                 # LocalStack AWS Provider configuration
└── 📁 vpc_subnet_s3_ec2/              # Integrated Cloud Stack
    ├── 📄 README.md                   # Module-specific documentation
    ├── 📄 main.tf                     # Full network, compute & storage architecture
    ├── 📄 variables.tf                # Variables & outputs
    └── 📄 provider.tf                 # LocalStack AWS Provider configuration
```

---

## 📚 Comprehensive Module & File Breakdown

### 1️⃣ Expressions (`Expressions/`)
- **Focus**: Dynamic configuration and conditional resource sizing.
- **Key Files**:
  - `main.tf`: Provisions `aws_instance` using ternary expressions (`var.environment == "dev" ? "t2.micro" : "t2.small"`) and `aws_security_group` using `dynamic "ingress"` blocks over `var.ingress_rules`.
  - `variables.tf`: Defines list, set, map, and object variables (`ingress_rules`, `config`, `allowed_region`, `tags`).
  - `provider.tf`: Configured for LocalStack (`http://localhost:4566`).
  - `terraform.tfvars`: Sets runtime values (`instance_count = 1`, `monitering_enable = true`).
  - 📖 **[Read Module Documentation](Expressions/README.md)**

---

### 2️⃣ Built-in Functions - Part 1 (`Function-1/`)
- **Focus**: String formatting, list manipulation, and map merging.
- **Key Files**:
  - `main.tf`: Uses `lower()`, `merge()`, `substr()`, `replace()`, `split()`, and `for` expressions to construct valid S3 bucket names and security group rules.
  - `variables.tf`: Raw project names, tag maps, and comma-separated port strings (`"80,443,3000"`).
  - `output.tf`: Exports `formatted_project_name`, `bucket_name`, `ports_list`, and `sg_rules`.
  - `provider.tf`: LocalStack AWS provider config.
  - 📖 **[Read Module Documentation](Function-1/README.md)**

---

### 3️⃣ Advanced Functions & Validations - Part 2 (`Function-2/`)
- **Focus**: Collections, math, JSON reading, custom validation rules, and sensitive data.
- **Key Files**:
  - `main.tf`: Demonstrates `concat()`, `toset()`, `abs()`, `max()`, `min()`, `sum()`, `length()`, `fileexists()`, and `try(jsondecode(file(...)))`.
  - `variables.tf`: Custom `validation {}` blocks for `instance_type` (regex constraint `^t[2-3]\.`) and `backup_name` (`endswith`), plus `sensitive = true` for credentials.
  - `config.json`: External sample JSON payload.
  - `output.tf`: Displays calculated math values, parsed JSON structure, and sensitive credentials.
  - `provider.tf`: LocalStack AWS provider config.
  - 📖 **[Read Module Documentation](Function-2/README.md)**

---

### 4️⃣ Meta-Arguments (`Meta-Arguments/`)
- **Focus**: Iteration and dependency tracking across resources.
- **Key Files**:
  - `main.tf`: Demonstrates `count = length(var.s3_buckets)` with `count.index`, `for_each = var.s3_buckets_set` with `each.value`, and explicit `depends_on = [aws_s3_bucket.bucket1]`.
  - `variables.tf`: Input lists and sets for bucket creation.
  - `provider.tf`: LocalStack AWS provider config.
  - 📖 **[Read Module Documentation](Meta-Arguments/README.md)**

---

### 5️⃣ Provider Testing Suite (`Provider Testing/`)
- **Focus**: Dedicated testing of individual LocalStack AWS services.
- **Sub-modules**:
  - `s3/s3.tf`: S3 bucket with `force_destroy = true`. 📖 **[Documentation](Provider%20Testing/s3/README.md)**
  - `s3-2/provider.tf`: S3 bucket with custom tags. 📖 **[Documentation](Provider%20Testing/s3-2/README.md)**
  - `vpc/provider.tf`: VPC (`10.0.0.0/16`) and Subnet (`10.0.1.0/24`) provisioning with outputs. 📖 **[Documentation](Provider%20Testing/vpc/README.md)**
  - 📖 **[Read Suite Documentation](Provider%20Testing/README.md)**

---

### 6️⃣ Type Constraints (`Type Constraints/`)
- **Focus**: Comprehensive verification of Terraform data types.
- **Key Files**:
  - `main.tf`: Uses index lookups on primitive (`string`, `number`, `bool`), collection (`list`, `set`, `map`), and structural (`tuple`, `object`) variables.
  - `variables.tf`: Declarations of `tuple([ number, string, number ])`, `object({ instance_type = string, count = number })`, etc.
  - `provider.tf`: LocalStack AWS provider config.
  - 📖 **[Read Module Documentation](Type%20Constraints/README.md)**

---

### 7️⃣ Resource Lifecycle (`life_cycle/`)
- **Focus**: Controlling resource behavior during replacement and updates.
- **Key Files**:
  - `main.tf`: Demonstrates `lifecycle { create_before_destroy = true }` and resource replacement behaviors.
  - `variables.tf`: Network and instance inputs.
  - `provider.tf`: LocalStack AWS provider config.
  - 📖 **[Read Module Documentation](life_cycle/README.md)**

---

### 8️⃣ S3 Playground (`s3/`)
- **Focus**: Minimalist single-file S3 infrastructure test.
- **Key Files**:
  - `s3.tf`: LocalStack provider block and bucket declaration `terraform-dev-playground`.
  - 📖 **[Read Module Documentation](s3/README.md)**

---

### 9️⃣ Environment Variables (`variables/`)
- **Focus**: Parameterized resource tagging and resource association.
- **Key Files**:
  - `main.tf`: S3 bucket, VPC, Subnet, and EC2 instance with dynamic environment name tags.
  - `variables.tf`: Variable `environment` and outputs `vpc_id`, `ec2_ip`.
  - `provider.tf`: LocalStack endpoint configuration.
  - 📖 **[Read Module Documentation](variables/README.md)**

---

### 🔟 Integrated Cloud Stack (`vpc_subnet_s3_ec2/`)
- **Focus**: End-to-end multi-resource infrastructure deployment.
- **Key Files**:
  - `main.tf`: Complete architecture combining VPC (`10.0.0.0/24`), Subnet (`10.0.0.0/26`), S3 Bucket (`my-test-bucket`), and EC2 Instance (`ami-024f768332f0`).
  - `variables.tf`: Input variables and output exports.
  - `provider.tf`: LocalStack provider config.
  - 📖 **[Read Module Documentation](vpc_subnet_s3_ec2/README.md)**

---

## 🛠️ Prerequisites & LocalStack Setup

All modules in this repository are configured to run locally using **LocalStack**, avoiding cloud billing costs.

### Requirements:
- [Terraform](https://www.terraform.io/downloads) (v1.0.0+)
- [LocalStack](https://localstack.cloud/) (or Docker running `localstack/localstack`)

### Start LocalStack:
```bash
# Using Docker
docker run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack
```

---

## 🚀 Execution Workflow

To test any module in this repository:

1. **Navigate to the target module directory:**
   ```bash
   cd Expressions      # Or any other module directory
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Validate and preview resources:**
   ```bash
   terraform plan
   ```

4. **Apply configuration:**
   ```bash
   terraform apply -auto-approve
   ```

5. **Clean up resources:**
   ```bash
   terraform destroy -auto-approve
   ```

---

## 📋 Summary Table of Individual README Files

| Module Directory | README Link | Target Topics |
| :--- | :--- | :--- |
| `Expressions/` | [Expressions/README.md](Expressions/README.md) | Dynamic ingress blocks & ternary operators |
| `Function-1/` | [Function-1/README.md](Function-1/README.md) | Built-in string, list & tag functions |
| `Function-2/` | [Function-2/README.md](Function-2/README.md) | Math, collections, JSON parsing & custom validation |
| `Meta-Arguments/` | [Meta-Arguments/README.md](Meta-Arguments/README.md) | `count`, `for_each`, `depends_on` |
| `Provider Testing/` | [Provider Testing/README.md](Provider%20Testing/README.md) | LocalStack service test suite parent documentation |
| `Provider Testing/s3/` | [Provider Testing/s3/README.md](Provider%20Testing/s3/README.md) | S3 test with `force_destroy` |
| `Provider Testing/s3-2/` | [Provider Testing/s3-2/README.md](Provider%20Testing/s3-2/README.md) | S3 test with environment tags |
| `Provider Testing/vpc/` | [Provider Testing/vpc/README.md](Provider%20Testing/vpc/README.md) | VPC & Subnet creation with outputs |
| `Type Constraints/` | [Type Constraints/README.md](Type%20Constraints/README.md) | Primitive, collection & structural data types |
| `life_cycle/` | [life_cycle/README.md](life_cycle/README.md) | Lifecycle meta-arguments & resource rules |
| `s3/` | [s3/README.md](s3/README.md) | Standalone S3 bucket creation |
| `variables/` | [variables/README.md](variables/README.md) | Parameterized VPC, S3 & EC2 instances |
| `vpc_subnet_s3_ec2/` | [vpc_subnet_s3_ec2/README.md](vpc_subnet_s3_ec2/README.md) | Combined full stack architecture |
