variable "alb_presentation_tier_name" {}
variable "alb_presentation_tier_load_balancer_type" {}
variable "alb_presentation_tier_security_groups" {}
variable "alb_presentation_tier_subnets" {}
variable "alb_presentation_tier_enable_deletion_protection" {}

variable "alb_application_tier_name" {}
variable "alb_application_tier_load_balancer_type" {}
variable "alb_application_tier_security_groups" {}
variable "alb_application_tier_subnets" {}
variable "alb_application_tier_enable_deletion_protection" {}


output "presentation_alb" {
  value = aws_lb.presentation_tier_lb
}
output "application_alb" {
  value = aws_lb.application_tier_lb
}

output "target_group_presentation_tier_arn" {
  value = aws_lb_target_group.presentetion-tg.arn
}
output "target_group_application_tier_arn" {
  value = aws_lb_target_group.application-tg.arn
}

variable "vpc_id" {}
resource "aws_lb" "presentation_tier_lb" {
  name = var.alb_presentation_tier_name
  internal = false
  load_balancer_type = var.alb_presentation_tier_load_balancer_type
  security_groups = var.alb_presentation_tier_security_groups
  subnets = var.alb_presentation_tier_subnets

  enable_deletion_protection = var.alb_presentation_tier_enable_deletion_protection
}


resource "aws_lb_target_group" "presentetion-tg" {
  name = "presentation-tg"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_alb_listener" "presentation_tier_lb_listener" {
 load_balancer_arn = aws_lb.presentation_tier_lb.arn
 port = "80"
 protocol = "HTTP"

 default_action {
   type =  "forward"
   target_group_arn = aws_lb_target_group.presentetion-tg.arn

 }

}



resource "aws_lb" "application_tier_lb" {
  name = var.alb_application_tier_name
  internal = false
  load_balancer_type = var.alb_application_tier_load_balancer_type
  security_groups = var.alb_application_tier_security_groups
  subnets = var.alb_application_tier_subnets

  enable_deletion_protection = var.alb_application_tier_enable_deletion_protection
}


resource "aws_lb_target_group" "application-tg" {
  name = "application-tg"
  port = 3000
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_alb_listener" "application_tier_lb_listener" {
 load_balancer_arn = aws_lb.application_tier_lb.arn
 port = "80"
 protocol = "HTTP"

 default_action {
   type =  "forward"
   target_group_arn = aws_lb_target_group.presentetion-tg.arn
 }

}
