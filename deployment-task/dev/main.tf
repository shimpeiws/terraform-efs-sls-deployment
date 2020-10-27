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

module "iam_role" {
  source     = "../modules/iam_role"
  env_name   = "dev"
  identifier = "ecs-tasks.amazonaws.com"
}

module "ecs" {
  source                               = "../modules/ecs"
  env_name                             = "dev"
  image_uri                            = var.image_uri
  ecs_task_execution_role_iam_role_arn = module.iam_role.ecs_task_execution_role_iam_role_arn
  file_system_id                       = var.file_system_id
}
