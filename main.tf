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

/*resource "aws_instance" "my_vm" {
  instance_type = "t2.micro"
  ami           = "ami-09208e69ff3feb1db" //Ubuntu AMI

  tags = {
    Name = "ubuntu_server1"
  }
}
*/
resource "awc_vpc" "my_first_vpc" {
  cidr_block                     = "10.0.0.0/16"
  instance_tenancy               = "default"
  enable_dns_support             = "true"
  enable_dns_hostnames           = "true"
  enable_classiclink             = "fals"
#  enable_classiclink_dns_support = "true"

  tags = {
    Name = "production"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = awc_vpc.my_first_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "prod-subnet"
  }
}
