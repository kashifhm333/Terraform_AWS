resource "aws_vpc" "primary_vpc" {
  provider = aws.primary
  cidr_block = var.primary_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = var.tags
}

resource "aws_vpc" "secondary_vpc" {
  provider = aws.secondary
  cidr_block = var.secondary_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = var.tags
}


resource "aws_subnet" "primary_vpc_subnet" {
  vpc_id = aws_vpc.primary_vpc.id
  provider = aws.primary
  cidr_block = var.primary_vpc_subnet_cidr
}


resource "aws_subnet" "secondary_vpc_subnet" {
  vpc_id = aws_vpc.secondary_vpc.id
  provider = aws.secondary
  cidr_block = var.secondary_vpc_subnet_cidr
}

