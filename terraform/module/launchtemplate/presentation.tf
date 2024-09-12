# global for this module 
variable "ecr_url" {}
variable "region" {}
# ==========
output "presentation_tier_template_id" {
  value = aws_launch_template.launch_template_presentetion_tier.id
}

variable "iam_instance_profile_name" {}
variable "launch_template_name_presentetion_tier" {}
variable "instance_type_presentetion_tier" {}
variable "security_groups_presentetion_tier" {
    type = list(string)
}
variable "key_name_presentation_tier" {
  
}
variable "load_balancer_presentetion_tier" {}

variable "ecr_repo_name_presentetion_tier" {}

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


resource "aws_launch_template" "launch_template_presentetion_tier" {
  name = var.launch_template_name_presentetion_tier
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 8
    }
  }

  iam_instance_profile {
  name = var.iam_instance_profile_name
  }

  key_name = var.key_name_presentation_tier
  instance_type =  var.instance_type_presentetion_tier
  image_id = data.aws_ami.amazon_linux_2.id
  
  network_interfaces {
    security_groups = var.security_groups_presentetion_tier
  }

  user_data = base64encode(
  <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install docker -y
  sudo service docker start
  sudo systemctl enable docker
  sudo usermod -a -G docker ubuntu

  # Login to AWS ECR
  aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${var.ecr_url}

  # Run the Docker container
  docker run --restart always -e APPLICATION_LOAD_BALANCER=${var.load_balancer_application_tier.dns_name} -p 3000:3000 -d ${var.ecr_url}/${var.ecr_repo_name_presentetion_tier}:latest
  EOF
)


  depends_on = [ var.load_balancer_application_tier ]
}
