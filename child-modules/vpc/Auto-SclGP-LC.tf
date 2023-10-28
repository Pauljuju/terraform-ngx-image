resource "aws_autoscaling_group" "sika-ASG" {
  name                      = "sika-group"
  max_size                  = 4
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.sika-launch-conf.name
  vpc_zone_identifier       = aws_subnet.sika_pubsub[*].id
}

resource "aws_launch_configuration" "sika-launch-conf" {
  name                        = var.launch_configuration_name
  image_id                    = var.ami
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  security_groups             = [aws_security_group.sika-sg.id]
  associate_public_ip_address = true
}