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

output "rds_instance_hostname" {
  value = aws_db_instance.rds-instance.address
}

resource "aws_db_instance" "rds-instance" {
  allocated_storage = var.allocated_storage
  engine_version = var.engine_version
  multi_az = var.multi_az
  db_name = var.db_name
  username = var.rds_db_admin
  password = var.rds_db_password
  instance_class = var.instance_class
  engine = var.db_engine
}