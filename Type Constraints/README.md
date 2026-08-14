# Terraform Type Constraints Module

This module demonstrates Terraform data type constraints including primitive types (`string`, `number`, `bool`) and complex collection/structural types (`list`, `set`, `map`, `tuple`, `object`).

---

## 📁 File Structure & Individual File Documentation

### 📄 `main.tf`
Demonstrates indexing and consuming structured data types in AWS resources:
- **`aws_vpc` (`Myvpc`)**: VPC with `10.0.0.0/24` CIDR.
- **`aws_subnet` (`MySubnet`)**: Subnet created in `aws_vpc.Myvpc.id`.
- **`aws_instance` (`instance`)**: Accesses object type variables `instance_type = var.config.instance_type` and `count = var.config.count`.
- **`aws_security_group` (`allow_tls`)**: Creates TLS security group.
- **`aws_vpc_security_group_ingress_rule` (`allow_tls_ipv4`)**: Accesses list and tuple variables using index lookup:
  - `cidr_ipv4 = var.cidr_block[0]` (list index 0: `"10.0.0.0/8"`)
  - `from_port = var.ingress_rules[0]` (tuple index 0: `433`)
  - `ip_protocol = var.ingress_rules[1]` (tuple index 1: `"tcp"`)
  - `to_port = var.ingress_rules[2]` (tuple index 2: `433`)
- **`aws_vpc_security_group_egress_rule` (`allow_all_traffic_ipv4`)**: Allows all outbound IPv4 traffic.

### 📄 `variables.tf`
Defines comprehensive type constraints:
- **Primitive Types**:
  - `environment` (`string`)
  - `instance_count` (`number`)
  - `monitering_enable` & `associate_public_ip_address` (`bool`)
- **Collection Types**:
  - `cidr_block` (`list(string)`): `["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]`
  - `allowed_region` (`set(string)`): Set of unique AWS regions.
  - `tags` (`map(string)`): Key-value pair map.
- **Structural Types**:
  - `ingress_rules` (`tuple([ number, string, number ])`): Fixed-length tuple `[ 433, "tcp", 433 ]`.
  - `config` (`object({ instance_type = string, count = number })`): Schema object.
- **Outputs**: `vpc_id`.

### 📄 `provider.tf`
AWS Provider setup targeting LocalStack (`http://localhost:4566`).

### 📄 `terraform.tfvars`
Sample runtime variable assignments.

---

## 🚀 How to Run

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
