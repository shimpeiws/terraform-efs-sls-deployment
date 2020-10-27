variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "image_uri" {
  description = "URI for ECR image"
  type        = string
}

variable "ecs_task_execution_role_iam_role_arn" {
  description = "Arn for IAM Role"
  type        = string
}

variable "file_system_id" {
  description = "EFS File System ID"
  type        = string
}
