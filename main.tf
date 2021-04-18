terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

# Create a VPC
resource "aws_vpc" "GameNowVpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "GameNowVPC"
  }
}