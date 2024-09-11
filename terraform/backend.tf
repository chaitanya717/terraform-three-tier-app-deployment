terraform {
  backend "s3" {
    bucket = "value"
    key = "./terraform.state"
    region = "eu-west-1"
  }
}