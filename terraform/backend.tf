terraform {
  backend "s3" {
    bucket = "threetierroute53tfstate"
    key = "./terraform.tfstate"
    region = "eu-west-1"
  }
}