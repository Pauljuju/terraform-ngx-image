variable "project_name" {
    default = "sika"
}
variable "region" {
    default = "eu-west-2"
}
variable "instance_tenancy" {
    default = "default"
}
variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}
variable "enable_dns_hostnames" {
    default = true
}
variable "enable_dns_support" {
    default = true
}
variable "pubsub_cidrs" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "ptesub_cidrs" {
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "internet_gateway" {
    default = "sika_IGW"
}
variable "nat_gateway" {
    default = "sika_nat_gateway"
}
variable "nat_gateway_route_cidr" {
    default = "0.0.0.0/0"
}
variable "inbound_ports" {
    default = [443]
}
variable "username" {
    default = "dbsika"
}
variable "instance_class" {
    default = "db.t3.micro"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "identifier" {
    default = "database"
}
variable "ami" {
    default = "ami-0b2287cff5d6be10f"
}
variable "engine_version" {
    default = "14.7"
}
variable "allocated_storage" {
    default = 20
}
variable "storage_type" {
    default = "gp2"
}
variable "domain_name" {
    default = "teamjuju.click"
}
variable "alternative_name" {
    default = "*.teamjuju.click"
}
variable "key_name" {
    default = "sika-key-pair"
}
variable "container_name" {
    default = "sika-container-1"
}
variable "container_port" {
    default = 80
}
variable "load_balancer_type" {
    default = "application"
}
variable "target_type" {
    default = "ip"
}
variable "skip_final_snapshot" {
    default = true
}
variable "engine" {
    default = "postgres"
}
variable "password" {
    default = "pw052301"
}
variable "cluster_name" {
    default = "sika-cluster-name" 
}
variable "publicly_accessible" {
    default = true
}
variable "records" {
    default = ["10.0.0.1"]
}
variable "validation_method" {
    default = "DNS"
}
variable "private_zone" {
    default = false
}
variable "network_mode" {
    default = "awsvpc"
}
variable "launch_configuration_name" {
    default = "sika-launch"
}