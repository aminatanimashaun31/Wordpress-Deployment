variable "db_user" {
  description = "Database username for WordPress"
  type        = string
}

variable "db_password" {
  description = "Database password for WordPress"
  type        = string
  sensitive   = true
}
