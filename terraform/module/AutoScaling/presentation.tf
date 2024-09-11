variable "appname" {}
variable "env" {}

variable "asg-presentation-tier-name" {}
variable "asg-presentation-tier-max_size" {}
variable "asg-presentation-tier-min_size" {}
variable "asg-presentation-tier-health_check_grace_period" {}
variable "asg-presentation-tier-health_check_type" {}
variable "asg-presentation-tier-desired_capacity" {}

variable "asg-presentation-tier-vpc_zone_identifier" {}
variable "asg-presentation-tier-launch_template_id" {}


resource "aws_autoscaling_group" "ASG-Presentation-tier" {
  name = var.asg-presentation-tier-name
  max_size = var.asg-presentation-tier-max_size
  min_size = var.asg-presentation-tier-min_size
  health_check_grace_period = var.asg-presentation-tier-health_check_grace_period
  health_check_type = var.asg-presentation-tier-health_check_type
  desired_capacity = var.asg-presentation-tier-desired_capacity
  vpc_zone_identifier = var.asg-presentation-tier-vpc_zone_identifier

  launch_template {
    id = var.asg-presentation-tier-launch_template_id
    version = "$Latest"
  }
lifecycle {
  ignore_changes = [ load_balancers,target_group_arns ]
}

tag {
  key = "Name"
  value = "${var.appname}-${var.env}-${var.asg-presentation-tier-name}"
  propagate_at_launch = true
}
}