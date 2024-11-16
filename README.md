# Wordpress-Deployment
Secure WordPress site using Amazon ECS with AWS Fargate, Amazon EFS, and Amazon RDS. 
Overview
This project demonstrates how to deploy a secure WordPress site using Amazon ECS with AWS Fargate, Amazon EFS, and Amazon RDS, all managed through Terraform. The deployment ensures the use of environment variables for sensitive data and implements best practices for security and scalability.

#Architecture
My wordpress site was deployed using Elastic Container Service(ECS). I started by creating my own VPC, Security group, load balancer and target group using terraform. Then i created my task definition in my ECS and created my service from ECS.
My domain(aminat.com.ng) was mapped to aws route 53, i set up SSL certificate and configured SSL offloading on my load balancer. My wordpress site is secured, optimised and ready for public.

#Components
VPC: A new Virtual Private Cloud (VPC) with public and private subnets.
Load Balancer: An Application Load Balancer (ALB) for traffic distribution and SSL termination.
ECS & Fargate: Deployment of WordPress on ECS using Fargate with Amazon EFS for shared storage.
RDS Database: Amazon RDS (MySQL/MariaDB) configured in a private subnet for the WordPress database.
Domain Management: Domain managed via Route 53 and secured with SSL/TLS using AWS Certificate Manager (ACM).

#Getting Started
#Prerequisites
-Terraform installed on your local machine.
-AWS CLI installed and configured with your AWS credentials.
-A GitHub account to host your Terraform code.

#Setup Instructions
#Initialize Terraform
terraform init
#Plan the Deployment
terraform plan
#Apply the Configuration
terraform apply
#Access the WordPress Site
Open your web browser and navigate to the domain (e.g., https://aminat.com.ng))
#Screenshots
The screenshots of the deployed resources is been attached to this repository.

#Security Considerations
-All credentials and sensitive data are managed using environment variables, preventing hardcoding within the codebase.
-Security groups and IAM roles are configured to enforce least-privilege access.

#Conclusion
This project successfully deploys a secure and scalable WordPress site on AWS using modern cloud technologies. The infrastructure is fully managed through Terraform, allowing for easy updates and maintenance.
