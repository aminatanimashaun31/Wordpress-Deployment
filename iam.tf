resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}




# Define the IAM Policy with ECS and CloudWatch Logs full access
resource "aws_iam_policy" "ecs_and_logs_full_access" {
  name        = "ECSAndLogsFullAccessPolicy"
  description = "Policy with full access to ECS and CloudWatch Logs"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "ecs:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "logs:*",
        "Resource": "*"
      }
    ]
  })
}

# Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "ecs_task_full_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_and_logs_full_access.arn
}
