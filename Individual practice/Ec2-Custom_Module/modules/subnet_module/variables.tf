variable "subnet_cidr_block" {
  description = "cidr block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "availability zone for subnet"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_id" {
  description = "VPC ID for the subnet"
  type        = string
}