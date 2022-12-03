resource "aws_secretsmanager_secret" "this" {
  name = "${var.name}-secrets"
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(local.secrets)
}
