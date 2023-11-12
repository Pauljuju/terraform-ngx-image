#Create a hosted zone for RT 53 #

data "aws_route53_zone" "selected" {
  name = var.domain_name

}


# Create Route53 A record #

resource "aws_route53_record" "route53-record-dns" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "www.${data.aws_route53_zone.selected.name}"
  type    = "A"
  ttl     = "300"
  records = var.records

}




