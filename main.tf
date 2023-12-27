resource "aws_security_group" "sample_sg" {
  name        = "dev-sg-terraformtest-aps1"
  vpc_id      = var.vpc_id
  description = "delete after testing"

  tags = {
    Name       = "dev-sg-terraformtest-aps1"
    Category   = "dev"
    Project    = "ops-shared"
    Department = "all"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_all" {
  security_group_id = aws_security_group.sg_influxdb.id
  ip_protocol       = -1
  from_port         = -1
  to_port           = -1
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  security_group_id = aws_security_group.sample_sg.id
  ip_protocol       = "tcp"
  from_port         = var.port
  to_port           = var.port
  cidr_ipv4         = var.source_cidr
}
