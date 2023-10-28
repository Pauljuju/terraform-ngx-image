output "vpc_id" {
  value = aws_vpc.sika_vpc.id
}

output "public_subnets_id" {
  value = aws_subnet.sika_pubsub[*].id
}

output "private_subnets_id" {
  value = aws_subnet.sika_ptesub[*].id
}

output "security_group_id" {
  value = aws_security_group.sika-sg.id
}


output "domain_name" {
  value = var.domain_name
}

output "certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn
}


