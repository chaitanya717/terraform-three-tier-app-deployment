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
    associate_carrier_ip_address = true
    security_groups = var.security_groups_presentetion_tier
  }

  user_data = base64decode(  
   <<-EOF
    #!/bin/bash
    echo "Configuring presentation tier"
    echo "Load balancer: ${application_load_balancer}"
    echo "ECR URL: ${ecr_url}"
    echo "ECR Repo: ${ecr_repo_name}"
    echo "Region: ${region}"
  EOF
  )

  depends_on = [ var.load_balancer_application_tier ]
}
