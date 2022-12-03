resource "random_password" "this" {
  length  = 16
  special = false
  # override_special = "!?$"
}

locals {
  secrets = {
    "${var.name}-rds-username" = "postgres"
    "${var.name}-rds-password" = random_password.this.result
    "${var.name}-rds-db-name"  = "${var.name}"
    "${var.name}-rds-port"     = 5432
  }
}
