
data "aws_caller_identity" "current" {}

output "application_tier_template_id" {
  value = aws_launch_template.launch_template_application_tier.id
}
variable "launch_template_name_application_tier" {}
variable "instance_type_application_tier" {}
variable "security_groups_application_tier" {
    type = list()
}
variable "load_balancer_application_tier" {}
variable "ecr_repo_name_application_tier" {}
variable "key_name_application_tier" {}

variable "ecr_repo_name_application_tier" {
  type = string
}
variable "rds_db_adresss" {
  type = string
}
variable "rds_db_admin" {
  type = string
}

variable "rds_db_password" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "db_name" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "instance_class" {
  type = string
}

variable "db_engine" {
  type = string
}
variable "nat_gateway" {}



data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_launch_template" "launch_template_application_tier" {
  name = var.launch_template_name_application_tier

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 8
    }
  }

  iam_instance_profile {
  name = var.iam_instance_profile_name
  }
 key_name = var.key_name_application_tier
  instance_type =  var.instance_type_application_tier
  image_id = data.aws_ami.amazon_linux_2.id
  
  network_interfaces {
    associate_carrier_ip_address = true
    security_groups = var.security_groups_application_tier
  }

 user_data = base64encode(templatefile("./../user-data/user-data-application-tier.sh", {
    rds_hostname  = "${var.rds_db_adresss}",
    rds_username  = "${var.rds_db_admin}",
    rds_password  = "${var.rds_db_password}",
    rds_port      = 3306,
    rds_db_name   ="${var.db_name}",
    ecr_url       = "${var.ecr_url}",
    ecr_repo_name = "${var.ecr_repo_name_application_tier}",
    region        = "${var.region}"
  }))

  depends_on = [ var.nat_gateway ]
}
