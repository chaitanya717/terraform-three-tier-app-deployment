
module "vpc" {
source = "./module/vpc"
cidr_block_vpc = var.cidr_block_vpc
vpc_name = var.vpc_name
app_name = var.app_name
enviroment = var.enviroment
public_subnet_cidr = var.public_subnet_cidr
private_subnet_cidr = var.private_subnet_cidr
internet_gateway_name = var.internet_gateway_name
route_table_name_private = var.route_table_name_private
route_table_name_public = var.route_table_name_public
nat_gateway_name = var.nat_gateway_name
}

# module "security_groups" {
#   source = "./module/security-group"
#   app_name = var.app_name
#   enviroment = var.enviroment
#   vpc_id = module.vpc.vpc_id
# }

# module "iam-profile" {
#   source = "./module/iam-roles"
#   iam-instance-profile-name = var.iam-instance-profile-name
#   iam-instance-role-name = var.iam-instance-role-name
#   iam-instance-role-policy-name = var.iam-instance-role-policy-name
# }

# module "ec2_servers" {
# source = "./module/launchtemplate"
# iam_instance_profile_name = module.iam-profile.iam_instance_profile_name
# region = var.region
# key_name = var.key_name
# public_key = local.db_Creds.publickey

# launch_template_name_presentetion_tier = var.launch_template_name_presentetion_tier
# instance_type_presentetion_tier = var.instance_type_presentetion_tier
# key_name_presentation_tier = var.key_name
# security_groups_presentetion_tier = [module.security_groups.presentation_tier_sg_id]
# load_balancer_presentetion_tier = module.loab_balancer.presentation_alb
# ecr_url = local.db_Creds.ecr_url
# ecr_repo_name_presentetion_tier = local.db_Creds.frontend_repo_ecr

# #  application tier
# db_name = local.db_Creds.rdsdb 
# rds_db_admin =  local.db_Creds.rdsusername
# rds_db_password = local.db_Creds.rdspassword
# rds_db_adresss = module.rds_instance.rds_instance_hostname

# multi_az = var.multi_az
# engine_version = var.engine_version
# db_engine = var.db_engine
# instance_class = var.instance_class
# allocated_storage = var.allocated_storage
# key_name_application_tier = var.key_name
# load_balancer_application_tier = module.loab_balancer.application_alb
# launch_template_name_application_tier = var.launch_template_name_application_tier
# instance_type_application_tier = var.instance_type_application_tier
# ecr_repo_name_application_tier = local.db_Creds.backend_repo_ecr
# security_groups_application_tier = [module.security_groups.application_tier_sg_id]
# nat_gateway = module.vpc.natgetway
# }

# module "loab_balancer" {
# source = "./module/Alb"
# vpc_id = module.vpc.vpc_id

# alb_presentation_tier_name = var.alb_presentation_tier_name
# alb_presentation_tier_load_balancer_type = var.alb_presentation_tier_load_balancer_type
# alb_presentation_tier_security_groups = [module.security_groups.alb_presentation_tier_sg_id]
# alb_presentation_tier_subnets = module.vpc.public_subnet.*.id
# alb_presentation_tier_enable_deletion_protection = var.alb_presentation_tier_enable_deletion_protection

# alb_application_tier_name = var.alb_application_tier_name
# alb_application_tier_load_balancer_type = var.alb_application_tier_load_balancer_type
# alb_application_tier_security_groups = [module.security_groups.alb_application_tier_sg_id]
# alb_application_tier_subnets = module.vpc.private_subnet.*.id
# alb_application_tier_enable_deletion_protection = var.alb_presentation_tier_enable_deletion_protection
# }

# module "rds_instance" {
#   source = "./module/Rds"
#   db_engine = var.db_engine
#   db_name = local.db_Creds.rdsdb 
#   rds_db_admin =  local.db_Creds.rdsusername
#   rds_db_password = local.db_Creds.rdspassword
#   allocated_storage = var.allocated_storage
#   engine_version = var.engine_version
#   instance_class = var.instance_class
#   multi_az = var.multi_az
# }

# module "autoscaling_group" {
#   source = "./module/AutoScaling"
#   appname = var.app_name
#   env = var.enviroment

# asg-presentation-tier-name = var.asg-presentation-tier-name
# asg-presentation-tier-max_size = var.asg-presentation-tier-max_size
# asg-presentation-tier-min_size = var.asg-presentation-tier-min_size
# asg-presentation-tier-health_check_grace_period = var.asg-presentation-tier-health_check_grace_period
# asg-presentation-tier-health_check_type = var.asg-presentation-tier-health_check_type
# asg-presentation-tier-desired_capacity = var.asg-presentation-tier-desired_capacity
# asg-presentation-tier-launch_template_id = module.ec2_servers.presentation_tier_template_id
# asg-presentation-tier-vpc_zone_identifier = module.vpc.public_subnet.*.id

# asg-application-tier-desired_capacity = var.asg-application-tier-desired_capacity
# asg-application-tier-health_check_grace_period = var.asg-application-tier-health_check_grace_period
# asg-application-tier-health_check_type = var.asg-application-tier-health_check_type
# asg-application-tier-launch_template_id = module.ec2_servers.application_tier_template_id
# asg-application-tier-max_size = var.asg-application-tier-max_size
# asg-application-tier-min_size = var.asg-application-tier-min_size
# asg-application-tier-name = var.asg-application-tier-name
# asg-application-tier-vpc_zone_identifier = module.vpc.private_subnet.*.id

# arn_presentation_tier_target_group = module.loab_balancer.target_group_presentation_tier_arn
# arn_application_tier_target_group = module.loab_balancer.target_group_application_tier_arn
# }
