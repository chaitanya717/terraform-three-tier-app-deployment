variable "iam-instance-profile-name" {}
variable "iam-instance-role-name" {}
variable "iam-instance-role-policy-name" {}

data "aws_caller_identity" "current" {}

output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_ecr_connection.name
}
resource "aws_iam_instance_profile" "ec2_ecr_connection" {
  name = var.iam-instance-profile-name
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = var.iam-instance-role-name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "access_ecr_policy" {
  name = var.iam-instance-role-policy-name
  role = aws_iam_role.role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}