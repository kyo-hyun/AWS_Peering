terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.93.0"
    }
  }

  required_version = ">=1.0"
}

provider "aws" {
  alias      = "seoul"
  region     = "ap-northeast-2"
}

provider "aws" {
  alias      = "tokyo"
  region     = "ap-northeast-1"
}