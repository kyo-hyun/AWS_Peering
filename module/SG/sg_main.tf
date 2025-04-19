resource "aws_security_group" "allow_ssh" {
  name        = var.name
  vpc_id      = var.vpcid

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_security_group_egress_rule" "example" {
  security_group_id = aws_security_group.allow_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 1084

  tags = {
    Name = "allow_all_egress"
  }
}

module "rule" {
  source            = "./module/SG_IP_Rule"
  for_each          = var.ingress_rule
  name              = each.key
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
}