terraform {
  backend "s3" {
    bucket = "threetierroute53state"
    key = "./terraform.tfstate"
    region = "eu-west-1"
  }
  
}