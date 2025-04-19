locals {
  route_table_list_seoul = {
    "seoul-vpc-rt" = {
      vpc_id     = "seoul-vpc"
      subnet_ids = ["seoul-Subnet"]

      routes = {
        1 = {
          destination = "11.0.0.0/16"
          target      = "peer-seoul-tokyo"
        }
      }
    }
  }

  route_table_list_tokyo = {
    "tokyo-vpc-rt" = {
      vpc_id     = "tokyo-vpc"
      subnet_ids = ["tokyo-Subnet"]

      routes = {
        1 = {
          destination = "10.0.0.0/16"
          target      = "peer-seoul-tokyo"
        }
      }
    }
  }
}

module "RouteTable_seoul" {
  source     = "./module/RouteTable"
  for_each   = local.route_table_list_seoul

  providers  = {
    aws = aws.seoul
  }

  name       = each.key
  routes     = [for route_key, route_value in each.value.routes: {
                  "route_key"   = route_key
                  "destination" = route_value.destination
                  "target"      = try(module.region_peer[route_value.target].get_peering_id,null)
                }
              ]
  vpc_id     = module.vpc_seoul[each.value.vpc_id].get_vpc_id
  subnet_ids = {for subnet_id in each.value.subnet_ids : subnet_id => module.vpc_seoul[each.value.vpc_id].get_subnet_id[subnet_id]}
}

module "RouteTable_tokyo" {
  source     = "./module/RouteTable"
  for_each   = local.route_table_list_tokyo

  providers  = {
    aws = aws.tokyo
  }

  name       = each.key
  routes     = [for route_key, route_value in each.value.routes: {
                  "route_key"   = route_key
                  "destination" = route_value.destination
                  "target"      = try(module.region_peer[route_value.target].get_peering_id,null)
                }
              ]
  vpc_id     = module.vpc_tokyo[each.value.vpc_id].get_vpc_id
  subnet_ids = {for subnet_id in each.value.subnet_ids : subnet_id => module.vpc_tokyo[each.value.vpc_id].get_subnet_id[subnet_id]}
}