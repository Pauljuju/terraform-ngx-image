# creating RDS using postgreSQL#

resource "aws_db_instance" "database" {
  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  allocated_storage    = var.allocated_storage
  instance_class       = var.instance_class
  storage_type         = var.storage_type
  username             = var.username
  password             = var.password
  publicly_accessible  = var.publicly_accessible
  skip_final_snapshot  = var.skip_final_snapshot
  parameter_group_name = "default.postgres14"
}


 # Create db Subnet Group #

resource "aws_db_subnet_group" "dbsubnetgroup" {
  name       = "${var.project_name}-dbsgp"
  subnet_ids = [aws_subnet.sika_ptesub[0].id, aws_subnet.sika_ptesub[1].id]

  tags = {
    Name = "${var.project_name}-dbsgp"
  }
}

# postgreSQL sg #

resource "aws_security_group" "postgres-sg" {
  name        = "postgres-sg"
  description = "Allow postgres inbound traffic"
  vpc_id      = aws_vpc.sika_vpc.id

  ingress {
    description = "TLS from postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-postgres-sg"
  }
}

















# #rds security GP #
# resource "aws_db_subnet_group" "subnet-group" {
#   name       = "postgreSQL"
#   subnet_ids = [aws_subnet.Final-proj-Pri-Sub.id, aws_subnet.Final-proj-Pri-Sub-2.id]

#   tags = {
#     Name = "My DB subnet group"
#   }
# }


# parameter_group_name = "default.postgres15"