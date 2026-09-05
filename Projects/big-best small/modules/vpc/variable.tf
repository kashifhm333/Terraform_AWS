variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_tags" {
    type = map(string)
    default = {
      "name" = "my_vpc"
    }
}



variable "subnets_cidr_block" {
type = list(string)
default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]

}