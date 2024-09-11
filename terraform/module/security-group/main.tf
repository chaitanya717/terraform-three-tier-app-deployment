variable "vpc_id" {}
variable "app_name" {}
variable "enviroment" {}
output "presentation_tier_sg_id" {
  value = aws_security_group.presentation_tier.id
}
output "alb_presentation_tier_sg_id" {
value = aws_security_group.alb_presentation_tier.id
}
output "application_tier_sg_id" {
  value = aws_security_group.application_tier.id
}
output "alb_application_tier_sg_id" {
value = aws_security_group.alb_application_tier.id
}

resource "aws_security_group" "presentation_tier" {
  name        = "${var.enviroment}-${var.app_name}-presentation_tier_connection"
  description = "Allow HTTP requests"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from anywhere"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_presentation_tier.id]
  }

  ingress {
    description     = "HTTP from anywhere"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_presentation_tier.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.enviroment}-${var.app_name}-presentation_tier_sg"
  }
}

resource "aws_security_group" "alb_presentation_tier" {
  name        = "${var.enviroment}-${var.app_name}-alb_presentation_tier_connection"
  description = "Allow HTTP requests"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from anywhere"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.enviroment}-${var.app_name}-alb_presentation_tier_sg"
  }
}

resource "aws_security_group" "application_tier" {
  name        = "${var.enviroment}-${var.app_name}-application_tier_connection"
  description = "Allow HTTP requests"
  vpc_id      = var.vpc_id
  ingress {
    description     = "HTTP from public subnet"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_application_tier.id]
  }

  ingress {
    description     = "HTTP from public subnet"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_application_tier.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.enviroment}-${var.app_name}-application_tier_sg"
  }
}

resource "aws_security_group" "alb_application_tier" {
  name        = "${var.enviroment}-${var.app_name}-alb_application_tier_connection"
  description = "Allow HTTP requests"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP from anywhere"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_tier.id]
  }

  ingress {
    description     = "HTTP from anywhere"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_tier.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.enviroment}-${var.app_name}-alb_application_tier_sg"
  }
}