# Security  Group #

locals {
  inbound_ports  = var.inbound_ports
  outbound_ports = var.outbound_ports
}

resource "aws_security_group" "sika-sg" {
  vpc_id      = aws_vpc.sika_vpc.id
  name        = "${var.project_name}-sg"
  description = "Allow ssh, Http"


  dynamic "ingress" {
    for_each = var.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.outbound_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }
}