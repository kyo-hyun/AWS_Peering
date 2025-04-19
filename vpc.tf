locals {
  seoul_vpc_list = {
    "seoul-vpc"  = {
      cidr_block = "10.0.0.0/16"

      subnet = {
        "seoul-Subnet" = {
          cidr_block              = "10.0.0.0/24"
          availability_zone       = "ap-northeast-2a"
          map_public_ip_on_launch = "true"
        }
      }
    }
  }

  tokyo_vpc_list = {
    "tokyo-vpc" = {
      cidr_block = "11.0.0.0/16"

      subnet = {
        "tokyo-Subnet" = {
          cidr_block              = "11.0.0.0/24"
          availability_zone       = "ap-northeast-1a"
          map_public_ip_on_launch = "true"
        }
      }
    }
  }
}

module "vpc_seoul" {
  source     = "./module/VPC"
  for_each   = local.seoul_vpc_list

  providers = {
    aws = aws.seoul
  }

  name       = each.key
  cidr_block = each.value.cidr_block
  subnet     = each.value.subnet
}

module "vpc_tokyo" {
  source     = "./module/VPC"
  for_each   = local.tokyo_vpc_list

  providers = {
    aws = aws.tokyo
  }

  name       = each.key
  cidr_block = each.value.cidr_block
  subnet     = each.value.subnet
}