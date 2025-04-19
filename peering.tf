locals {
    multi_region_peering = {
        "peer-seoul-tokyo" = {
            requester_vpc    = "seoul-vpc"
            accepter_vpc     = "tokyo-vpc"
        }
    }
}

module "region_peer" {
    source          = "./module/Peering"
    for_each        = local.multi_region_peering

    providers   = {
        aws.seoul = aws.seoul
        aws.tokyo = aws.tokyo
    }

    requester_vpc   = module.vpc_seoul[each.value.requester_vpc].get_vpc_id
    accepter_vpc    = module.vpc_tokyo[each.value.accepter_vpc].get_vpc_id
}