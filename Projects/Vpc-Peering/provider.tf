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
  region                      = var.primary_region
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true # Required for LocalStack S3 routing
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
    alias = "primary"
  endpoints {
    s3 = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    
  }
}



provider "aws" {
    region                      = var.secondary_region
    access_key                  = "test"
    secret_key                  = "test"
    s3_use_path_style           = true # Required for LocalStack S3 routing
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    alias = "secondary"
  endpoints {
    s3 = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    
  }
}
