# aws vpc #

resource "aws_vpc" "sika_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = {
    Name = "${var.project_name}-vpc"
  }
}



# use data source to get all avalablility zones in region #

data "aws_availability_zones" "available" {
  state = "available"
}


# aws subnets #

resource "aws_subnet" "sika_pubsub" {
  count                   = 2
  vpc_id                  = aws_vpc.sika_vpc.id
  cidr_block              = var.pubsub_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "sika_pubsub_${count.index + 1}"
  }
}


resource "aws_subnet" "sika_ptesub" {
  count             = 2
  vpc_id            = aws_vpc.sika_vpc.id
  cidr_block        = var.ptesub_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "sika_ptesub_${count.index + 1}"
  }
}


# aws route tables #

resource "aws_route_table" "sika_pubrt" {
  vpc_id = aws_vpc.sika_vpc.id

  tags = {
    Names = "${var.project_name}-pubrt"
  }
}


resource "aws_route_table" "sika_ptert" {
  vpc_id = aws_vpc.sika_vpc.id

  tags = {
    Names = "${var.project_name}-ptert"
  }
}


# Route table association to subnets #

resource "aws_route_table_association" "sika_pubrt_association" {
  count          = 2
  subnet_id      = aws_subnet.sika_pubsub[count.index].id
  route_table_id = aws_route_table.sika_pubrt.id
}


resource "aws_route_table_association" "sika_ptert_association" {
  count          = 2
  subnet_id      = aws_subnet.sika_ptesub[count.index].id
  route_table_id = aws_route_table.sika_ptert.id
}


# Internet gateway attached to vpc #

resource "aws_internet_gateway" "sika_IGW" {
  vpc_id = aws_vpc.sika_vpc.id

  tags = {
    Name = var.internet_gateway
  }
}


# Routing IGW to public route table #

resource "aws_route" "IGW_route" {
  route_table_id         = aws_route_table.sika_pubrt.id
  gateway_id             = aws_internet_gateway.sika_IGW.id
  destination_cidr_block = "0.0.0.0/0"
}


# Ellastic ip #

resource "aws_eip" "eip" {

  tags = {
    name = "${var.project_name}-eip"
  }
}

# Resource Nat gateway #

resource "aws_nat_gateway" "sika_nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.sika_pubsub[0].id

  tags = {
    Name = "${var.project_name}-nat_gateway"
  }
}

# Routing Nat Gateway to private RT # 

resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.sika_ptert.id
  gateway_id             = aws_nat_gateway.sika_nat_gateway.id
  destination_cidr_block = var.nat_gateway_route_cidr
}




















# aws listener configs #

# resource "aws_lb_listener" "sika_lt" {
#   load_balancer_arn = aws_lb.sika_lb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.sika_tgp.arn
#   }
# }