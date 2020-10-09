provider "aws" {
  profile = "default"
}

terraform {
  required_version = "~> 0.13.0"

  backend "s3" {
    bucket = "terraform-efs-sls-deployment"
    key    = "dev/terraform.tfstate"
  }
}

module "efs" {
  source      = "../modules/efs"
  env_name    = "dev"
  vpc_id      = var.vpc_id
  subnet_id_a = var.subnet_id_a
  subnet_id_b = var.subnet_id_b
  subnet_id_c = var.subnet_id_c
}
