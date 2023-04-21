locals {
  cluster_name = "arena-eks"

  vpc_name = "arena-vpc"
  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    managedBy  = "terraform"
    Blueprint  = local.cluster_name
    GithubRepo = "github.com/arenaml/terraform-blueprints"
    app        = "arena"
  }
}

resource "random_password" "rds" {
  length  = 16
  special = false
  # override_special = "!?$"
}

resource "random_id" "secrets_manager" {
  byte_length = 8
}

locals {
  rds_mlflow_secrets = {
    username = "postgres"
    password = random_password.rds.result
    db_name  = "mlflow"
    port     = 5432
  }
}