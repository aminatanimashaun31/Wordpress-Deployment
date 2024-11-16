resource "aws_ecs_cluster" "main" {
  name = "wordpress-cluster"
}



resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count   = 1

  launch_type = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups = [aws_security_group.web_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.wordpress_tg.arn
    container_name   = "wordpress"
    container_port   = 80
  }

  depends_on = [aws_lb.main]
}

resource "aws_ecs_task_definition" "wordpress" {
  family                   = "wordpress"
  execution_role_arn      = aws_iam_role.ecs_task_role.arn
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"] 
  cpu                      = "256"        
  memory                   = "512"        
  container_definitions    = jsonencode([
    {
      name      = "wordpress"
      image     = "wordpress:latest"
      memory    = 512
      cpu       = 256
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
        
      ]
      environment = [
        {
          name  = "WORDPRESS_DB_HOST"
          value = aws_db_instance.wordpress_db.endpoint
        },
        {
          name  = "WORDPRESS_DB_USER"
          value = var.db_user
        },
        {
          name  = "WORDPRESS_DB_PASSWORD"
          value = var.db_password
        },
        {
          name  = "WORDPRESS_DB_NAME"
          value = "wordpress"
        },
      ]
    }
  ])
}

