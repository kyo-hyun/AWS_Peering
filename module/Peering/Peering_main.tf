resource "aws_vpc_peering_connection" "peer" {
  provider     = aws.seoul
  vpc_id       = var.requester_vpc
  peer_vpc_id  = var.accepter_vpc
  peer_region  = "ap-northeast-1"
  auto_accept  = false
}

resource "aws_vpc_peering_connection_accepter" "peer_accept" {
  provider                    = aws.tokyo
  vpc_peering_connection_id   = aws_vpc_peering_connection.peer.id
  auto_accept                 = true
}