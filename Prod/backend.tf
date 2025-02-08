terraform {
  backend "s3" {
    bucket  = "Prod-terraform.tfstate"
    key     = "terraform.tfstate"
    region  = "ap-south-1" # Replace with your AWS region
    encrypt = true
  }
}