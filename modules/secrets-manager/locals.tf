resource "random_password" "this" {
  length  = 16
  special = false
  # override_special = "!?$"
}

resource "random_id" "this" {
  byte_length = 8
}

locals {
  secrets = {
    "${var.name}-rds-username" = "postgres"
    "${var.name}-rds-password" = random_password.this.result
    "${var.name}-rds-db-name"  = "${var.name}"
    "${var.name}-rds-port"     = 5432
  }

  secret_name = "${var.name}-secrets-${random_id.this.hex}"
}
