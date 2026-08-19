# =====================================================================
# 1. INPUT VARIABLES (Demonstrating Literal Expressions)
# =====================================================================
variable "environment" {
  type    = string
  default = "dev" # Literal string
}

variable "project_name" {
  type    = string
  default = "alpha" # Literal string
}

variable "base_instances" {
  type    = number
  default = 2 # Literal number
}

variable "enable_ha" {
  type    = bool
  default = true # Literal boolean
}

variable "tier_names" {
  type    = list(string)
  default = ["frontend", "backend", "cache"] # Literal list
}

variable "service_metadata" {
  type = map(string)
  default = {
    owner      = "devops-team"
    cost_center= "ignore-me"
  } # Literal map
}

# =====================================================================
# 2. EXPRESSIONS DEMONSTRATION (Locals Block)
# =====================================================================
locals {
  # --- Reference Expression ---
  active_env = var.environment

  # --- Arithmetic & Logical Expressions ---
  scaled_instances = var.base_instances * 2
  is_production_ha = var.environment == "prod" && var.enable_ha == true

  # --- Conditional (Ternary) Expression ---
  instance_flavor = var.environment == "prod" ? "t3.large" : "t3.micro"

  # --- String Interpolation Expression ---
  bucket_prefix = "${var.project_name}-${local.active_env}-assets"

  # --- For Expression (List Comprehension) ---
  # Transforms list elements to uppercase
  uppercase_tiers = [for tier in var.tier_names : upper(tier)]

  # --- For Expression (Map Comprehension) ---
  # Filters out key-value pairs where the value equals "ignore-me"
  filtered_metadata = { 
    for k, v in var.service_metadata : k => v if v != "ignore-me" 
  }
}

# =====================================================================
# 3. INFRASTRUCTURE & RESOURCE EXPRESSIONS
# =====================================================================
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    # Reference and String Interpolation used inside tags
    Name = "${var.project_name}-${local.active_env}-vpc"
  }
}

resource "aws_subnet" "public" {
  # Arithmetic and Reference Expression used inside count
  count = local.calculated_instance_count_fallback ? 2 : local.scaled_instances

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = local.is_production_ha

  tags = {
    # String Interpolation & Index Reference
    Name = "${var.project_name}-subnet-${count.index + 1}"
  }
}

# Local helper boolean for the ternary demo above
locals {
  calculated_instance_count_fallback = false
}

# =====================================================================
# 4. OUTPUTS (Demonstrating Splat Expressions)
# =====================================================================
output "subnet_ids_via_splat" {
  description = "Extracts all subnet IDs using the splat operator"
  # --- Splat Expression ([*]) ---
  value       = aws_subnet.public[*].id
}

output "evaluated_expression_summary" {
  description = "Summarizes computed results from all local expressions"
  value = {
    computed_flavor   = local.instance_flavor
    generated_name    = local.bucket_prefix
    transformed_tiers = local.uppercase_tiers
    cleaned_metadata  = local.filtered_metadata
  }
}