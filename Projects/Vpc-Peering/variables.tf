variable "primary_vpc_name" {
  type = string
  default = "primary-vpc"
}

variable "secondary_vpc_name" {
  type = string
  default = "secondary-vpc"
}


variable "primary_region" {
  type = string
  default = "us-east-1"

}

variable "secondary_region" {
  type = string
  default = "us-west-2"
}


variable "primary_vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "secondary_vpc_cidr" {
  type = string
  default = "10.1.0.0/16"
}

variable "tags" {
  type = object({
        Name = string
        Env = string
    })
    default = {
        Name = "Vpc"
        Env = "dev"
    }
    }


variable "primary_vpc_subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
  
}

variable "secondary_vpc_subnet_cidr" {
  type = string
  default = "10.1.1.0/24"
  
}