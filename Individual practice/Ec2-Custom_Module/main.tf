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
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"

  }
}


module "my_vpc" {
  source     = "./modules/vpc_module"
  cidr_block = "10.0.0.0/16"
}


module "my_subnet" {
  source            = "./modules/subnet_module"
  subnet_cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id            = module.my_vpc.aws_vpc_id
}

module "this_ec2" {
  source        = "./modules/ec2_instance"
  ami_value     = "ami-024f768332f0"
  instance_type = "t2.micro"
  subnet_id     = module.my_subnet.aws_subnet_id
}