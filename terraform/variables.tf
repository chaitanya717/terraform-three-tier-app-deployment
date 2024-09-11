variable "app_name" {}
variable "enviroment" {}

variable "cidr_block_vpc" {}

variable "vpc_name" {}
variable "public_subnet_cidr" {
  type = list(string)
  }
variable "private_subnet_cidr" {
  type = list(string)
  }

variable "internet_gateway_name" {}
variable "route_table_name_private" {}
variable "route_table_name_public" {}
variable "nat_gateway_name" {}

variable "iam-instance-profile-name" {}
variable "iam-instance-role-name" {}
variable "iam-instance-role-policy-name" {}



variable "iam_instance_profile_name" {}
variable "region" {}

variable "key_name" {}
variable "public_key" {
  type = string
  sensitive = true
}
variable "launch_template_name_presentetion_tier" {}
variable "instance_type_presentetion_tier" {}

variable "launch_template_name_application_tier" {}
variable "instance_type_application_tier" {}



variable "alb_presentation_tier_name" {}
variable "alb_presentation_tier_load_balancer_type" {}
variable "alb_presentation_tier_enable_deletion_protection" {}

variable "alb_application_tier_name" {}
variable "alb_application_tier_load_balancer_type" {}
variable "alb_application_tier_enable_deletion_protection" {}


# rds variables

# variable "rds_db_password" {
#   type = string
# }

variable "multi_az" {
  type = bool
}

# variable "db_name" {
#   type = string
# }

variable "engine_version" {
  type = string
  # default = "5.7.31"
}

variable "allocated_storage" {
  type = number
  # default = 10
}

variable "instance_class" {
  type = string
  # default = "db.t3.micro"
}

variable "db_engine" {
  type = string
  # default = "mysql"
}

# auto scaling

variable "asg-presentation-tier-name" {}
variable "asg-presentation-tier-max_size" {
    type = number
}
variable "asg-presentation-tier-min_size" {
    type = number
}
variable "asg-presentation-tier-health_check_grace_period" {
    type = number
}
variable "asg-presentation-tier-health_check_type" {}
variable "asg-presentation-tier-desired_capacity" {
   type = number
}


variable "asg-application-tier-name" {}
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
