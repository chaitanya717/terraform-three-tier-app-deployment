app_name = "three-tier"
enviroment = "dev"
region = "eu-west-1"

# vpc configuration variables

cidr_block_vpc = "10.0.0.0/16"
vpc_name = "vpc-three-tier"

public_subnet_cidr = ["10.0.1.0/24","10.0.2.0/24"]
private_subnet_cidr = ["10.0.3.0/24","10.0.4.0/24"]

internet_gateway_name = "internet-getway"
route_table_name_private = "rt-private"
route_table_name_public = "rt-public"
nat_gateway_name = "Nat-public"

# iam role + Policy = iam instance profile

iam-instance-profile-name = "instance_profile_ec2_connection"
iam-instance-role-name = "instance_role_ec2"
iam-instance-role-policy-name = "instance_policy_ecr_connection"

# LAunch template ec2 server variables
key_name = "Server-connect"
launch_template_name_presentetion_tier = "presentation_launch_temp"
instance_type_presentetion_tier = "t2.micro"

launch_template_name_application_tier = "application_launch_temp"
launch_template_name_application_tier = "t2.micro"

# Load Balancer variables

alb_presentation_tier_name = "alb-presentation-tier"
alb_presentation_tier_load_balancer_type = "application"
alb_presentation_tier_enable_deletion_protection = false

alb_application_tier_name = "alb-application-tier"
alb_application_tier_load_balancer_type = "application"
alb_application_tier_enable_deletion_protection = false

# RDS Instance variables
  allocated_storage = 10
  engine_version    = "5.7.31"
  multi_az          = true
  instance_class    = "db.t3.micro"
  engine            = "my-sql"

  # auto scaling group

asg-presentation-tier-name = "Asg-presentation-tier"
asg-presentation-tier-max_size = 4
asg-presentation-tier-min_size = 2
asg-presentation-tier-health_check_grace_period = 300
asg-presentation-tier-health_check_type = "EC2"
asg-presentation-tier-desired_capacity = 2

asg-application-tier-name = "Asg-application-tier"
asg-application-tier-max_size = 4
asg-application-tier-min_size = 2
asg-application-tier-health_check_grace_period = 300
asg-application-tier-health_check_type = "EC2"
asg-application-tier-desired_capacity = 2