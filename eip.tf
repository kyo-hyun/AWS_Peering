locals {
  eip_list = {
    "eip_test1" = {

    }
  }
}

module "eip" {
  for_each  = local.eip_list

  providers = {
    aws     = aws.seoul
  }

  source    = "./module/EIP"
  name      = each.key
}