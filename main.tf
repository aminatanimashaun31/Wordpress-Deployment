terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}



resource "aws_lb" "main" {
  name               = "wordpress-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

resource "aws_lb_target_group" "wordpress_tg" {
  name     = "wordpress-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  target_type = "ip"  # ECS uses IP-based targets by default
}

resource "aws_db_instance" "wordpress_db" {
  engine         = "mysql"
  engine_version    = "8.0.40"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  username       = var.db_user
  password       = var.db_password
  identifier    = "wordpress-db"
  skip_final_snapshot  = true
  db_name       = "wordpress"
  #  final_snapshot_identifier = "wordpress-db-final-snapshot"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}



resource "aws_efs_file_system" "wordpress_efs" {
  creation_token = "wordpress-efs"
}




