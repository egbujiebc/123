terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "gitvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "gitvpc"
  }
}

resource "aws_subnet" "pubsubnetgit" {
  vpc_id     = aws_vpc.gitvpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "pubsubnetgit"
  }
}


resource "aws_internet_gateway" "gitigw" {
  vpc_id = aws_vpc.gitvpc.id

  tags = {
    Name = "gitigw"
  }
}




resource "aws_route_table" "gitrtpublic" {
  vpc_id = aws_vpc.gitvpc.id

  route = []

  tags = {
    Name = "gitrtpublic"
  }
}

