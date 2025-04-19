locals {
  route_table_list = {
    "rt-test" = {
      vpc_id     = "seoul-vpc"
      subnet_ids = ["seoul-Subnet"]

      routes = {
        1 = {
          destination = "0.0.0.0/0"
          target      = "seoul_igw"
        }

        2 = {
          destination = "11.0.0.0/16"
          target      = "peer-seoul-tokyo"
        }
      }
    }
  }
}

module "RouteTable" {
  source     = "./module/RouteTable"
  for_each   = local.route_table_list

  providers  = {
    aws = aws.seoul
  }

  name       = each.key
  routes     = [for route_key, route_value in each.value.routes: {
                  "route_key"   = route_key
                  "destination" = route_value.destination
                  "target"      = try(module.igw[route_value.target].get_igw_id, module.region_peer[route_value.target].get_peering_id)
                }
              ]
  vpc_id     = module.vpc_seoul[each.value.vpc_id].get_vpc_id
  subnet_ids = { for subnet_id in each.value.subnet_ids : subnet_id => module.vpc_seoul[each.value.vpc_id].get_subnet_id[subnet_id] }
}