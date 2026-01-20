terraform {
  backend "s3" {
    bucket       = "s3bucket-eks-labs"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = false
    encrypt      = true
  }

  required_version = "~> 1.14.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.1"
    }
  }
}

provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      Environment = "dev"
      Project     = "eks"
      Owner       = "rihad"
      Terraform   = "true"
    }
  }
}

