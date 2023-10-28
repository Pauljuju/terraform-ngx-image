# Task definition #

resource "aws_ecs_task_definition" "task-definition" {
  family = "task-defintion"
  network_mode             = var.network_mode
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.sika_iam_role.arn

  # List of cpu and memory at task level #
  cpu       = 256
  memory    = 1024

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = "281056252627.dkr.ecr.eu-west-2.amazonaws.com/rocky-repository:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
    {
      name      = "sika-container-2"
      image     = "281056252627.dkr.ecr.eu-west-2.amazonaws.com/rocky-repository:latest"
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])

  volume {
    name      = "task-definition-storage"
  
  }
}