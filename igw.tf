locals {
  igw_list = {
    "seoul_igw" = {
      vpc_attach = "seoul-vpc"
    }
  }
}

module "igw" {
  source   = "./module/IGW"
  for_each = local.igw_list

  providers = {
    aws  = aws.seoul
  }

  name   = each.key
  vpc_id = module.vpc_seoul[each.value.vpc_attach].get_vpc_id
}