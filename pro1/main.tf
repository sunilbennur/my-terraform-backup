terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.32"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAQYHNDBVNNEBT5I6K"
  secret_key = "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"
}

# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "dev" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "dev"
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "dev-public-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-1b"

  tags = {
    Name = "dev-public-1"
  }
}

resource "aws_subnet" "dev-public-2" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-1b"

  tags = {
    Name = "dev-public-2"
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "dev"
  }
}

# Creating Route Tables for Internet gateway
resource "aws_route_table" "dev-public" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = "dev-public-1"
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "dev-public-1-a" {
  subnet_id      = aws_subnet.dev-public-1.id
  route_table_id = aws_route_table.dev-public.id
}

resource "aws_route_table_association" "dev-public-2-a" {
  subnet_id      = aws_subnet.dev-public-2.id
  route_table_id = aws_route_table.dev-public.id
}


# Creating EC2 instances in public subnets
resource "aws_instance" "public_inst_1" {
  ami           = "ami-03f6d497fceb40069"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev-public-1.id
#  key_name      = "terraform.pem"
  tags = {
    Name = "public_inst_1"
  }
}

resource "aws_instance" "public_inst_2" {
  ami           = "ami-03f6d497fceb40069"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev-public-2.id
 # key_name      = "key11"
  tags = {
    Name = "public_inst_2"
  }
}

