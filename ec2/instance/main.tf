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
