variable "environment" {
  default = "dev"
  type = string

}

locals {
  env = var.environment
}

output "vpc_id" {
    value = aws_vpc.Myvpc.id

}

output "ec2_ip" {
  value = aws_instance.instance.id
}