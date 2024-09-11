
variable "asg-application-tier-name" {
     type = string
}
variable "asg-application-tier-max_size" {
     type = number
}
variable "asg-application-tier-min_size" {
     type = number
}
variable "asg-application-tier-health_check_grace_period" {
     type = number
}
variable "asg-application-tier-health_check_type" {}
variable "asg-application-tier-desired_capacity" {
     type = number
}

variable "asg-application-tier-vpc_zone_identifier" {}
variable "asg-application-tier-launch_template_id" {
    type = string
}


resource "aws_autoscaling_group" "ASG-Application-tier" {
  name = var.asg-application-tier-name
  max_size = var.asg-application-tier-max_size
  min_size = var.asg-application-tier-min_size
  health_check_grace_period = var.asg-application-tier-health_check_grace_period
  health_check_type = var.asg-application-tier-health_check_type
  desired_capacity = var.asg-application-tier-desired_capacity
  vpc_zone_identifier = var.asg-application-tier-vpc_zone_identifier

  launch_template {
    id = var.asg-application-tier-launch_template_id
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