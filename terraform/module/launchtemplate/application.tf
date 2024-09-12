
data "aws_caller_identity" "current" {}

output "application_tier_template_id" {
  value = aws_launch_template.launch_template_application_tier.id
}

variable "launch_template_name_application_tier" {}
variable "instance_type_application_tier" {}
variable "security_groups_application_tier" {
    type = list(string)
}
variable "load_balancer_application_tier" {}
variable "ecr_repo_name_application_tier" {}
variable "key_name_application_tier" {}

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
variable "db_port" {
  type = number
  default = 3306
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
    security_groups = var.security_groups_application_tier
  }

user_data = base64encode(
  <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install docker -y
  sudo service docker start
  sudo systemctl enable docker
  sudo usermod -a -G docker ec2-user

  aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${var.ecr_url}
  docker run -p 3000:3000 --restart always -e RDS_HOSTNAME=${var.rds_db_adresss} -e RDS_USERNAME=${var.rds_db_admin} -e RDS_PASSWORD=${var.rds_db_password} -e RDS_PORT=${var.db_port} -e RDS_DB_NAME=${var.db_name} -d ${var.ecr_url}/${var.ecr_repo_name_application_tier}:latest
  EOF
)

  depends_on = [ var.nat_gateway ]
}
