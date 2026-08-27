variable "ami_value" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-024f768332f0"

}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The subnet ID for the EC2 instance"
  type        = string
  default     = null
} 