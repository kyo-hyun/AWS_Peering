locals {
  security_group_list = {
    "test-sg1" = {
      vpc_id = "seoul-vpc"
      ingress_rule = {
        "Allow_all_protocol" = {
          cidr_ipv4   = "0.0.0.0/0"
          from_port   = 0
          to_port     = 60000
          ip_protocol = "tcp"
        }
      }
    }
  }
}

module "sg" {
  source       = "./module/SG"
  for_each     = local.security_group_list

  providers    = {
    aws        = aws.seoul
  }

  name         = each.key
  ingress_rule = each.value.ingress_rule
  vpcid        = module.vpc_seoul[each.value.vpc_id].get_vpc_id
}