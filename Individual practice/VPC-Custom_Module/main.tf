terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true # Required for LocalStack S3 routing
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    
  }
}

# Instantiate the custom module
module "dev_vpc" {
  source      = "./modules/simple-vpc"
  vpc_cidr    = "10.10.0.0/16"
  subnet_cidr = "10.10.1.0/24"
  env_name    = "dev"
}

# Example: Deploy an EC2 instance into the module's subnet using module outputs
resource "aws_instance" "web_server" {
  ami           = "ami-024f768332f0" 
  instance_type = "t2.micro"
  subnet_id     = module.dev_vpc.public_subnet_id

  tags = {
    Name = "dev-web-server"
  }
}