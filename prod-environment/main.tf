# Calling from child-module #

module "vpc" {
  source = "../child-modules/vpc"

  project_name           = var.project_name
  region                 = var.region
  instance_tenancy       = var.instance_tenancy
  instance_class         = var.instance_class
  instance_type          = var.instance_type
  ami                    = var.ami
  vpc_cidr_block         = var.vpc_cidr_block
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support     = var.enable_dns_support
  pubsub_cidrs           = var.pubsub_cidrs
  ptesub_cidrs           = var.ptesub_cidrs
  internet_gateway       = var.internet_gateway
  nat_gateway            = var.nat_gateway
  nat_gateway_route_cidr = var.nat_gateway_route_cidr
  storage_type           = var.storage_type
  identifier             = var.identifier
  username               = var.username
  engine_version         = var.engine_version
  allocated_storage      = var.allocated_storage
  inbound_ports          = var.inbound_ports
  domain_name            = var.domain_name
  alternative_name       = var.alternative_name
  key_name               = var.key_name
  container_name         = var.container_name
  container_port         = var.container_port
  load_balancer_type     = var.load_balancer_type
  target_type            = var.target_type
  skip_final_snapshot    = var.skip_final_snapshot
  engine                 = var.engine
  password               = var.password
  cluster_name           = var.cluster_name
  publicly_accessible    = var.publicly_accessible
  records                = var.records
  validation_method      = var.validation_method
  private_zone           = var.private_zone
  network_mode           = var.network_mode
  launch_configuration_name = var.launch_configuration_name
  aws_ecs_task_definition = var.aws_ecs_task_definition
} 




