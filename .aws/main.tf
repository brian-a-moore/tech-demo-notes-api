provider "aws" {
  # profile = "notes-api"
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "access_key" {}
variable "secret_key" {}

data "aws_caller_identity" "current" {}

variable "aws_region" {
  default = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "notes-api-terraform"
    key    = "notes-api.tfstate"
    region = "us-east-1"
  }
}
