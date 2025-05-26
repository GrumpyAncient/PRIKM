terraform {
  backend "s3" {
    bucket = "lab6-terraform"
    key    = "lab6/terraform.tfstate"
    region = "eu-north-1"
  }
}
