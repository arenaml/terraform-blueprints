terraform {
  required_version = "~> 1.2.0"

  backend "s3" {
    bucket  = "arena-tfstate-bucket"
    key     = "arena/terraform.tfstate"
    region  = "eu-west-1"
    profile = "personal"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.7.0"
    }
    random = ">= 2.1"
  }
}