# lb config #

resource "aws_lb" "sika-lb" {
  name               = "${var.project_name}-sika-lb"
  internal           = true
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.sika-sg.id]
  subnets            = aws_subnet.sika_pubsub[*].id
}


# Tgt GP #

resource "aws_lb_target_group" "sika-TgtGP" {
  name        = "${var.project_name}-TgtGP"
  target_type = var.target_type
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.sika_vpc.id
}

# listener #

resource "aws_lb_listener" "sika-listiner" {
  load_balancer_arn = aws_lb.sika-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sika-TgtGP.arn
  }
}






#   health_check {
#     interval            = 30
#     path                = "/"
#     protocol            = "HTTP"
#     timeout             = 5
#     healthy_threshold   = 5
#     unhealthy_threshold = 2
#   }
# }
