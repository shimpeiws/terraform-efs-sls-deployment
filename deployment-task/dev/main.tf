provider "aws" {
  profile = "default"
}

terraform {
  required_version = "~> 0.13.0"

  backend "s3" {
    bucket = "terraform-efs-sls-deployment"
    key    = "deployment-task/dev/terraform.tfstate"
  }
}

module "ecs" {
  source    = "../modules/ecs"
  env_name  = "dev"
  image_uri = var.image_uri
}
