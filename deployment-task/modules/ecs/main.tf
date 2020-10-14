resource "aws_ecs_cluster" "deployment_task" {
  name = "deployment-task-${var.env_name}"
}


data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy
}

resource "aws_ecs_task_definition" "deployment" {
  family                   = "efs-sls-deployment-${var.env_name}"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = <<DEFINITION
  [
    {
      "name": "deployment-${var.env_name}",
      "image": "${var.image_uri}",
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "ap-northeast-1",
          "awslogs-stream-prefix": "deployment-task-${var.env_name}",
          "awslogs-group": "/deployment-task/${var.env_name}"
        }
      }
    }
  ]
  DEFINITION

  task_role_arn      = var.ecs_task_execution_role_iam_role_arn
  execution_role_arn = var.ecs_task_execution_role_iam_role_arn
}

resource "aws_cloudwatch_log_group" "fargate_log_group" {
  name              = "/fargate/run-task"
  retention_in_days = 180
}
