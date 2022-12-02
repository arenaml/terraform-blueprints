locals {
  cluster_name = "arena-eks"

  vpc_name = "arena-vpc"
  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    managedBy  = "terraform"
    Blueprint  = local.cluster_name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
    app        = "arena"
  }
}