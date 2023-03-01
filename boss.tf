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

resource "aws_subnet" "prisubnetgit" {
  vpc_id     = aws_vpc.gitvpc.id
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "prisubnetgit"
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

resource "aws_route_table" "gitrtprivate" {
  vpc_id = aws_vpc.gitvpc.id

  route = []

  tags = {
    Name = "gitrtprivate"
  }
}


resource "aws_route_table_association" "gitprirtassoc" {
  subnet_id      = aws_subnet.prisubnetgit.id
  route_table_id = aws_route_table.gitrtprivate.id
}

