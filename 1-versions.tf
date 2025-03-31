# terraform settings block 
terraform {
  # Terraform Version
  required_version = "~> 1.9.4" #constraints
  
  
  # Required terraform providers
  required_providers {
    aws = {
        version = "~> 5.91.0"
        source = "hashicorp/aws"
    }
  }

  # Backend 
  backend "s3" {
    bucket = "i27academy-tf-devopsb5"
    region = "us-east-1"
    key = "dev/terraform.tfstate"
  }
}