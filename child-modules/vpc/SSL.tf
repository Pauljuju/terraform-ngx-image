# Req a certificate form ACM #

resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
}


# Get details about RT 53 hosted zone #

data "aws_route53_zone" "hosted_zone" {
  name         = var.domain_name
  private_zone = var.private_zone
}


# Create a record set for route53 domain validation #

resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
}

# validating acm/ssl certificate #

resource "aws_acm_certificate_validation" "certificate" {
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}