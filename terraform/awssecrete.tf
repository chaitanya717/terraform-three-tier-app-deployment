
# Create a secret in AWS Secrets Manager
data "aws_secretsmanager_secret_version" "creds" {
 secret_id = "rdssecrete"
}


locals {
  db_Creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}