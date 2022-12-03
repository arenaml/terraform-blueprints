output "secret-name" {
  value = local.secret_name
}

output "secret-rds-username" {
  value     = local.secrets["${var.name}-rds-username"]
  sensitive = true
}

output "secret-rds-password" {
  value     = local.secrets["${var.name}-rds-password"]
  sensitive = true
}

output "secret-rds-db-name" {
  value     = local.secrets["${var.name}-rds-db-name"]
  sensitive = true
}

output "secret-rds-port" {
  value     = local.secrets["${var.name}-rds-port"]
  sensitive = true
}
