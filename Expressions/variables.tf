variable "environment" {
  default = "dev"
  type = string

}

locals {
  env = var.environment
}

# output "vpc_id" {
#     value = aws_vpc.Myvpc.id

# }

# output "ec2_ip" {
#   value = aws_instance.instance.id
# }
variable "instance_count" {
  description = "Instance Count"
  type = number
}

variable "monitering_enable" {
  description = "Enabling Monitering"
  type = bool
}

variable "associate_public_ip_address" {
  description = "Associate Public IP Address"
  type = bool
}

variable "cidr_block" {
  description = "CIDR Block for VPC"
  type  = list(string)
  default = [ "10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16" ]
  
}


variable "allowed_region" {
  description = "Allowed Regions"
  type = set(string)
  default = [ "us-east-2", "us-east-1", "us-west-1", "us-west-2", "us-east-2"]
  }

  variable "tags" {
    description = "Tags for resources"
    type = map(string)
    default = {
      Environment = "dev"
      Project     = "MyProject"
    }
    
  }

# variable "ingress_rules" {
#   type = tuple([ number, string, number ])
#   default = [ 433, "tcp", 433 ]
  
# }

variable "config" {
  type = object({
    instance_type = string
    count         = number
  })
  default = {
    instance_type = "t2.micro"
    count = 1
  }
  
}

variable "s3_buckets" {
  description = "List of S3 bucket names"
  type        = list(string)
  default     = ["mybucket1", "mybucket2"]

}

variable "s3_buckets_set" {
  description = "set of S3 bucket names"
  type        = set(string)
  default     = ["mybucket01", "mybucket02"]

}

variable "ingress_rules" {
 description = "list of ingress rules for security group"
 type = list(object({
   from_port = number
   protocol = string
   to_port = number
   cidr_blocks = list(string)
   description = string
 })) 
 default = [ {
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks = [ "0.0.0.0/0" ]
   description = "HTTP access"
 },
 {
  from_port = 443
   to_port = 443
   protocol = "tcp"
   cidr_blocks = [ "0.0.0.0/0" ]
   description = "HTTPS access"
 }]

}