variable "arn_presentation_tier_target_group" {}
variable "arn_application_tier_target_group" {}

resource "aws_autoscaling_attachment" "ASG-Atach-presentation_tier" {
  autoscaling_group_name = aws_autoscaling_group.ASG-Presentation-tier.id
  lb_target_group_arn = var.arn_presentation_tier_target_group
}

resource "aws_autoscaling_attachment" "ASG-Atach-application_tier" {
  autoscaling_group_name = aws_autoscaling_group.ASG-Application-tier.id
  lb_target_group_arn = var.arn_application_tier_target_group
}