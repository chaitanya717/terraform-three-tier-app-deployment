
variable "elb_name" { 
}


resource "aws_route53_zone" "three-tier" {
  name = "soilboostertechnologies.in"
}


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.three-tier.id
  name    = "infra.soilboostertechnologies.in"
  type    = "A"

  alias {
    name                   = var.elb_name
    zone_id                = aws_route53_zone.three-tier.id
    evaluate_target_health = true
  }
}