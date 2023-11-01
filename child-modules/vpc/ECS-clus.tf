# ecs svc #

resource "aws_ecs_service" "sika-svc" {
  name                               = "${var.project_name}-svc"
  cluster                            = aws_ecs_cluster.sika-cluster.name
  task_definition                    = aws_ecs_task_definition.sika-task-definition.arn
  desired_count                      = 4
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  platform_version                   = "LATEST"
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = ["${aws_security_group.sika-sg.id}"]
    subnets          = [aws_subnet.sika_ptesub[0].id, aws_subnet.sika_ptesub[1].id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.sika-TgtGP.arn
    container_name  = var.container_name
    container_port  = var.container_port
  }

}
  
  # aws cluster #

resource "aws_ecs_cluster" "sika-cluster" {
  name = "${var.project_name}-cluster"
}
  
  
  
  
