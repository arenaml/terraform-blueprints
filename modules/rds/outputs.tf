output "address" {
  description = "RDS instance hostname"
  value       = aws_db_instance.this.address
  sensitive   = true
}

output "port" {
  description = "RDS instance port"
  value       = aws_db_instance.this.port
  sensitive   = true
}

output "username" {
  description = "RDS instance root username"
  value       = aws_db_instance.this.username
  sensitive   = true
}
